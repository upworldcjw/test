//
//  UIImage+Color.h
//  pengpeng
//
//  Created by feng on 14/11/25.
//  Copyright (c) 2014年 AsiaInnovations. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)
///color 转image
+ (UIImage *)imageWithColor:(UIColor *)color;

///color 转image
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
