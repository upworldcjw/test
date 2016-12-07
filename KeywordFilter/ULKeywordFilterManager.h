//
//  ULTest.hpp
//  UpLive
//
//  Created by jianwei on 8/31/16.
//  Copyright © 2016 AsiaInnovations. All rights reserved.
//

#ifndef ULTest_hpp
#define ULTest_hpp

@interface ULKeywordFilterManager : NSObject

+ (instancetype)shareInstance;

//删除当前所有关键词，重新加载关键词
- (void)reloadKeywords:(NSArray <NSString *> *)keywords;

//增加关键词keywords
- (void)insertKeyWords:(NSArray <NSString *> *)keywords;

- (BOOL)isContainsProhibitedWords:(NSString *)msg;

- (NSString *)filter:(NSString *)string replaceKeyWordWithString:(NSString *)replaceStr;

@end

#endif /* ULTest_hpp */
