//
//  ButtonA.m
//  TestChain
//
//  Created by jianwei.chen on 15/8/24.
//  Copyright (c) 2015年 jianwei.chen. All rights reserved.
//

#import "ButtonA.h"

@implementation ButtonA

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"%@ %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
    NSLog(@"%@",NSStringFromCGRect(self.frame));
    CGRect rect = CGRectMake(self.touchInset.left,self.touchInset.top, self.frame.size.width - (self.touchInset.left + self.touchInset.right), self.frame.size.height - (self.touchInset.top+self.touchInset.bottom));
    NSLog(@"%@",NSStringFromCGRect(rect));
    return (CGRectContainsPoint(rect, point));
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"%@ %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
//    if ([self pointInside:point withEvent:event]) {
//        return self;
//    }else{
        return [super hitTest:point withEvent:event];
//    }
}


@end
