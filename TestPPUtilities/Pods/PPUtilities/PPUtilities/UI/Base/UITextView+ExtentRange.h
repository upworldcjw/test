//
//  UITextView+ExtentRange.h
//  pengpeng
//
//  Created by Mingde.Piao on 15/4/15.
//  Copyright (c) 2015年 AsiaInnovations. All rights reserved.
//

#import <UIKit/UIKit.h>
//extern NSString * const _Nonnull kImgTextPartern;
@interface UITextView (ExtentRange)

- (NSRange)selectedRange;
- (void)setSelectedRange:(NSRange)range;

@end

//jianwei.chen add 20150721
@interface UITextView (EmotionSupport)
//从光标处删除
//- (void)deleteTextFromSelectedRange;

- (void)textAppendSelectedRange:(NSString *)emotion;

//从最后端删除
//- (void)deleteLastCharter;
//- (void)keepSelectedRangeChangeText:(NSString *)text;
//如果最后一个是自定义表情则删除
//-(BOOL)deleteIfLastCharaterIsCustomedEmoj;
@end
