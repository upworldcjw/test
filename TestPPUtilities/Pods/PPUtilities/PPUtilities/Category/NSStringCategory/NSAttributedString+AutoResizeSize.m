//
//  NSMutableAttributedString+AutoResizeSize.m
//  pengpeng
//
//  Created by chenjianwei on 15-7-27.
//  Copyright (c) 2015年 AsiaInnovations. All rights reserved.

#import "NSAttributedString+AutoResizeSize.h"
#import <UIKit/NSParagraphStyle.h>
@implementation NSAttributedString (AutoResizeSize)
-(CGSize)sizeForAttributStringMaxWidth:(CGFloat)maxWidth{
    return [self sizeForAttributStringMaxWidth:maxWidth maxHeight:CGFLOAT_MAX];
}

- (CGSize)sizeForAttributStringMaxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight{
    CGRect rect =[self boundingRectWithSize:(CGSize){maxWidth, maxHeight}                                           options:NSStringDrawingUsesLineFragmentOrigin                                          context:nil];
    CGSize size = rect.size;
    return (CGSize){ceil(size.width),ceil(size.height)};
}
@end
