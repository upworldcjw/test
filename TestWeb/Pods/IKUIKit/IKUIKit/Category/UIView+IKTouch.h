//
//  UIView+IKTouch.h
//  inke
//
//  Created by zld on 16/8/31.
//  Copyright © 2016年 MeeLive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (IKTouch)

- (UIView *)overlapHitTest:(CGPoint)point withEvent:(UIEvent *)event;

@end
