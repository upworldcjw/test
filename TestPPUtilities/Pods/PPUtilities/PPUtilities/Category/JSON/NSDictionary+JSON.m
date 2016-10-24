//
//  NSDictionary+JSON.m
//
//  Created by 巩 鹏军 on 14-7-12.
//  Copyright (c) 2014年 AsiaInnovations. All rights reserved.
//

#import "NSDictionary+JSON.h"

@implementation NSDictionary (JSON)

- (NSString*)nb_JSONString
{
    NSString *retString = nil;
    NSError *error = nil;
    NSData  *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    if(data) {
        retString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NBLog(@"\n%@",retString);
    } else {
        NSAssert(retString,@"NSDictionary:%@ error:%@",self,error);
    }
    return retString;
}

@end
