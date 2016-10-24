//
//  MDHTMLLabel+AutoSize.h
//  pengpeng
//
//  Created by ios_feng on 15/9/15.
//  Copyright (c) 2015年 AsiaInnovations. All rights reserved.
//

#import "MDHTMLLabel.h"

@interface MDHTMLLabel (AutoSize)
+ (CGSize)sizeForText:(NSString *)text withMaxWidth:(CGFloat)maxWidth andFont:(UIFont *)txtFont;
+ (CGSize)sizeForText:(NSString *)text
         withMaxWidth:(CGFloat)maxWidth
              andFont:(UIFont *)txtFont
         andLineSpace:(CGFloat)lineSpace;
@end
