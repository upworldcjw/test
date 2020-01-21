//
//  IKSerialization.m
//  IKFoundation
//
//  Created by Chenxiaocheng on 16/8/9.
//  Copyright © 2016年 inke. All rights reserved.
//

#import "IKSerialization.h"
#import "FCBasics.h"

@implementation IKSerialization

+ (NSDictionary *)unSerializeFromJsonData:(NSData *)data withError:(NSError **)error
{
    if (!data) {
        IKLog(@"data or error is nil");
        return nil;
    }
    
    id object = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:error];
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = object;
        return dict;
    } else {
        return nil;
    }
}

+ (NSDictionary *)unSerializeFromJsonString:(NSString *)str withError:(NSError **)error
{
    if (!str) {
        IKLog(@"data or error is nil");
        return nil;
    }
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    id object = [IKSerialization unSerializeFromJsonData:data withError:error];
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = object;
        return dict;
    } else {
        return nil;
    }
}

+ (NSArray *)unSerializeArrayFromJsonData:(NSData *)data withError:(NSError **)error
{
    if (!data) {
        IKLog(@"data or error is nil");
        return nil;
    }
    
    id object = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:error];
    if ([object isKindOfClass:[NSArray class]]) {
        NSArray *array = object;
        return array;
    } else {
        return nil;
    }
}

+ (NSArray *)unSerializeArrayFromJsonString:(NSString *)str withError:(NSError **)error
{
    if (!str) {
        IKLog(@"data or error is nil");
        return nil;
    }
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    id object = [IKSerialization unSerializeArrayFromJsonData:data withError:error];
    if ([object isKindOfClass:[NSArray class]]) {
        NSArray *array = object;
        return array;
    } else {
        return nil;
    }
}

+ (NSData *)serializeJsonDataWithDict:(NSDictionary *)dict
{
    if (![NSJSONSerialization isValidJSONObject:dict]) {
        return nil;
    }
    
    return [NSJSONSerialization dataWithJSONObject:dict
                                           options:kNilOptions
                                             error:nil];
}

+ (NSString *)serializeJsonStringWithDict:(NSDictionary *)dict
{
    NSData *data = [IKSerialization serializeJsonDataWithDict:dict];
    
    if (!data) {
        return nil;
    }
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
