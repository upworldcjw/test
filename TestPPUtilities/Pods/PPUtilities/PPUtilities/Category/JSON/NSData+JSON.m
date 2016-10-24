//
//  NSData+JSON.m
//  Pods
//
//  Created by jianwei.chen on 16/1/26.
//
//

#import "NSData+JSON.h"

@implementation NSData (JSON)

+ (NSData *)nb_JSONDataForObject:(id)object{
    NSAssert(object, @"error");
    if(!object) {
        return nil;
    }
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    
    if (!data && error) {
        NSAssert(error,@"%@",error);
    }
    return data;
}

- (NSDictionary *)nb_Dictionary{
    return [self nb_ObjectWithOptions:0];
}

///集合是可变对象
- (NSMutableDictionary *)nb_MutableDictionary{
    return [self nb_ObjectWithOptions:NSJSONReadingMutableContainers];
}

- (NSArray *)nb_Array{
    return [self nb_ObjectWithOptions:0];
}

///集合是可变对象
- (NSArray*)nb_MutableArray{
    return [self nb_ObjectWithOptions:NSJSONReadingMutableContainers];
}

- (id)nb_JSONObject{
    return [self nb_ObjectWithOptions:NSJSONReadingAllowFragments];
}

//内部方法
- (id)nb_ObjectWithOptions:(NSJSONReadingOptions)option{
    NSError *error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:self options:option error:&error];
    if (!result && error) {
        NSAssert(error,@"%@",error);
    }
    return result;
}

@end
