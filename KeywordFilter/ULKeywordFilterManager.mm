//
//  ULTest.cpp
//  UpLive
//
//  Created by jianwei on 8/31/16.
//  Copyright © 2016 AsiaInnovations. All rights reserved.
//

#include "ULKeywordFilterManager.h"
#import "aho_corasick.h"
#import "ULSensitiveWords.h"

@interface ULKeywordFilterManager (){
    aho_corasick::trie *_trie;
    NSRecursiveLock *_lock;
}
@end

@implementation ULKeywordFilterManager

+ (instancetype)shareInstance{
    static ULKeywordFilterManager *s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[ULKeywordFilterManager alloc] init];
    });
    return  s_instance;
}

- (instancetype)init{
    if (self = [super init]) {
        _lock = [[NSRecursiveLock alloc] init];
        _trie = new aho_corasick::trie;
        _trie->remove_overlaps();
//        _trie->only_whole_words();
        _trie->case_insensitive();//
    }
    return self;
}

- (void)reloadKeywords:(NSArray <NSString *> *)keywords{
    [_lock lock];
    if (_trie) {
        delete _trie;
    }
    _trie = new aho_corasick::trie;
    _trie->case_insensitive();
//    _trie->remove_overlaps();
//    .only_whole_words()
    [_lock unlock];
    
    [self insertKeyWords:keywords];
}

- (void)insertKeyWords:(NSArray <NSString *> *)keywords{
    NSMutableSet *mutSet = [NSMutableSet new];
    for(NSString *key in keywords){
        [mutSet addObject:[key lowercaseString]];//过滤相同的key
    }
    NSArray *wordsArray = mutSet.allObjects;
    NSInteger count = [wordsArray count];
    NSInteger perRecyleCount = 300;
    NSInteger fullPageNum = count / perRecyleCount;     //记录多少完整perRecyleCount
    NSInteger notFullPageNum = count % perRecyleCount;  //最后一个不完整perRecyleCount的数量
    NSInteger pageIndex = 0;    //记录第几页
    NSInteger countIndex = 0;   //记录在wordsArray的index
    
    [_lock lock];
    while (pageIndex < fullPageNum) {
        @autoreleasepool {
            for (NSInteger i = 0 ;i < perRecyleCount; i++) {
                NSString *word = [[wordsArray objectAtIndex:countIndex++] lowercaseString];
                _trie->insert([word UTF8String]);
            }
        }//@autoreleasepool
        pageIndex ++;
    }
    for (NSInteger i = 0; i < notFullPageNum; i++) {
        NSString *word = [[wordsArray objectAtIndex:countIndex++] lowercaseString];
        _trie->insert([word UTF8String]);
    }
    [_lock unlock];
}


- (void)removeKeywords:(NSArray <NSString *> *)keywords{
    [_lock lock];
    //aho_corasick::trie 目前不支持remove方法
    [_lock unlock];
}


- (NSString *)filter:(NSString *)string replaceKeyWordWithString:(NSString *)replaceStr{
    [_lock lock];
    auto tokens = _trie->tokenise([string UTF8String]);
    size_t len = tokens.size();
    
    auto realStd = std::string();
    
    for (size_t i = 0; i < len; i ++) {
        
        aho_corasick::token<char> d = tokens[i];
        if (d.get_emit().get_keyword().length()>0) {
            realStd.append(replaceStr.UTF8String);
        }
        else{
            realStd.append(d.get_fragment());
        }
    }
    [_lock unlock];
    
    NSString *realString = [NSString stringWithCString:realStd.c_str()
                                              encoding:NSUTF8StringEncoding];

    return realString;
}


- (BOOL)isContainsProhibitedWords:(NSString *)msg{
    [_lock lock];
    auto result = _trie->parse_text([msg UTF8String]);
    [_lock unlock];
    
    BOOL isContain = NO;
    if (!result.empty()) {
        isContain = YES;
    }
    return isContain;
}

@end


