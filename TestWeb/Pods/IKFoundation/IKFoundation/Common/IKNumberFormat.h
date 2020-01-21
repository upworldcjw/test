//
//  IKNumberFormat.h
//  IKFoundation
//
//  Created by Chenxiaocheng on 16/8/3.
//  Copyright © 2016年 inke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKNumberFormat : NSObject


/**
 在线人数format 超过百万显示以(xxx万)形式显示 超过一万以(x.x万)形式显示 其它原始数字显示

 @param num num description
 @return return value description
 */
+ (NSString *)numberFormat:(NSInteger)num;

// 示例：1100 => 1.1K
+ (NSString *)englishNumberFormat:(NSInteger)num;

@end
