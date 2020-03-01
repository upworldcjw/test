//
//  PublicHeader.m
//  TabbarQuestion
//
//  Created by JianweiChen on 2018/8/3.
//  Copyright © 2018 inke. All rights reserved.
//

#import "PublicHeader.h"
#import <UIKit/UIKit.h>
#import "UIView+IKSVUtils.h"

NSString *kChangeTabKey = @"kChangeTabKey";

BOOL gIsIphoneX(void) {
    static BOOL s_isIphoneX = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ((1. * [UIScreen mainScreen].bounds.size.height
             / [UIScreen mainScreen].bounds.size.width) > 2.16) {
            s_isIphoneX = YES;
        } else if ((1. * [UIScreen mainScreen].bounds.size.width
                    / [UIScreen mainScreen].bounds.size.height) > 2.16) {
            //横屏
            s_isIphoneX = YES;
        } else {
            s_isIphoneX = NO;
        }
    });
    return s_isIphoneX;
}

/**
 通过16进制色值获取UIColor对象
 
 @param hexValue 16进制颜色值，如：0x000000
 @param alpha 透明度，取值范围：0~1
 @return UIColor对象
 */
UIColor *IKHexColor(unsigned int hexValue, CGFloat alpha) {
    return [UIColor colorWithRed:((float)(((hexValue) & 0xFF0000) >> 16))/255.0 green:((float)(((hexValue) & 0xFF00) >> 8))/255.0 blue:((float)((hexValue) & 0xFF))/255.0 alpha:alpha];
}

