//
//  UIView+Utility.m
//  MeeChat
//
//  Created by HouGuangling on 15/3/19.
//  Copyright (c) 2015年 HouGuangling. All rights reserved.
//

#import "UIView+Utility.h"

@implementation UIView (Utility)

- (void)addShadowWithColor:(UIColor *)color
                    offset:(CGSize)offset
                   opacity:(CGFloat)opacity {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
}

- (void)addRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii {
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    
    UIBezierPath *roundedPath = [UIBezierPath bezierPathWithRoundedRect: maskLayer.bounds byRoundingCorners:corners cornerRadii:radii];
    maskLayer.backgroundColor = [[UIColor clearColor] CGColor];
    maskLayer.path = [roundedPath CGPath];
    self.layer.mask = maskLayer;
}

- (void)ik_roundingCorners:(CGRect)frame {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:UIRectCornerAllCorners cornerRadii:frame.size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    maskLayer.frame = frame;
    
    self.layer.mask = maskLayer;
}

@end
