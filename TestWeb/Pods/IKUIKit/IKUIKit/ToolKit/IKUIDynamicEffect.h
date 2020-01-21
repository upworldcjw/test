//
//  DynamicEffect.h
//  inke
//
//  Created by Chenxiaocheng on 15/8/31.
//  Copyright (c) 2015年 MeeLive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IKUIDynamicEffect : NSObject

+ (void)showEffectMessage:(NSString *)message startY:(CGFloat)startY inView:(UIView *)superview;

@end
