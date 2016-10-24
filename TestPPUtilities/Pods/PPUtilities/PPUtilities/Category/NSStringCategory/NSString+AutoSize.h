//
//  NSString+AutoSize.h
//  pengpeng
//
//  Created by jianwei.chen on 15/8/18.
//  Copyright (c) 2015年 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AutoSize)
///返回文字占用尺寸,默认最高高度
- (CGSize)sizeForFontSize:(CGFloat)fontSize withMaxWidth:(CGFloat)maxWidth;

- (CGSize)sizeForFont:(UIFont *)font withMaxWidth:(CGFloat)maxWidth;

- (CGSize)sizeForFont:(UIFont *)font withMaxWidth:(CGFloat)maxWidth textAligent:(NSTextAlignment)textAlign;

///可以指定最高高度
- (CGSize)sizeForFont:(UIFont *)font withMaxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight;


- (CGSize)nb_sizeForFontSize:(NSInteger)fontSize;

- (CGSize)nb_sizeForFont:(UIFont *)font;



@end
