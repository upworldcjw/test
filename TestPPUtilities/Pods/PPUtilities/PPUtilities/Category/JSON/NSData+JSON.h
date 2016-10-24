//
//  NSData+JSON.h
//  Pods
//
//  Created by jianwei.chen on 16/1/26.
//
//

#import <Foundation/Foundation.h>

@protocol PPJSONProtocol <NSObject>

///所有集合都不可变
- (NSDictionary*)nb_Dictionary;

///集合是可变对象
- (NSMutableDictionary *)nb_MutableDictionary;

///所有集合都不可变
- (NSArray*)nb_Array;

///集合是可变对象
- (NSArray*)nb_MutableArray;

///NSNumber,NSString,NSArray,NSDictionary,NSNull,如果包含集合则集合不可变
- (id)nb_JSONObject;

@end

@interface NSData (JSON)<PPJSONProtocol>

+ (NSData *)nb_JSONDataForObject:(id)object;

- (id)nb_ObjectWithOptions:(NSJSONReadingOptions)option;

@end
