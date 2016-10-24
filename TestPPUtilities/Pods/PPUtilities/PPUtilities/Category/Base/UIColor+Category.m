//
//  UIColor+Category.m
//  rili365
//
//  Created by Li Xiang on 7/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIColor+Category.h"


@implementation UIColor (UIColor_Category)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    return [self colorWithHexString:stringToConvert alpha:1.0];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor colorWithRed:0 green:200/255.0 blue:171/255.0 alpha:1.0];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor colorWithRed:0 green:200/255.0 blue:171/255.0 alpha:1.0];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
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
    
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:alpha];
}

+ (UIColor *)colorWithRGBCommaSeperatedString:(NSString *)colorString
{
    if(colorString.length == 0)
        return nil;
    NSArray * colorArray = [colorString componentsSeparatedByString:@","];
    NSAssert(colorArray.count == 3,@"fatal error");
    if(colorArray.count != 3)
        return nil;
    unsigned int r, g, b;
    r = [colorArray[0] unsignedIntValue];
    g = [colorArray[1] unsignedIntValue];
    b = [colorArray[2] unsignedIntValue];
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

@end
