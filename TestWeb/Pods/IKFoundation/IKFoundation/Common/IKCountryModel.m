//
//  countryModle.m
//  MeeLive
//
//  Created by Duomi on 14/12/19.
//  Copyright (c) 2014年 duomi. All rights reserved.
//

#import "IKCountryModel.h"
#import "IKPinYinTool.h"

@implementation IKCountryModel

- (NSString *)getFullName
{
    return _CEnName;
}

- (NSString *)getFirstName
{
    if ([_Cname canBeConvertedToEncoding:NSASCIIStringEncoding]) {  //如果是英语
        return [NSString stringWithFormat:@"%c", [_Cname characterAtIndex:0]];
    } else {
        return [NSString
                stringWithFormat:@"%c",
                pinyinFirstLetter([_Cname characterAtIndex:0]) - 32];
    }
}

- (NSString *)getFirstName:(NSString *)firstName
{
    return [NSString stringWithFormat:@"%c", [firstName characterAtIndex:0]];
}

@end
