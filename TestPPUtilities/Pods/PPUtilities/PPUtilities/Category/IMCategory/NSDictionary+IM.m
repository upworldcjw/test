//
//  NSDictionary+Category.m
//  pengpeng
//
//  Created by Leonine on 13-11-21.
//  Copyright (c) 2013年 AsiaInnovations. All rights reserved.
//

#import "NSDictionary+IM.h"
#import "NSString+IMJsonSerial.h"

@implementation NSDictionary (IM)

+(NSDictionary*) dictionaryFromArray:(NSArray*)array Key:(NSString*)key;
{
    NSString* value = [NSString jsonStringWithArray:array];
    
    return [[NSDictionary alloc]initWithObjectsAndKeys:value,key, nil];
}


@end
