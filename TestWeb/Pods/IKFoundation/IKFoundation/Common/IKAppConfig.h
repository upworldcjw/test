//
//  IKAppConfig.h
//  IKFoundation
//
//  Created by Chenxiaocheng on 16/8/9.
//  Copyright © 2016年 inke. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface IKAppConfig : NSObject

+ (NSMutableDictionary *)presetServerInfo;

+ (NSString *)licenseCode;

+ (NSString *)appClientVersion;

+ (NSString *)appChannel;

+ (NSString *)appProtoVersion;

+ (NSString *)idfa;

+ (NSString *)enterUrl;

+ (NSString *)backupEnterUrl;

#pragma mark -

+ (BOOL)isSimplifiedChinese;

@end
