//
//  NSString+Common.m
//  Pods
//
//  Created by jianwei.chen on 16/2/26.
//
//

#import "NSString+Common.h"

@implementation NSString (Common)

+ (NSString *)nb_UUID
{
    CFUUIDRef theUUID = CFUUIDCreate(nil);
    CFStringRef uuidCFString = CFUUIDCreateString(nil, theUUID);
    NSString *uuidString = [NSString stringWithString:(__bridge NSString*)uuidCFString];
    CFRelease(theUUID);
    CFRelease(uuidCFString);
    return uuidString;
}

//不允许为空
- (BOOL)isBlankString {
    if (self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

@end
