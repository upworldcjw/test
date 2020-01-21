//
//  IKDefaultImage.m
//  IKFoundation
//
//  Created by kyle on 2017/5/12.
//  Copyright © 2017年 inke. All rights reserved.
//

#import "IKDefaultImage.h"

@implementation IKDefaultImage

+ (UIImage *)userImage
{
    return [UIImage imageNamed:@"default_head"];
}

+ (UIImage *)photoImage
{
    return [UIImage imageNamed:@"default_photo"];
}

+ (UIImage *)boyImage
{
    return [UIImage imageNamed:@"global_male"];
}

+ (UIImage *)girlImage
{
    return [UIImage imageNamed:@"global_female"];
}

+ (UIImage *)newTagImage
{
    return [UIImage imageNamed:@"NEW_"];
}

+ (UIImage *)roomImage
{
    return [UIImage imageNamed:@"default_room"];
}


@end
