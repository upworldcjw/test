//
//  IKNumberFormat.m
//  IKFoundation
//
//  Created by Chenxiaocheng on 16/8/3.
//  Copyright © 2016年 inke. All rights reserved.
//

#import "IKNumberFormat.h"

@implementation IKNumberFormat

+ (NSString *)numberFormat:(NSInteger)num
{
  if (num < 0) {
    return @"0";
  }

  if (num >= 1000000) {
    return [NSString stringWithFormat:@"%d万", (int)(num / 10000)];
  } else if (num >= 10000) {
    return [NSString stringWithFormat:@"%d.%d万", (int)(num / 10000),
                                      (int)((num % 10000) / 1000)];
  }

  return [NSString stringWithFormat:@"%d", (int)num];
}

+ (NSString *)englishNumberFormat:(NSInteger)num {
    if (num < 0) {
        return @"0";
    }
    
    if (num >= 1000000) {
        return [NSString stringWithFormat:@"%dw", (int)(num / 10000)];
    } else if (num >= 100000 && num < 1000000){
        int interger = (int)(num / 10000);
        int decimals = (int)((num - interger * 10000) / 1000);
        return [NSString stringWithFormat:@"%d.%dw", interger,decimals];
    } else if (num >= 10000 && num < 100000) {
        return [NSString stringWithFormat:@"%d.%dw", (int)(num / 10000), (int)((num % 10000) / 1000)];
    } else if (num >= 1000 && num < 10000){
        return [NSString stringWithFormat:@"%d.%dk", (int)(num / 1000), (int)((num % 1000) / 100)];
    }
    
    return [NSString stringWithFormat:@"%d", (int)num];
}

@end
