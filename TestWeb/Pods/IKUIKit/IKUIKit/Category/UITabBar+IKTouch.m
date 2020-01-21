//
//  UITabBar+IKTouch.m
//  inke
//
//  Created by zld on 16/8/31.
//  Copyright © 2016年 MeeLive. All rights reserved.
//

#import "UITabBar+IKTouch.h"
#import "UIView+IKTouch.h"

@implementation UITabBar (IKTouch)

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return [self overlapHitTest:point withEvent:event];
}

/**
 *  http://stackoverflow.com/a/17329683/2138564
 */

/**
 * "overlay" views.
 
 +----------------------------+
 |A +--------+                |
 |  |B  +------------------+  |
 |  |   |C            X    |  |
 |  |   +------------------+  |
 |  |        |                |
 |  +--------+                |
 |                            |
 +----------------------------+
 Assume X - user's touch. pointInside:withEvent: on B returns NO, so hitTest:withEvent: returns A. 
 I wrote category on UIView to handle issue when you need to receive touch on top most visible view.
 */

@end
