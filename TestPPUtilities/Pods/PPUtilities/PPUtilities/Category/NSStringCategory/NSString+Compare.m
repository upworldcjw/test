//
//  NSString+Compare.m
//  pengpeng
//
//  Created by 巩鹏军 on 15/4/27.
//  Copyright (c) 2015年 AsiaInnovations. All rights reserved.
//

#import "NSString+Compare.h"

@implementation NSString (Compare)

- (BOOL)nb_containsString:(NSString *)aString;
{
    return [self nb_containsString:aString options:NSCaseInsensitiveSearch];
}

- (BOOL)nb_containsString:(NSString *)aString options:(NSStringCompareOptions)mask;
{
    NSRange range = [self rangeOfString:aString options:mask];
    BOOL contain = (range.length > 0) ? YES : NO;
    return contain;
}

@end
