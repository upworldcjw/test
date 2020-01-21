//
//  NSDate+IKUtility.h
//  IKFoundation
//
//  Created by Chenxiaocheng on 16/7/20.
//  Copyright © 2016年 inke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (IKUtility)

/**
 * 把一段时间间隔按"时：分：秒"的格式显示
 */
+ (NSString *)ik_timeIntervalFormat:(NSInteger)interval;

#pragma mark - 时间格式化显示

/**
 *  时间显示
 *  格式：1990年12月12日
 *  @param timeInterval 从1970年开始的时间戳
 */
+ (NSString *)ik_timeFormat1:(NSTimeInterval)timeInterval;

/**
 *  时间显示
 *  格式：1990年12月12日 10:10:01
 *  @param timeInterval 时间戳
 */
+ (NSString *)ik_timeFormat2:(NSTimeInterval)timeInterval;

/**
 *  时间显示
 *  格式：12:00、昨天、星期一、2014-8-11等
 *  @param byMinute 显示到分钟
 *
 *  @return 格式化时间字符串
 */
- (NSString *)ik_timeFormat3:(BOOL)byMinute;

/*
 *  时间显示：
 *  1分钟内的：刚刚
 *  1分钟外，1小时内：x分钟前
 *  1小时外，1天内：x小时前
 *  1天外，1个月内：x天前
 *  1个月外，1年内：x月x日
 *  1年外：2016/5/5(xxxx/xx/xx)
 */
+ (NSString *)ik_timeFormat4:(NSTimeInterval)timeInterval;

+ (NSString *)ik_timeFormat5:(NSTimeInterval)timeInterval;

/**
 *  时间显示
 *  24小时内：小时前
 *  30天内：多少天前
 *  超过30天：年月日
 *  @param time 时间戳
 *
 *  @return 格式化时间字符串
 */
+ (NSString *)ik_timeFormat6:(NSTimeInterval)timeInterval;

#pragma mark -

/**
 *  返回 yyyy-MM-dd
 *
 *  @param date date description
 *
 *  @return return value description
 */
- (NSString *)ik_shortDate;

/**
 *  返回 yyyy-MM-dd HH:mm:ss
 *
 *  @return return value description
 *
 */
- (NSString *)ik_longDate;

/**
 *  返回 指定格式的日期字符串
 *
 *  @param format 格式化字符串 比如:yyyy.M.d
 *
 *  @return return value description
 */
- (NSString *)ik_dateFormat:(NSString *)format;

#pragma mark -

/**
 *  获取年龄
 *
 *  @return return value description
 */
- (NSInteger)ik_ageFromBirthDay;

/**
 *  获取星座
 *
 *  @return return value description
 */
- (NSString *)ik_constellationFromBirthDay;

/**
 *  获取当前微秒时间
 *
 */
+ (double)ik_currentTimeMillis;

@end
