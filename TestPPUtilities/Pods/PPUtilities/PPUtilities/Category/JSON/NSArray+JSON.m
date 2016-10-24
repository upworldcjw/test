//
//  NSArray+JSON.m
//  pengpeng
//
//  Created by 巩鹏军 on 15/2/27.
//  Copyright (c) 2015年 AsiaInnovations. All rights reserved.
//

#import "NSArray+JSON.h"
#import "NSData+JSON.h"
@implementation NSArray (JSON)

- (NSString*)nb_JSONString
{
    NSString *retString = nil;
//    NSError *error = nil;
//    NSData  *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    
    NSData *data = [NSData nb_JSONDataForObject:self];
    if(data) {
        retString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
//    else {
//        NSAssert(retString,@"%@ error:%@",self,error);
//    }
    return retString;
}

@end
