//
//  UITextView+Emotion.m
//  pengpeng
//
//  Created by jianwei.chen on 16/2/14.
//  Copyright © 2016年 AsiaInnovations. All rights reserved.
//

#import "UITextView+Emotion.h"

@implementation UITextView (Emotion)
//模仿微信删除
//删除最后一个字符，包括表情，字母，自定义表情
- (void)deleteLastCharter{
    NSString* tmp = self.text;
    //模仿微信，表情键盘始终从最后面删除
    if ([tmp length] == 0 || self.selectedRange.location == 0) {//如果文本为空,或者删除键盘再第一个
        return;
    }
    BOOL deleteOk = [self deleteIfLastCharaterIsCustomedEmoj];
    if (deleteOk) {
        return;
    }
    NSRange range = NSMakeRange(0, 0);
    //按正常逻辑删除自定义表情
    range = [tmp rangeOfComposedCharacterSequenceAtIndex:[tmp length]-1];//最后一个字符如果是表情
    tmp = [tmp stringByReplacingCharactersInRange:range withString:@""];
    //textView 赋值之后修改selectedRange
    self.text = tmp;
}

-(BOOL)deleteIfLastCharaterIsCustomedEmoj{
    NSString *tmp = self.text;
    NSRange range;
    if ([tmp emotionKeyAtEnd:&range]) {
        self.text = [tmp substringToIndex:range.location];
        return YES;
    }
    return NO;
}

@end
