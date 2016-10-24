//
//  UITextView+Emotion.h
//  pengpeng
//
//  Created by jianwei.chen on 16/2/14.
//  Copyright © 2016年 AsiaInnovations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLExpression+NBExpressionExp.h"
@interface UITextView (Emotion)
//模仿微信删除
//删除最后一个字符，包括表情，字母，自定义表情
- (void)deleteLastCharter;

-(BOOL)deleteIfLastCharaterIsCustomedEmoj;

@end
