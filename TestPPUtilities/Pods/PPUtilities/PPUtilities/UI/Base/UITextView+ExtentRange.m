//
//  UITextView+ExtentRange.m
//  pengpeng
//
//  Created by Mingde.Piao on 15/4/15.
//  Copyright (c) 2015年 AsiaInnovations. All rights reserved.
//

#import "UITextView+ExtentRange.h"
//#import "MLExpression+NBExpressionExp.h"

@implementation UITextView (ExtentRange)

- (NSRange)selectedRange{
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}

- (void)setSelectedRange:(NSRange)range{
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    
    [self setSelectedTextRange:selectionRange];
}

@end


@implementation UITextView (EmotionSupport)
- (void)deleteTextFromSelectedRange{
    NSString* tmp = self.text;
    //模仿微信，表情键盘始终从最后面删除
    if ([tmp length] == 0 || self.selectedRange.location == 0) {//如果文本为空,或者删除键盘再第一个
        return;
    }
    NSRange range = NSMakeRange(0, 0);
    if (self.selectedRange.length > 0) {
        range =  self.selectedRange;
    } else {
        //处理系统键盘输入的表情 或者 程序中表情字符集
        range = [tmp rangeOfComposedCharacterSequenceAtIndex:self.selectedRange.location-1];
    }
    tmp = [tmp stringByReplacingCharactersInRange:range withString:@""];
    
    //textView 赋值之后修改selectedRange
    self.text = tmp;
    self.selectedRange = NSMakeRange(range.location, 0);
}

- (void)textAppendSelectedRange:(NSString *)emotion{
    NSString *new = [self.text stringByReplacingCharactersInRange:self.selectedRange withString:emotion];
    NSRange oldRange = self.selectedRange;
    NSRange newRange = NSMakeRange(oldRange.location + [emotion length], 0);
    self.text = new;
    [self setSelectedRange:newRange];
}

@end


