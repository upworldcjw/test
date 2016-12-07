//
//  NSString+prohibitedWords.m
//  UpLive
//
//  Created by 王传正 on 4/21/16.
//  Copyright © 2016 AsiaInnovations. All rights reserved.
//

#import "NSString+ULProhibitedWords.h"
#import "ULSensitiveWords.h"
#import "ULKeywordFilterManager.h"
#import <objc/runtime.h>

static const void *kHadFilterKeyWord = &kHadFilterKeyWord;

@implementation NSString (ULProhibitedWords)

- (void)setHadFilterKeyWord:(BOOL)hadFilterKeyWord{
    objc_setAssociatedObject(self, kHadFilterKeyWord, @(hadFilterKeyWord), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)hadFilterKeyWord{
    NSNumber *obj = objc_getAssociatedObject(self, kHadFilterKeyWord);
    if (obj) {
        return [obj boolValue];
    }
    return NO;
}

//敏感词过滤
- (BOOL)isContainsProhibitedWords{
    return [[ULKeywordFilterManager shareInstance] isContainsProhibitedWords:self];
}

///敏感词替换
- (NSString *)filterSensitiveWords {
    if (self.hadFilterKeyWord) {
        return self;
    }
    NSString *filter = [[ULKeywordFilterManager shareInstance] filter:self replaceKeyWordWithString:@"***"];
    filter.hadFilterKeyWord = YES;
    return filter;
}

@end
