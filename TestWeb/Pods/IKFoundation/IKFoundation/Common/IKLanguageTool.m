//
//  IKLanguageTool.m
//  IKFoundation
//
//  Created by Chenxiaocheng on 17/3/24.
//  Copyright © 2017年 inke. All rights reserved.
//

#import "IKLanguageTool.h"

@implementation IKLanguageTool

+ (BOOL)isChinese
{
    NSString *language = [self currentLanguage];
    
    return [language hasPrefix:@"zh-Hans"] || [language hasPrefix:@"zh-Hans-CN"];
}

+ (NSString *)currentLanguage
{
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defs objectForKey:@"AppleLanguages"];
    NSString *preferredLang = [languages objectAtIndex:0];
    return preferredLang;
}

@end
