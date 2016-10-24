//
//  UIImage+Tint.h
//  ImageBlend
//
//  Created by 王 巍 on 13-4-29.
//  Copyright (c) 2013年 OneV-s-Den. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tint)
///image 上面加颜色渲染
- (UIImage *) imageWithTintColor:(UIColor *)tintColor;

///image 上面加颜色渲染
- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;

@end
