//
//  NSString+prohibitedWords.h
//  UpLive
//
//  Created by 王传正 on 4/21/16.
//  Copyright © 2016 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ULProhibitedWords)

@property (nonatomic, assign) BOOL hadFilterKeyWord;
///敏感词过滤
- (BOOL)isContainsProhibitedWords;

///敏感词替换
- (NSString *)filterSensitiveWords;

@end
