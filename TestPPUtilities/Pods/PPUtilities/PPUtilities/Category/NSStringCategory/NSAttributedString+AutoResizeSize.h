//
//  NSMutableAttributedString+AutoResizeSize.h
//  pengpeng
//
//  Created by chenjianwei on 15-7-27.
//  Copyright (c) 2015年 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSAttributedString (AutoResizeSize)

///返回文字占用尺寸
-(CGSize)sizeForAttributStringMaxWidth:(CGFloat)maxWidth;

- (CGSize)sizeForAttributStringMaxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight;

@end
