//
//  NSString+Category.h
//  CalendarLib
//
//  Created by huangyi on 11-10-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (IMJsonSerial)

- (BOOL)hasValue;

- (NSArray*)toCharArray;

+ (NSString *) jsonStringWithString:(NSString *) string;

+ (NSString *) StringFromJsonhString:(NSString *) string;

+ (NSString *) chatStringFromJsonString:(NSString *) string;

+ (NSString *) jsonStringWithObject:(id) object;

+ (NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;

+ (NSString *) jsonStringWithArray:(NSArray *)array;

+ (NSString *)jsonHasStringWithDictionary:(NSDictionary *)dict
                            andObjecetKey:(NSString *)key;

+ (NSString *)getLocationCityNameWith:(NSDictionary *)locationDic;

//
- (NSString *)addPreEnterForAlertWithCondition:(NSString *)title;

//随机生成一个字母。也可以扩展为一串
+ (NSString *)randomLetterChar;
@end

//过滤html 样本
@interface NSString(FlattenHTML)
//经过滤，修改了原来的字符串
-(NSString *)stringByFlattenHTML;
@end


