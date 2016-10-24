//
//  UIDevice+Utility.h
//  pengpeng
//
//  Created by jianwei.chen on 15/11/20.
//  Copyright © 2015年 AsiaInnovations. All rights reserved.
//
#import "UIDevice+Device.h"

/*
 *systemVersion
 */
#define IOS8 iOSVersionGreaterThanOrEqualTo(@"8.0")
#define IOS7 iOSVersionGreaterThanOrEqualTo(@"7.0")
#define IOS6 (iOSVersionGreaterThanOrEqualTo(@"6.0") && iOSVersionLessThan(@"7.0"))


#define kIphone4   ([UIDevice renderOnDeviceSize] == NBScreen3Dot5inch)
#define kIphone5_5s ([UIDevice renderOnDeviceSize] == NBScreen4inch)
#define kIphone6    ([UIDevice renderOnDeviceSize] == NBScreen4Dot7inch)
#define kIphone6Plus ([UIDevice renderOnDeviceSize] == NBScreen5Dot5inch)

//渲染环境是否是4.7英寸以上设备（区别zoom和普通模式）
#define isLargeSizeScreen ([UIDevice renderOnDeviceSize] >= NBScreen4Dot7inch)

//屏幕高度
#define MainScreenHeight [UIScreen mainScreen].bounds.size.height

//屏幕宽度
#define MainScreenWidth [UIScreen mainScreen].bounds.size.width

//屏幕缩放比例（以iPhone5/5s: 320x568 为基准）
#define MainScreenScaleRatioX (MainScreenWidth/320.0)
#define MainScreenScaleRatioY (((MainScreenHeight)/568.0)<1?1:((MainScreenHeight)/568.0))

//iphone6的正常模式，6+的缩放模式
//#define IPHONE6 ((375 <= [[UIScreen mainScreen] bounds].size.width && [[UIScreen mainScreen] bounds].size.width < 414) ? YES:NO)

/*
 *iphone6,iphone6s zoom模式 320*568, 正常模式 375*667
 *iphone6+,iphone6s+ zoom模式 375*667，正常模式 414*736
 *iphone5s == iphone6_zoom == iphone6+_zoom == iphone6s_zomm
 *iphone6  == iphone6+_zoom == iphone6s+_zoom
 */
//
//#define kIPhone6_6S_Zoom (CGSizeEqualToSize([[UIScreen mainScreen] bounds].size,(CGSize){320,568}))
//
//////6+,6S+ 正常模式
//#define kIPHONE6_6S_Normal (CGSizeEqualToSize([[UIScreen mainScreen] bounds].size,(CGSize){375,667}))
//
////6+,6S+ zoom模式
//#define kIPhone6Plus_6SPlus_Zoom kIPHONE6_6S_Normal
//
//////6+,6S+ 正常模式
//#define kIPHONE6Plus_6SPlus_Normal (CGSizeEqualToSize([[UIScreen mainScreen] bounds].size,(CGSize){414,736}))