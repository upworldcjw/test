//
//  IKAppConfig.m
//  IKFoundation
//
//  Created by Chenxiaocheng on 16/8/9.
//  Copyright © 2016年 inke. All rights reserved.
//

#import "IKAppConfig.h"
#import "FCReachability.h"
#import "AdSupport/ASIdentifierManager.h"
#import "IKFoundationEnvConfig.h"

@implementation IKAppConfig

+ (NSDictionary *)appDataDic
{
    static NSDictionary *appDic = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appDic = [[NSBundle mainBundle] infoDictionary];
    });
    
    return appDic;
}

+ (NSMutableDictionary *)presetServerInfo
{
    static NSMutableDictionary *serviceinfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *serviceInfoPath;
        
        if (kIsTestEnv) {
            serviceInfoPath =
            [[NSBundle mainBundle] pathForResource:@"DebugPresetServiceinfo"
                                            ofType:@"plist"];
        } else {
            serviceInfoPath =
            [[NSBundle mainBundle] pathForResource:@"PresetServiceinfo"
                                            ofType:@"plist"];
        }
        serviceinfo = [[NSMutableDictionary alloc] initWithContentsOfFile:serviceInfoPath];
    });
    
    return serviceinfo;
}

+ (NSString *)licenseCode
{
    NSDictionary *dict = [self appDataDic];
    NSString *license = [dict valueForKeyPath:@"app.license"];
    NSAssert(license != nil && [license isKindOfClass:[NSString class]],
             @"appconfig error");
    return license;
}

+ (NSString *)appClientVersion
{
    NSDictionary *dict = [self appDataDic];
    NSString *version = [dict valueForKeyPath:@"app.version"];
    NSAssert(version != nil && [version isKindOfClass:[NSString class]],
             @"appconfig error");
    return version;
}

+ (NSString *)appChannel
{
    NSDictionary *dict = [self appDataDic];
    NSString *channel = [dict valueForKeyPath:@"app.channel"];
    NSAssert(channel != nil && [channel isKindOfClass:[NSString class]],
             @"appconfig error");
    return channel;
}

+ (NSString *)appEnterpriseChannel
{
    NSDictionary *dict = [self appDataDic];
    NSString *channel = [dict valueForKeyPath:@"app.enterpriseChannel"];
    NSAssert(channel != nil && [channel isKindOfClass:[NSString class]],
             @"appconfig error");
    return channel;
}

+ (NSString *)appProtoVersion
{
    NSDictionary *dict = [self appDataDic];
    NSString *version = [dict valueForKeyPath:@"app.proto"];
    NSAssert(version != nil && [version isKindOfClass:[NSString class]],
             @"appconfig error");
    return version;
}

+ (NSString *)enterUrl
{
    NSDictionary *dict = [self appDataDic];
    NSString *url = [dict valueForKeyPath:@"serviceinfo.url"];
    NSAssert(url != nil && [url isKindOfClass:[NSString class]],
             @"appconfig error");
    return url;
}

+ (NSString *)backupEnterUrl
{
    NSDictionary *dict = [self appDataDic];
    NSString *url = [dict valueForKeyPath:@"serviceinfo.url_backup"];
    NSAssert(url != nil && [url isKindOfClass:[NSString class]],
             @"appconfig error");
    return url;
}

+ (NSString *)idfa
{
    NSString *idfa =
    [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    return idfa;
}

+ (BOOL)isSimplifiedChinese {
    NSString *language = [self currentLanguage];
    if ([language hasPrefix:@"zh-Hans"] || [language hasPrefix:@"zh-Hans-CN"]) {
        return YES;
    }
    
    return NO;
}

+ (NSString *)currentLanguage {
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defs objectForKey:@"AppleLanguages"];
    NSString *preferredLang = [languages objectAtIndex:0];
    return preferredLang;
}

@end
