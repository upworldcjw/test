//
//  IKThemeDefine.h
//  IKUIKit
//
//  Created by Chenxiaocheng on 16/8/12.
//  Copyright © 2016年 inke. All rights reserved.
//

#ifndef IKThemeDefine_h
#define IKThemeDefine_h


// color
///< format：0xFFFFFF
#define k16RGBColor(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

#define kIKColor(r,g,b,a) \
[UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]

#define mIKColor_1  kIKColor(0  ,216,201,1)
#define mIKColor_2  kIKColor(0  ,205,91 ,1)    //#
#define mIKColor_3  kIKColor(255,145,22 ,1)
#define mIKColor_4  kIKColor(246,61 ,61 ,1)
#define mIKColor_5  kIKColor(245,251,251,1)
#define mIKColor_6  kIKColor(181,55 ,255,1)
#define mIKColor_7  kIKColor(90 ,156,248,1)
#define mIKColor_8  kIKColor(107,210,67 ,1)
#define mIKColor_9  kIKColor(68 ,68 ,68 ,1)
#define mIKColor_10 kIKColor(240,247,246,1)
#define mIKColor_11 kIKColor(0  ,0  ,0  ,1)   //#000000
#define mIKColor_12 kIKColor(255,255,255,1)
#define mIKColor_13 kIKColor(86 ,98 ,102,1)
#define mIKColor_14 kIKColor(145,159,163,1)
#define mIKColor_15 kIKColor(0  ,33 ,54 ,1)
#define mIKColor_16 kIKColor(0  ,0  ,0  ,0.1)
#define mIKColor_17 kIKColor(222,127,225,1)
#define mIKColor_18 kIKColor(176,146,254,1)
#define mIKColor_19 kIKColor(239,242,244,1)
#define mIKColor_20 kIKColor(153,153,153,1)
#define mIKColor_21 kIKColor(248,231,28 ,1)
#define mIKColor_22 kIKColor(255,161,91 ,1)
#define mIKColor_23 kIKColor(230,90 ,130,1)
#define mIKColor_24 kIKColor(142,226,211,1)
#define mIKColor_25 kIKColor(199,241,226,1)
#define mIKColor_26 kIKColor(255,255,255,1)
#define mIKColor_27 kIKColor(170,170,170,1)
#define mIKColor_28 kIKColor(235,235,235,1)
#define mIKColor_29 kIKColor(60 ,142,134,1)
#define mIKColor_30 kIKColor(128,204,197,1)
#define mIKColor_31 kIKColor(107,210,67 ,1)
#define mIKColor_32 kIKColor(132,145,149,1)
#define mIKColor_33 kIKColor(245,251,251,1)
#define mIKColor_34 kIKColor(245,251,251,1)

#define mIKColor_35 kIKColor(204,204,204,1)     //#CCCCCC
#define mIKColor_36 kIKColor(0,  255,255,1)     //#00FFFF
#define mIKColor_37 kIKColor(255,255,255,0.5)

// UIFont

#define mIKSystemFont(size) [UIFont systemFontOfSize:(size)]
#define IKBoldSystenFont(size) [UIFont boldSystemFontOfSize:(size)]

#define mIKSystemFont10 mIKSystemFont(10)
#define mIKSystemFont11 mIKSystemFont(11)
#define mIKSystemFont12 mIKSystemFont(12)
#define mIKSystemFont13 mIKSystemFont(13)
#define mIKSystemFont14 mIKSystemFont(14)
#define mIKSystemFont15 mIKSystemFont(15)
#define mIKSystemFont16 mIKSystemFont(16)
#define mIKSystemFont18 mIKSystemFont(18)
#define mIKSystemFont22 mIKSystemFont(22)
#define mIKSystemFont24 mIKSystemFont(24)
#define mIKSystemFont26 mIKSystemFont(26)
#define mIKSystemFont30 mIKSystemFont(30)
#define mIKSystemFont32 mIKSystemFont(32)
#define mIKSystemFont36 mIKSystemFont(36)

static inline UIColor *colorWithHexString(NSString *color)
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    // 找到RGBA对应的位数并转换
    if ([cString length] == 6) {
        NSRange range;
        range.location = 0;
        range.length = 2;
        //R、G、B
        NSString *rString = [cString substringWithRange:range];
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];
        // Scan values
        unsigned int r, g, b;
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:1.0f];
    }else if ([cString length] == 8){
        NSRange range;
        range.location = 0;
        range.length = 2;
        //A,R、G、B
        NSString *aString = [cString substringWithRange:range];
        range.location = 2;
        NSString *rString = [cString substringWithRange:range];
        range.location = 4;
        NSString *gString = [cString substringWithRange:range];
        range.location = 6;
        NSString *bString = [cString substringWithRange:range];
        // Scan values
        unsigned int a,r, g, b;
        [[NSScanner scannerWithString:aString] scanHexInt:&a];
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        
        return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:((float)a / 255.0f)];
    }
    return [UIColor clearColor];
}

/**
 通过16进制色值获取UIColor对象
 
 @param hexValue 16进制颜色值，如：0x000000
 @param alpha 透明度，取值范围：0~1
 @return UIColor对象
 */
static inline UIColor *IKHexColor(unsigned int hexValue, CGFloat alpha) {
    return [UIColor colorWithRed:((float)(((hexValue) & 0xFF0000) >> 16))/255.0 green:((float)(((hexValue) & 0xFF00) >> 8))/255.0 blue:((float)((hexValue) & 0xFF))/255.0 alpha:alpha];
}


/**
 通过RGBA色值获取UIColor对象

 @param read 红色，取值范围：0~255
 @param green 绿色，取值范围：0~255
 @param blue 蓝色，取值范围：0~255
 @param alpha 透明度，取值范围：0~1
 @return UIColor对象
 */
static inline UIColor *IKRGBColor(CGFloat read, CGFloat green, CGFloat blue, CGFloat alpha) {
    return [UIColor colorWithRed:(read)/255.0f green:(green)/255.0f blue:(blue)/255.0f alpha:alpha];
}

#endif /* IKThemeDefine_h */
