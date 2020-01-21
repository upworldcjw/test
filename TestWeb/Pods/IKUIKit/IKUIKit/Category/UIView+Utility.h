//
//  UIView+Utility.h
//  MeeChat
//
//  Created by HouGuangling on 15/3/19.
//  Copyright (c) 2015年 HouGuangling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utility)

- (void)addShadowWithColor:(UIColor *)color
                    offset:(CGSize)offset
                   opacity:(CGFloat)opacity;

- (void)addRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii;

- (void)ik_roundingCorners:(CGRect)frame;

@end
