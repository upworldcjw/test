//
//  IKLogEncryptFormatter.h
//  IKLogDemo
//
//  Created by fanzhang on 2017/1/3.
//  Copyright © 2017年 meelive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IKLogFormatter.h"

@interface IKLogEncryptFormatter : IKLogFormatter

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithEncryptKey:(NSString*)key NS_DESIGNATED_INITIALIZER;

@end
