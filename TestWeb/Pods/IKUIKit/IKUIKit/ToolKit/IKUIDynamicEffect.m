//
//  DynamicEffect.m
//  inke
//
//  Created by Chenxiaocheng on 15/8/31.
//  Copyright (c) 2015年 MeeLive. All rights reserved.
//

#import "IKUIDynamicEffect.h"

#define StartMoveUpY 300

@implementation IKUIDynamicEffect

+ (void)showEffectMessage:(NSString *)message startY:(CGFloat)startY inView:(UIView *)superview
{
    UIFont *font = [UIFont systemFontOfSize:16.0];
    
    CGRect rect = [message boundingRectWithSize:CGSizeMake(200, CGFLOAT_MAX)
                       options:NSStringDrawingUsesLineFragmentOrigin |
     NSStringDrawingUsesFontLeading
                    attributes:@{
                                 NSFontAttributeName : font
                                 }
                       context:nil];
    CGSize textSize = CGSizeMake(ceil(rect.size.width), ceil(rect.size.height));
    
    
    CGFloat w = textSize.width;
    CGFloat h = textSize.height;
    
    w = w < 100 ? 100 : w;
    h = h < 40 ? 40 : h;
    w += 20;
    
    startY = superview.frame.size.height - startY;
    CGFloat x = (superview.frame.size.width - w) / 2.0f;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(x, startY, w, h)];
    
    lab.text = message;
    lab.numberOfLines = 0;
    lab.alpha = 0.1f;
    lab.layer.masksToBounds = YES;
    lab.layer.cornerRadius = 10.0f;
    lab.textColor = [UIColor whiteColor];
    lab.backgroundColor = [UIColor grayColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = font;
    
    [superview.superview addSubview:lab];
    
    [UIView animateWithDuration:0.4f animations:^{
        lab.frame = CGRectMake(x, startY - h, w, h);
        lab.alpha = 0.9f;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.3f delay:0.5f options:UIViewAnimationOptionCurveEaseOut animations:^{
                lab.alpha = 0.0f;
            } completion:^(BOOL finished) {
                if (finished) [lab removeFromSuperview];
            }];
        }
    }];
}

@end
