//
//  UIDevice+Device.m
//  pengpeng
//
//  Created by jianwei.chen on 15/12/4.
//  Copyright © 2015年 AsiaInnovations. All rights reserved.
//

#import "UIDevice+Device.h"

@implementation UIDevice (Device)
//渲染依据屏幕大小即
static NBDeviceSize kRenderOnDeviceSize;
static NBDeviceSize kRealOnDeviceSize;
static CGFloat    kIosSystemVersion;
static CGSize     kRenderOnSize;

static DeviceVersion kDeviceVersion;
+(void)excuteOnce{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kIosSystemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (kIosSystemVersion >= 8.0) {
            CGFloat screenHeight = MAX([[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
            CGFloat screenWidth = MIN([[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
            kRenderOnSize = CGSizeMake(screenWidth, screenHeight);
        }else{
            kRenderOnSize = [[UIScreen mainScreen] bounds].size;
        }
        kRenderOnDeviceSize = [self _renderOnDeviceSize];
        kRealOnDeviceSize = [self _realDeviceSize];
        
        kDeviceVersion = [SDiOSVersion deviceVersion];
    });
}


+(NBDeviceSize)_renderOnDeviceSize{
    CGFloat screenHeight = kRenderOnSize.height;
    NBDeviceSize renderOnDeviceSize = NBScreen4Dot7inch;
    if (screenHeight > 736) {
        renderOnDeviceSize = NBUnknownSize_BIGGER;
    }else if (screenHeight > 667){
        renderOnDeviceSize = NBScreen5Dot5inch;
    }else if (screenHeight > 568){
        renderOnDeviceSize = NBScreen4Dot7inch;
    }else if (screenHeight > 480){
        renderOnDeviceSize = NBScreen4inch;
    }else if (screenHeight == 480){
        renderOnDeviceSize = NBScreen3Dot5inch;
    }else{
        renderOnDeviceSize = NBUnknownSize_SMALLER;
    }
    return renderOnDeviceSize;
}

+(NBDeviceSize)renderOnDeviceSize{
    [self excuteOnce];
    return kRenderOnDeviceSize;
}

+(NBDeviceSize)_realDeviceSize{
    CGFloat screenHeight = kRenderOnSize.height;
    NBDeviceSize renderOnDeviceSize = NBScreen4Dot7inch;
    if (screenHeight > 736) {
        renderOnDeviceSize = NBUnknownSize_BIGGER;
    }else if (screenHeight > 667){//==736
        renderOnDeviceSize = NBScreen5Dot5inch; //6+
    }else if (screenHeight > 568){//==667
        if ([UIScreen mainScreen].scale > 2.9){
            renderOnDeviceSize = NBScreen5Dot5inch;////6+缩放模式
        }else{
            renderOnDeviceSize = NBScreen4Dot7inch;//6
        }
    }else if (screenHeight > 480){//==568
        //虚拟机无法区分6的zoom 和 其他4.7英寸设备的区别
        if (kDeviceVersion == iPhone6) {
            renderOnDeviceSize = NBScreen5Dot5inch;
        }else{
            renderOnDeviceSize = NBScreen4inch;
        }
    }else if (screenHeight == 480){
        renderOnDeviceSize = NBScreen3Dot5inch;
    }else{
        renderOnDeviceSize = NBUnknownSize_SMALLER;
    }
    return renderOnDeviceSize;
}

+(NBDeviceSize)realDeviceSize{
    [self excuteOnce];
    return kRealOnDeviceSize;
}


+(DeviceVersion)deviceVersion{
    return kDeviceVersion;
}

@end
