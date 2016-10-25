//
//  UIDevice+Device.h
//  pengpeng
//
//  Created by jianwei.chen on 15/12/4.
//  Copyright © 2015年 AsiaInnovations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDVersion/SDiOSVersion.h>
@interface UIDevice (Device)

typedef NS_ENUM(NSInteger, NBDeviceSize){
//    UnknownSize     = 0,
    NBScreen3Dot5inch = 1,
    NBScreen4inch     = 2,
    NBScreen4Dot7inch = 3,
    NBScreen5Dot5inch = 4,
    NBUnknownSize_SMALLER = NBScreen3Dot5inch,
    NBUnknownSize_BIGGER = NBScreen5Dot5inch,
};

+ (NBDeviceSize)renderOnDeviceSize;

+ (NBDeviceSize)realDeviceSize;

+ (DeviceVersion)deviceVersion;
@end
