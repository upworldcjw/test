//
//  UIView + Common.m
//  pengpeng
//
//  Created by jianwei.chen on 15/12/29.
//  Copyright © 2015年 AsiaInnovations. All rights reserved.
//
#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)nb_right
{
    return self.frame.origin.x + self.frame.size.width;
}

-(void)nb_setRight:(CGFloat)nb_right{
    CGRect frame = self.frame;
    frame.origin.x = nb_right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)nb_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

-(void)nb_setBottom:(CGFloat)nb_bottom{
    CGRect frame = self.frame;
    frame.origin.y = nb_bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)nb_x
{
    return self.frame.origin.x;
}

-(void)nb_setX:(CGFloat)nb_x{
    CGRect frame = self.frame;
    frame.origin.x = nb_x;
    self.frame = frame;
}

- (CGFloat)nb_y
{
    return self.frame.origin.y;
}

- (void)nb_setY:(CGFloat)nb_y{
    CGRect frame = self.frame;
    frame.origin.y = nb_y;
    self.frame = frame;
}

- (CGPoint)nb_origin{
    return self.frame.origin;
}

- (void)nb_setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)nb_height
{
    return self.frame.size.height;
}

- (void)nb_setHeight:(CGFloat)nb_height{
    CGRect frame = self.frame;
    frame.size.height = nb_height;
    self.frame = frame;
}

- (CGFloat)nb_width
{
    return self.frame.size.width;
}

- (void)nb_setWidth:(CGFloat)nb_width{
    CGRect frame = self.frame;
    frame.size.width = nb_width;
    self.frame = frame;
}

- (CGSize)nb_size{
    return self.frame.size;
}

- (void)nb_setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(CGFloat)nb_centerX{
    return self.center.x;
}

- (void)nb_setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

-(CGFloat)nb_centerY{
    return self.center.y;
}

- (void)nb_setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGPoint)nb_center{
    return self.center;
}

- (void)nb_setCenter:(CGPoint)center{
    self.center = center;
}


- (void)nb_setOffsetX:(CGFloat)offsetX{
    CGRect frame = self.frame;
    frame.origin.x += offsetX;
    self.frame = frame;
}

- (void)nb_setOffsetY:(CGFloat)offsetY{
    CGRect frame = self.frame;
    frame.origin.y += offsetY;
    self.frame = frame;
}

- (void)nb_setOffset:(CGPoint)offset{
    CGRect frame = self.frame;
    frame.origin.y += offset.y;
    frame.origin.x += offset.x;
    self.frame = frame;
}


- (void)nb_removeAllSubviews
{
    while (self.subviews.count)
    {
        UIView *child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

@end


@interface UIView (Debug_Inner)
#ifdef DEBUG
- (NSString*)recursiveDescription;
#endif
@end

@implementation UIView (Debug)

- (void)dumpViewHierarchy;
{
#ifdef DEBUG
    NSLog(@"\n%@",[self recursiveDescription]);
#endif
}

@end
