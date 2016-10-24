//
//  UIView+CornerRadius.m
//  Pods
//
//  Created by jianwei.chen on 16/1/27.
//
//

#import "UIView+CornerRadius.h"

@implementation UIView (CornerRadius)

- (void)circleWithMarkColor:(UIColor*)color{
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = color.CGColor;
}

- (void)setRoundCorner:(CGFloat)radius{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
}

@end
