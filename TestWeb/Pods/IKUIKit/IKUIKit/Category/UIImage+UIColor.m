//
//  UIImage+UIColor.m
//  MeeChat
//
//  Created by Kjov on 15-6-24.
//  Copyright (c) 2015年 HouGuangling. All rights reserved.
//

#import "UIImage+UIColor.h"

@implementation UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
  CGRect rect = CGRectMake(0, 0, size.width, size.height);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context,color.CGColor);
  CGContextFillRect(context, rect);
  UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return img;
}

@end
