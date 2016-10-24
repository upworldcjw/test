//
//  NSString+Json.m
//  Pods
//
//  Created by jianwei.chen on 16/1/25.
//
//

#import "NSString+JSON.h"

@implementation NSString (JSON)
///所有集合都不可变
-(NSDictionary *)nb_Dictionary{
    return [self nb_ObjectWithOptions:0];
}

///集合是可变对象
- (NSMutableDictionary *)nb_MutableDictionary{
    return [self nb_ObjectWithOptions:NSJSONReadingMutableContainers];
}

///所有集合都不可变
- (NSArray*)nb_Array{
    return [self nb_ObjectWithOptions:0];
}

///集合是可变对象
- (NSArray*)nb_MutableArray{
    return [self nb_ObjectWithOptions:NSJSONReadingMutableContainers];
}

///NSNumber,NSString,NSArray,NSDictionary,NSNull,如果包含集合则集合不可变
- (id)nb_JSONObject{
    return [self nb_ObjectWithOptions:NSJSONReadingAllowFragments];
}


- (id)nb_ObjectWithOptions:(NSJSONReadingOptions)option{
    NSData *bodyData = [self dataUsingEncoding:NSUTF8StringEncoding];
    id result = [bodyData nb_ObjectWithOptions:option];
    return result;
}

@end
