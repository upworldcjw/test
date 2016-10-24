//
//  UIImage+Orientation.h
//  pengpeng
//
//  Created by 巩鹏军 on 14/12/23.
//  Copyright (c) 2014年 AsiaInnovations. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Orientation)
///返回 图片方向调整好的图片，如倒立图片调用之后返回正常图片
- (UIImage *)fixOrientation;
@end
