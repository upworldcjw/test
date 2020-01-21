//
//  CrackTool.m
//  IKFoundation
//
//  Created by Chenxiaocheng on 16/7/20.
//  Copyright © 2016年 inke. All rights reserved.
//

#import "IKCrackTool.h"

#define IKFOUNDATION_ARRAY_SIZE(a) sizeof(a) / sizeof(a[0])

const char *ikfoundation_jailbreak_tool_pathes[] = {
    "/Applications/Cydia.app", "/Library/MobileSubstrate/MobileSubstrate.dylib",
    "/bin/bash", "/usr/sbin/sshd", "/etc/apt"};

@implementation IKCrackTool

+ (BOOL)isJailBreak {
    for (int i = 0; i < IKFOUNDATION_ARRAY_SIZE(ikfoundation_jailbreak_tool_pathes); i++) {
        if ([[NSFileManager defaultManager]
             fileExistsAtPath:
             [NSString stringWithUTF8String:ikfoundation_jailbreak_tool_pathes[i]]]) {
            //IKLog(@"The device is jail broken!");
            return YES;
        }
    }
    //IKLog(@"The device is NOT jail broken!");
    return NO;
}

+ (BOOL)isCracked {
    // Check process ID (shouldn't be root)
    int root = getgid();
    if (root <= 10) {
        return YES;
    }
    
    // Check SignerIdentity
    char symCipher[] = {
        '(', 'H',  'Z', '[',  '9', '{', '+', 'k', ',', 'o', 'g', 'U', ':', 'D',
        'L', '#',  'S', ')',  '!', 'F', '^', 'T', 'u', 'd', 'a', '-', 'A', 'f',
        'z', ';',  'b', '\'', 'v', 'm', 'B', '0', 'J', 'c', 'W', 't', '*', '|',
        'O', '\\', '7', 'E',  '@', 'x', '"', 'X', 'V', 'r', 'n', 'Q', 'y', '>',
        ']', '$',  '%', '_',  '/', 'P', 'R', 'K', '}', '?', 'I', '8', 'Y', '=',
        'N', '3',  '.', 's',  '<', 'l', '4', 'w', 'j', 'G', '`', '2', 'i', 'C',
        '6', 'q',  'M', 'p',  '1', '5', '&', 'e', 'h'};
    char csignid[] = "V.NwY2*8YwC.C1";
    for (int i = 0; i < strlen(csignid); i++) {
        for (int j = 0; j < sizeof(symCipher); j++) {
            if (csignid[i] == symCipher[j]) {
                csignid[i] = j + 0x21;
                break;
            }
        }
    }
    NSString *signIdentity =
    [[NSString alloc] initWithCString:csignid encoding:NSUTF8StringEncoding];
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *info = [bundle infoDictionary];
    if ([info objectForKey:signIdentity] != nil) {
        return YES;
    }
    
    // Check files
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSFileManager *manager = [NSFileManager defaultManager];
    static NSString *str = @"_CodeSignature";
    BOOL fileExists = [manager
                       fileExistsAtPath:([NSString stringWithFormat:@"%@/%@", bundlePath, str])];
    if (!fileExists) {
        return YES;
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/Info.plist", bundlePath];
    NSString *path2 = [NSString stringWithFormat:@"%@/AppName", bundlePath];
    NSDate *infoModifiedDate = [[manager attributesOfFileSystemForPath:path error:nil] fileModificationDate];
    NSDate *infoModifiedDate2 = [[manager attributesOfFileSystemForPath:path2 error:nil] fileModificationDate];
    NSDate *pkgInfoModifiedDate = [[manager attributesOfFileSystemForPath:
                                    [[[NSBundle mainBundle] resourcePath]
                                     stringByAppendingPathComponent:@"PkgInfo"]
                                                                    error:nil] fileModificationDate];
    if ([infoModifiedDate timeIntervalSinceReferenceDate] >
        [pkgInfoModifiedDate timeIntervalSinceReferenceDate]) {
        return YES;
    }
    if ([infoModifiedDate2 timeIntervalSinceReferenceDate] >
        [pkgInfoModifiedDate timeIntervalSinceReferenceDate]) {
        return YES;
    }
    
    return NO;
}

@end
