//
//  GaussiImage.h
//  MeeChat
//
//  Created by HouGuangling on 15/3/27.
//  Copyright (c) 2015年 HouGuangling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>

@interface IKGaussiImage : NSObject

+ (UIImage *)gaussi:(UIImage *)image value:(CGFloat)val;

@end
