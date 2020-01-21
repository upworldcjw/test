//
//  NSDictionary+IKUtility.h
//  IKFoundation
//
//  Created by Chenxiaocheng on 16/8/9.
//  Copyright © 2016年 inke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (IKUtility)

- (NSNumber *)ik_numberForKey:(NSString *)keyPath;

- (NSString *)ik_stringForKey:(NSString *)keyPath;

- (NSDictionary *)ik_dictionaryForKey:(NSString *)keyPath;

- (NSArray *)ik_arrayForKey:(NSString *)keyPath;

- (NSInteger)ik_integerForKey:(NSString *)keyPath;

- (NSUInteger)ik_uintegerForKey:(NSString *)keyPath;

// support NSNumber or NSString
- (BOOL)ik_boolForKey:(NSString *)keyPath;

// 废弃，拼写错误
- (NSInteger)ik_intergerForKey:(NSString *)keyPath __attribute__ ((deprecated("use ik_integerForKey instead")));

- (NSUInteger)ik_uintergerForKey:(NSString *)keyPath __attribute__ ((deprecated("use ik_uintegerForKey instead")));

@end
