//
//  UIView+IKTouch.m
//  inke
//
//  Created by zld on 16/8/31.
//  Copyright © 2016年 MeeLive. All rights reserved.
//

#import "UIView+IKTouch.h"

@implementation UIView (IKTouch)

- (UIView *)overlapHitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    // 1
    if (!self.userInteractionEnabled || [self isHidden] || self.alpha == 0)
        return nil;
    
    // 2
    UIView *hitView = self;
    if (![self pointInside:point withEvent:event]) {
        if (self.clipsToBounds) return nil;
        else hitView = nil;
    }
    
    // 3
    NSEnumerator *enumerator = [self.subviews reverseObjectEnumerator];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (id element in enumerator) {
        [items addObject:element];
    }
    for (UIView *subview in items ) {
        CGPoint insideSubview = [self convertPoint:point toView:subview];
        UIView *sview = [subview overlapHitTest:insideSubview withEvent:event];
        if (sview) return sview;
    }
    
    // 4
    return hitView;
}

@end
