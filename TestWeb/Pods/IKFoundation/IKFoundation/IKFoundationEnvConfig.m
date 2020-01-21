//
//  IKFoundationConfig.m
//  IKFoundation
//
//  Created by kyle on 16/10/28.
//  Copyright © 2016年 inke. All rights reserved.
//

#import "IKFoundationEnvConfig.h"

@implementation IKFoundationEnvConfig

+ (instancetype)shareInstance {
    static IKFoundationEnvConfig *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[IKFoundationEnvConfig alloc] init];
    });
    return instance;
}

@end
