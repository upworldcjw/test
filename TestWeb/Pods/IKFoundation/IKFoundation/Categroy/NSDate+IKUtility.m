//
//  NSDate+IKUtility.m
//  IKFoundation
//
//  Created by Chenxiaocheng on 16/7/20.
//  Copyright © 2016年 inke. All rights reserved.
//

#import "NSDate+IKUtility.h"

@implementation NSDate (IKUtility)

+ (NSString *)ik_timeIntervalFormat:(NSInteger)interval {
    int hour = (int)(interval / 3600);
    int min = (interval % 3600) / 60;
    int second = interval % 60;
    NSString *h = [NSString stringWithFormat:@"%02d", hour];
    NSString *m = [NSString stringWithFormat:@"%02d", min];
    NSString *s = [NSString stringWithFormat:@"%02d", second];
    
    if ([h isEqualToString:@"00"]) {
        return [NSString stringWithFormat:@"%@:%@", m, s];
    }
    return [NSString stringWithFormat:@"%@:%@:%@", h, m, s];
}

#pragma mark -

+ (NSString *)ik_timeFormat1:(NSTimeInterval)timeInterval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:NSLocalizedString(@"COMMON_timeFormate", nil)];
    NSString *dateStr = [df stringFromDate:date];
    return dateStr;
}

+ (NSString *)ik_timeFormat2:(NSTimeInterval)timeInterval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:NSLocalizedString(@"COMMON_timeFormate_yyyMMddHHmmsss", nil)];
    NSString *dateStr = [df stringFromDate:date];
    return dateStr;
}

- (NSString *)ik_timeFormat3:(BOOL)byMinute {
    NSString *tempstr = nil;
    //   获取原始数据的时间
    NSInteger oldyear, oldmonth, oldday, oldhour, oldmin, oldsec, oldweek;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =
    NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    comps = [calendar components:unitFlags fromDate:self];
    oldyear = [comps year];
    oldweek = [comps weekday];
    oldmonth = [comps month];
    oldday = [comps day];
    oldhour = [comps hour];
    oldmin = [comps minute];
    oldsec = [comps second];
    
    //获取现在的时间
    NSInteger year, month, day, hour, min, sec, week;
    NSDateComponents *comps2 = [[NSDateComponents alloc] init];
    comps2 = [calendar components:unitFlags fromDate:[NSDate date]];
    year = [comps2 year];
    week = [comps2 weekday];
    month = [comps2 month];
    day = [comps2 day];
    hour = [comps2 hour];
    min = [comps2 minute];
    sec = [comps2 second];
    
    NSTimeInterval secondsdate = [[NSDate date] timeIntervalSinceDate:self];
    if (secondsdate < 3600 * 24 && secondsdate > 0) {
        if (oldday == day) {
            tempstr = [[self class] amString:self withTime:byMinute];
        } else {
            tempstr = [[self class] yestDayString:self withTime:byMinute];
        }
    } else if (secondsdate > 3600 * 24 && secondsdate < 3600 * 24 * 2) {
        tempstr = [[self class] yestDayString:self withTime:byMinute];
    } else if (secondsdate > 3600 * 24 * 2 && secondsdate < 3600 * 24 * 7) {
        tempstr = [[self class] weekString:self withTime:byMinute];
        
    } else if (secondsdate <= 0) { // 未来时间直接按今天格式显示
        tempstr = [[self class] amString:self withTime:byMinute];
    } else {
        tempstr = [[self class] yearStringFromDate:self withTime:byMinute];
    }
    
    return tempstr;
}

+ (NSString *)ik_timeFormat4:(NSTimeInterval)timeInterval {
    NSTimeInterval late = timeInterval;
    if (timeInterval / 1000000000 > 10) {
        // 毫秒级时间戳->秒
        late = timeInterval / 1000;
    }
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDate *ldate = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)late];
    NSTimeInterval now = [dat timeIntervalSince1970];
    NSString *timeString = @"";
    NSTimeInterval diff = now - late;
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* componentsNow = [calendar components:NSCalendarUnitYear fromDate:dat];
    NSDateComponents* componentsT = [calendar components:NSCalendarUnitYear fromDate:ldate];
    NSInteger nowYear = [componentsNow year];
    NSInteger tYear = [componentsT year];
    if (nowYear != tYear) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSTimeZone *timeZone = [NSTimeZone localTimeZone];
        [dateFormatter setTimeZone:timeZone];
        [dateFormatter setDateFormat:@"yyyy/M/d"];
        timeString = [dateFormatter stringFromDate:ldate];
        return timeString;
    }
    
    // 24小时之内的
    long time = 0;
    if (diff / 3600 <= 1) {
        // 1分钟内的：刚刚
        // 1分钟外，1小时内：x分钟前
        time = diff / 60;
        timeString = time > 1 ? [NSString stringWithFormat:@"%ld分钟前", time] : @"刚刚";
    } else if (diff / 3600 > 1 && diff / 86400 < 1) {
        // 1小时外，1天内：x小时前
        time = diff / 3600;
        timeString = [NSString stringWithFormat:@"%ld小时前", time];
    } else if (diff / 86400 >= 1 && diff / 86400 <= 30) {
        // 1天外，1个月内：x天前
        time = diff / 86400;
        timeString = [NSString stringWithFormat:@"%ld天前", time];
    } else if (diff / 86400 < 365) {
        // 1个月外，1年内：x月x日
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSTimeZone *timeZone = [NSTimeZone localTimeZone];
        [dateFormatter setTimeZone:timeZone];
        [dateFormatter setDateFormat:@"M月d日"];
        timeString = [dateFormatter stringFromDate:ldate];
    } else {
        // 1年外：2016/5/5(xxxx/xx/xx)
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSTimeZone *timeZone = [NSTimeZone localTimeZone];
        [dateFormatter setTimeZone:timeZone];
        [dateFormatter setDateFormat:@"yyyy/M/d"];
        timeString = [dateFormatter stringFromDate:ldate];
    }
    
    return timeString;
}

+ (NSString *)ik_timeFormat5:(NSTimeInterval)timeInterval {
    NSTimeInterval late = timeInterval;
    if (timeInterval / 1000000000 > 10) {
        // 毫秒级时间戳->秒
        late = timeInterval / 1000;
    }
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDate *ldate = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)late];
    NSTimeInterval now = [dat timeIntervalSince1970];
    NSString *timeString = @"";
    NSTimeInterval diff = now - late;
    
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    
    NSDateFormatter *todayFormatter = [[NSDateFormatter alloc] init];
    [todayFormatter setTimeZone:timeZone];
    [todayFormatter setDateFormat:@"yyyy-M-d"];
    NSString *todayStr = [todayFormatter stringFromDate:dat];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-M-d"];
    timeString = [dateFormatter stringFromDate:ldate];
    
    if (diff / 86400 < 1 && [todayStr isEqualToString:timeString]) {
        timeString = @"今天";
    }
    
    return timeString;
}

+ (NSString *)ik_timeFormat6:(NSTimeInterval)timeInterval {
    int hour = (int)((int)time(NULL) - timeInterval) / 3600;
    if (hour < 1) {
        return NSLocalizedString(@"COMMON_inOneHour", nil);
    }
    if (hour < 24) {
        return
        [NSString stringWithFormat:@"%d%@", hour, hour == 1 ? NSLocalizedString(@"COMMON_hourBefore", nil) : NSLocalizedString(@"COMMON_hoursBefore", nil)];
    }
    
    if (hour < 30 * 24) {
        return [NSString
                stringWithFormat:@"%d%@", hour / 24, hour / 24 == 1 ? NSLocalizedString(@"COMMON_dayBefore", nil) : NSLocalizedString(@"COMMON_daysBefore", nil)];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:NSLocalizedString(@"COMMON_timeFormate", nil)];
    
    NSDate *ldate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    return [dateFormatter stringFromDate:ldate];
}

#pragma mark -

- (NSString *)ik_shortDate {
    return [self ik_dateFormat:@"yyyy-MM-dd"];
}

- (NSString *)ik_longDate {
    return [self ik_dateFormat:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *)ik_dateFormat:(NSString *)format {
    NSDateFormatter *fa = [[NSDateFormatter alloc] init];
    [fa setDateFormat:format];
    [fa setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    [fa setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    return [fa stringFromDate:self];
}

#pragma mark -

- (NSInteger)ik_ageFromBirthDay {
    NSDate *birth = self;
    // 出生日期转换年月日
    NSCalendarUnit unit =
    NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *components1 =
    [[NSCalendar currentCalendar] components:unit fromDate:birth];
    NSInteger brithDateYear = [components1 year];
    NSInteger brithDateDay = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前年月日
    NSDateComponents *components2 =
    [[NSCalendar currentCalendar] components:unit fromDate:[NSDate date]];
    NSInteger currentDateYear = [components2 year];
    NSInteger currentDateDay = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) ||
        (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    
    return iAge;
}

- (NSString *)ik_constellationFromBirthDay {
    NSDate *birth = self;
    NSDateFormatter *fa = [[NSDateFormatter alloc] init];
    [fa setDateFormat:@"yyyy-MM-dd"];
    NSString *birthStr = [fa stringFromDate:birth];
    
    //将获取的时间转换为数组
    NSArray *birthArr = [birthStr componentsSeparatedByString:@"-"];
    
    //获取月份和日期
    NSInteger mouth = [[birthArr objectAtIndex:1] integerValue];
    NSInteger day = [[birthArr objectAtIndex:2] integerValue];
    
    NSString *constellationStr;
    //根据日子得到相应的星座
    switch (mouth) {
        case 1:
            if (day > 0 && day < 20) {
                constellationStr = @"摩羯座";
            } else {
                constellationStr = @"水瓶座";
            }
            break;
        case 2:
            if (day > 0 && day < 19) {
                constellationStr = @"水瓶座";
            } else {
                constellationStr = @"双鱼座";
            }
            break;
        case 3:
            if (day > 0 && day < 21) {
                constellationStr = @"双鱼座";
            } else {
                constellationStr = @"白羊座";
            }
            break;
        case 4:
            if (day > 0 && day < 20) {
                constellationStr = @"白羊座";
            } else {
                constellationStr = @"金牛座";
            }
            break;
        case 5:
            if (day > 0 && day < 21) {
                constellationStr = @"金牛座";
            } else {
                constellationStr = @"双子座";
            }
            break;
        case 6:
            if (day > 0 && day < 22) {
                constellationStr = @"双子座";
            } else {
                constellationStr = @"巨蟹座";
            }
            break;
        case 7:
            if (day > 0 && day < 23) {
                constellationStr = @"巨蟹座";
            } else {
                constellationStr = @"狮子座";
            }
            break;
        case 8:
            if (day > 0 && day < 23) {
                constellationStr = @"狮子座";
            } else {
                constellationStr = @"处女座";
            }
            break;
        case 9:
            if (day > 0 && day < 23) {
                constellationStr = @"处女座";
            } else {
                constellationStr = @"天秤座";
            }
            
            break;
            
        case 10:
            if (day > 0 && day < 24) {
                constellationStr = @"天秤座";
            } else {
                constellationStr = @"天蝎座";
            }
            break;
        case 11:
            if (day > 0 && day < 23) {
                constellationStr = @"天蝎座";
            } else {
                constellationStr = @"射手座";
            }
            break;
        case 12:
            if (day > 0 && day < 22) {
                constellationStr = @"射手座";
            } else {
                constellationStr = @"摩羯座";
            }
            break;
        default:
            break;
    }
    return constellationStr;
}

+ (double)ik_currentTimeMillis
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970] * 1000.f;
    
    return ceil((double)time);
}

#pragma mark - inner

+ (NSString *)amString:(NSDate *)date withTime:(BOOL)withTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"ah:mm"];
    NSString *str = [dateFormatter stringFromDate:date];
    return str;
}

+ (NSString *)yestDayString:(NSDate *)date withTime:(BOOL)withTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"h:mm"];
    NSString *str = [dateFormatter stringFromDate:date];
    NSString *yesterdaystr = NSLocalizedString(@"COMMON_yesterday", nil);
    
    if (withTime) {
        return [NSString stringWithFormat:@"%@ %@", yesterdaystr, str];
    } else {
        return yesterdaystr;
    }
}

+ (NSString *)weekString:(NSDate *)date withTime:(BOOL)withTime {
    NSInteger year, month, day, hour, min, sec, week;
    NSString *weekStr = nil;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =
    NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    comps = [calendar components:unitFlags fromDate:date];
    year = [comps year];
    week = [comps weekday];
    month = [comps month];
    day = [comps day];
    hour = [comps hour];
    min = [comps minute];
    sec = [comps second];
    
    if (week == 1) {
        weekStr = NSLocalizedString(@"COMMON_sunday", nil);
    } else if (week == 2) {
        weekStr = NSLocalizedString(@"COMMON_monday", nil); // MELocalizedStringForKeyWithTable(@"monday",
        // @"Global");
        
    } else if (week == 3) {
        weekStr = NSLocalizedString(@"COMMON_tuesday", nil); // MELocalizedStringForKeyWithTable(@"tuesday",
        // @"Global");
        
    } else if (week == 4) {
        weekStr = NSLocalizedString(@"COMMON_wednesday", nil); // MELocalizedStringForKeyWithTable(@"wednesday",
        // @"Global");
        
    } else if (week == 5) {
        weekStr = NSLocalizedString(@"COMMON_thursday", nil); // MELocalizedStringForKeyWithTable(@"thursday",
        // @"Global");
        
    } else if (week == 6) {
        weekStr = NSLocalizedString(@"COMMON_friday", nil); // MELocalizedStringForKeyWithTable(@"friday",
        // @"Global");
        
    } else if (week == 7) {
        weekStr = NSLocalizedString(@"COMMON_saturday", nil); // MELocalizedStringForKeyWithTable(@"saturday",
        // @"Global");
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"a h:mm"];
    NSString *str = [dateFormatter stringFromDate:date];
    
    if (withTime) {
        return [NSString stringWithFormat:@"%@ %@", weekStr, str];
    } else {
        return weekStr;
    }
}

+ (NSString *)yearStringFromDate:(NSDate *)date withTime:(BOOL)withTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:withTime ? NSLocalizedString(@"COMMON_timeFormate_yyyMMddHHmm", nil) : NSLocalizedString(@"COMMON_timeFormate", nil)];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

@end
