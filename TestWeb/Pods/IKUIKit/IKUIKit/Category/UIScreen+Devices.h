//
//  UIScreen+Devices.h
//  inke
//
//  Created by Charles Wang on 16/3/10.
//  Copyright © 2016年 MeeLive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (Devices)

// Detection For iPhone 6
- (BOOL)isiPhone6;
- (BOOL)isFourSevenPhone;
- (BOOL)isFiveFivePhone;

// Detection For iPhone 5, 5s, 5c
- (BOOL)isFourPhone;
- (BOOL)isiPhone5or5s;

// Detection For iPhone 4, 3GS, 3, Original
- (BOOL)isThreeFivePhone;
- (BOOL)isiPhoneFourSOrBelow;

// Detection For iPad
- (BOOL)isiPad;

//// General Utilities
//+ (CGFloat)ScreenHeight;
//+ (CGFloat)ScreenWidth;

@end
