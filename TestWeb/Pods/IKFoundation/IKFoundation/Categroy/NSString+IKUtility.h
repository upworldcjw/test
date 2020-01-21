//
//  NSString+IKUtility.h
//  IKFoundation
//
//  Created by Chenxiaocheng on 16/7/20.
//  Copyright © 2016年 inke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (IKUtility)

/**
 *  清除首尾的空格
 *
 *  @return return value description
 */
- (NSString *)ik_trim;

/**
 *  URL编码
 *
 *  @return return value description
 */
- (NSString *)ik_URLEncodedString;


- (NSString *)ik_URLDecodedString;

/**
 *  给Url 添加query参数
 *
 *  @return return value description
 */
- (NSString *)ik_appendQueryWithString:(NSString *)queryString;
- (NSString *)ik_appendQueryWithDictionary:(NSDictionary *)dict;

- (NSString *)ik_summarizeToLength:(int)length withEllipsis:(BOOL)ellipsis;

- (NSString *)ik_substringAfter:(NSString *)needle fromEnd:(BOOL)reverse;
- (NSString *)ik_substringBefore:(NSString *)needle fromEnd:(BOOL)reverse;
/**
 *  清除指定字符串之间的内容
 *
 *  @param leftCap  leftCap description
 *  @param rightCap rightCap description
 *
 *  @return return value description
 */
- (NSString *)ik_substringBetween:(NSString *)leftCap and:(NSString *)rightCap;

- (NSString *)ik_trimSubstringFromStart:(NSString *)needle;
- (NSString *)ik_trimSubstringFromEnd:(NSString *)needle;

/**
 *  清除首尾特定的字符串
 *
 *  @param needle needle description
 *
 *  @return return value description
 */
- (NSString *)ik_trimSubstringFromBothEnds:(NSString *)needle;

/**
 *  查找是否包含特定字符串
 *
 *  @param needle needle description
 *
 *  @return return value description
 */
- (BOOL)ik_contains:(NSString *)needle;

/**
 *  HTML编码
 *
 *  @return return value description
 */
- (NSString *)ik_HTMLEncodedString;

/**
 *  返回16进制字符串
 *
 *  @return return value description
 */
- (NSString *)ik_hexString;

/**
 *  md5加密
 *
 *  @return return value description
 */
- (NSString *)ik_MD5Digest;

/**
 *  md5加密, 16位
 *
 *  @return return value description
 */
- (NSString *)ik_MD5Digest16;

/**
 *  是否是数字字符串
 *
 *  @return return value description
 */
- (BOOL)ik_isPureNumbers;

/**
 *  返回 yyyy-MM-dd
 *
 *  @return return value description
 */
- (NSDate *)ik_shortDateFromString;

/**
 *  返回 yyyy-MM-dd HH:mm:ss
 *
 *  @return return value description
 */
- (NSDate *)ik_longDateFromString;

/**
 *  计算字符串长度
 *
 *  @return return value description
 */
- (NSInteger)ik_textLength;

- (NSString *)ik_substringWithMaxLength:(NSInteger)maxLength;

/**
 *  是否包含表情
 *
 *  @return return value description
 */
- (BOOL)ik_stringContainsEmoji;

- (NSString *)ik_filterEmoji;

/**
 获取url地址中的query参数并转换为字典

 @return return value description
 */
- (NSDictionary *)ik_queryParamsToDic;

+ (id)stringWithToken:(NSString *)token, ...;

@end
