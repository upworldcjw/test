//
//  IKSerialization.h
//  IKFoundation
//
//  Created by Chenxiaocheng on 16/8/9.
//  Copyright © 2016年 inke. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  序列化和反序列化
 */
@interface IKSerialization : NSObject

+ (NSDictionary *)unSerializeFromJsonData:(NSData *)data
                                withError:(NSError **)error;

+ (NSDictionary *)unSerializeFromJsonString:(NSString *)str
                                  withError:(NSError **)error;

+ (NSArray *)unSerializeArrayFromJsonData:(NSData *)data
                                withError:(NSError **)error;

+ (NSArray *)unSerializeArrayFromJsonString:(NSString *)str
                                  withError:(NSError **)error;

+ (NSData *)serializeJsonDataWithDict:(NSDictionary *)dict;

+ (NSString *)serializeJsonStringWithDict:(NSDictionary *)dict;

@end
