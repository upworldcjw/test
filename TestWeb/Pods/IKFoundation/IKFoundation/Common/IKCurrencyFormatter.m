//
//  IKCurrencyFormatter.m
//  inke
//
//  Created by FanXia on 2017/5/22.
//  Copyright © 2017年 MeeLive. All rights reserved.
//

#import "IKCurrencyFormatter.h"

@implementation IKCurrencyFormatter

+ (NSString *)formatStarlightNumber:(NSInteger)number {
    NSInteger tenThousand = 10000;         // 1万
    NSInteger hundredThousand = 100000;    // 10万
    NSInteger million = 1000000;           // 100万
    NSInteger hundredMillion = 100000000;  // 1亿
    NSInteger tenBillion = 10000000000;    // 100亿
    
    if (number < hundredThousand) {
        // < 10万
        return [NSString stringWithFormat:@"%ld", (long)number];
    } else if (number < million) {
        // < 100万
        // 只保留小数点后一位（舍弃原则）
        float floatNum = floorf((number * 1.0 / tenThousand) * 10) / 10;
        if (floatNum == floorf(floatNum)) {
            return [NSString stringWithFormat:@"%.0f万", floatNum];
        } else {
            return [NSString stringWithFormat:@"%.1f万", floatNum];
        }
    } else if (number < hundredMillion) {
        // < 1亿
        return [NSString stringWithFormat:@"%d万", (int)(number / tenThousand)];
    } else if (number < tenBillion) {
        // < 100亿
        // 只保留小数点后一位（舍弃原则）
        float floatNum = floorf((number * 1.0 / hundredMillion) * 10) / 10;
        if (floatNum == floorf(floatNum)) {
            return [NSString stringWithFormat:@"%.0f亿", floatNum];
        } else {
            return [NSString stringWithFormat:@"%.1f亿", floatNum];
        }
    } else {
        // <= 999亿
        return [NSString stringWithFormat:@"%d亿", (int)(number / hundredMillion)];
    }
}

@end
