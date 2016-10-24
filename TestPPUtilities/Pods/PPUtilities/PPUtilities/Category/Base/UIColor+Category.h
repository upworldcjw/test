//
//  UIColor+Category.h
//  rili365
//
//  Created by Li Xiang on 7/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIColor (UIColor_Category)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha;
+ (UIColor *)colorWithRGBCommaSeperatedString:(NSString *)colorString;

@end
