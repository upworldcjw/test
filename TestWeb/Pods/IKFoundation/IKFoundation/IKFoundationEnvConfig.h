//
//  IKFoundationConfig.h
//  IKFoundation
//
//  Created by kyle on 16/10/28.
//  Copyright © 2016年 inke. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kIsTestEnv ([IKFoundationEnvConfig shareInstance].env == IKFoundationEnvTest)
#define kIsReleaseEnv ([IKFoundationEnvConfig shareInstance].env == IKFoundationEnvRelease)

// 打包的环境配置

typedef enum : NSUInteger {
    IKFoundationEnvTest = 0,        // 测试环境
    IKFoundationEnvRelease,         // 线上环境
} IKFoundationEnvironment;

@interface IKFoundationEnvConfig : NSObject

// 环境配置，在外部初始化
@property(nonatomic, assign) IKFoundationEnvironment env;

+ (instancetype)shareInstance;

@end
