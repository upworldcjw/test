//
//  MDHTMLLabel+AutoSize.m
//  pengpeng
//
//  Created by ios_feng on 15/9/15.
//  Copyright (c) 2015年 AsiaInnovations. All rights reserved.
//

#import "MDHTMLLabel+AutoSize.h"

@implementation MDHTMLLabel (AutoSize)
static MDHTMLLabel *s_shareLabel = nil;
+(MDHTMLLabel *)shareLabel{
    if (s_shareLabel == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            s_shareLabel = [[MDHTMLLabel alloc] init];
        });
    }
    return s_shareLabel;
}
+ (CGSize)sizeForText:(NSString *)text
         withMaxWidth:(CGFloat)maxWidth
              andFont:(UIFont *)txtFont{
    return [self sizeForText:text withMaxWidth:maxWidth andFont:txtFont andLineSpace:3];
}

+ (CGSize)sizeForText:(NSString *)text
         withMaxWidth:(CGFloat)maxWidth
              andFont:(UIFont *)txtFont
         andLineSpace:(CGFloat)lineSpace{
    [[self shareLabel] setFrame:CGRectMake(0, 0, maxWidth, 0)];
    [[self shareLabel] setFont:txtFont];
    [[self shareLabel] setHtmlText:text];//这里调用这个方法
    [[self shareLabel] setLeading:lineSpace];
    [[self shareLabel] setNumberOfLines:0];
    CGSize size = [[self shareLabel] sizeThatFits:CGSizeMake(maxWidth, CGFLOAT_MAX)];
    return size;
}

@end
