//
//  NSDictionary+IKUtility.m
//  IKFoundation
//
//  Created by Chenxiaocheng on 16/8/9.
//  Copyright © 2016年 inke. All rights reserved.
//

#import "NSDictionary+IKUtility.h"

@implementation NSDictionary (IKUtility)

#pragma mark - Public Methods

- (NSNumber *)ik_numberForKey:(NSString *)keyPath {
    return [self _valueFromDictionary:self
                          withKeyPath:keyPath
                          classVerify:[NSNumber class]];
    
}


- (NSString *)ik_stringForKey:(NSString *)keyPath {
    return [self _valueFromDictionary:self
                          withKeyPath:keyPath
                          classVerify:[NSString class]];
    
}

- (NSDictionary *)ik_dictionaryForKey:(NSString *)keyPath {
    return [self _valueFromDictionary:self
                          withKeyPath:keyPath
                          classVerify:[NSDictionary class]];
}

- (NSArray *)ik_arrayForKey:(NSString *)keyPath {
    return [self _valueFromDictionary:self
                          withKeyPath:keyPath
                          classVerify:[NSArray class]];
}



- (NSInteger)ik_integerForKey:(NSString *)keyPath
{
    return [[self ik_numberForKey:keyPath] integerValue];
}

- (NSUInteger)ik_uintegerForKey:(NSString *)keyPath
{
    return [[self ik_numberForKey:keyPath] unsignedIntegerValue];
}

- (BOOL)ik_boolForKey:(NSString *)keyPath
{
    NSNumber *num = [self ik_numberForKey:keyPath];
    if (num) {
        return [num boolValue];
    }
    return [[self ik_stringForKey:keyPath] boolValue];
}

#pragma mark - Deprecated

- (NSInteger)ik_intergerForKey:(NSString *)keyPath
{
    return [[self ik_numberForKey:keyPath] integerValue];
}

- (NSUInteger)ik_uintergerForKey:(NSString *)keyPath
{
    return [[self ik_numberForKey:keyPath] unsignedIntegerValue];
}

#pragma mark - Private Methods

- (id)_valueFromDictionary:(NSDictionary *)dict
               withKeyPath:(NSString *)keyPath
               classVerify:(Class)cl {
    if (!dict || !keyPath) {
        return nil;
    }
    id p;
    @try {
        p = [dict valueForKeyPath:keyPath];
        if (![p isKindOfClass:cl]) {
            p = nil;
        }
    }
    @catch (NSException *exception) {
        p = nil;
    }
    @finally {
        return p;
    }
    
    return nil;
}
@end
