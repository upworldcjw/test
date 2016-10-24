//
//  UIView + Common.h
//  pengpeng
//
//  Created by jianwei.chen on 15/12/29.
//  Copyright © 2015年 AsiaInnovations. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic,assign,setter=nb_setX:)   CGFloat nb_x;
@property (nonatomic,assign,setter=nb_setY:)   CGFloat nb_y;
@property (nonatomic,assign,setter=nb_setOrigin:) CGPoint nb_origin;

@property (nonatomic,assign,setter=nb_setRight:)   CGFloat nb_right;
@property (nonatomic,assign,setter=nb_setBottom:)   CGFloat nb_bottom;

@property (nonatomic,assign,setter=nb_setHeight:)   CGFloat nb_height;
@property (nonatomic,assign,setter=nb_setWidth:)    CGFloat nb_width;
@property (nonatomic,assign,setter=nb_setSize:)      CGSize  nb_size;

@property (nonatomic,assign,setter=nb_setCenterX:)  CGFloat nb_centerX;
@property (nonatomic,assign,setter=nb_setCenterY:)  CGFloat nb_centerY;
@property (nonatomic,assign,setter=nb_setCenter:)   CGPoint nb_center;

- (void)nb_setOffsetX:(CGFloat)offsetX;

- (void)nb_setOffsetY:(CGFloat)offsetY;

- (void)nb_setOffset:(CGPoint)offset;

- (void)nb_removeAllSubviews;

@end


@interface UIView (Debug)
- (void)dumpViewHierarchy;
@end



