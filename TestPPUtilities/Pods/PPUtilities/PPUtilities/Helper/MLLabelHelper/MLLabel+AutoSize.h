//
//  MLLabel+AutoSize.h
//  pengpeng
//
//  Created by jianwei.chen on 15/11/2.
//  Copyright © 2015年 AsiaInnovations. All rights reserved.
//

#import <MLLabel/MLLabel.h>
#import <MLLabel/MLLinkLabel.h>
@interface MLLabel (AutoSize)

@end

@interface MLLinkLabel(AutoSize)
//+ (CGSize)sizeForText:(NSString *)text
//         withMaxWidth:(CGFloat)maxWidth
//              andFont:(UIFont *)txtFont;

+ (CGSize)sizeForText:(NSString *)text
         withMaxWidth:(CGFloat)maxWidth
              andFont:(UIFont *)txtFont
         andLineSpace:(CGFloat)lineSpace
lineMultiple:(CGFloat)lineMultiple;

+(void)refreshLabel:(MLLinkLabel *)label withMessage:(NSString *)message lineMultiple:(CGFloat)multiple;
@end
