//
//  NSDate+Category.h
//  cal365
//
//  Created by Li Xiang
//

#import <Foundation/Foundation.h>
@interface NSDate (DateFormatter)

- (NSString *)yearStr;
- (NSString *)monthStr;
- (NSString *)dayStr;
- (NSString *)hourStr;

- (NSString *)fullStyleDate;
- (NSString *)fullStyleDateChinese;
- (NSString *)fullStyleDateWithWeekDay;
- (NSString *)fullStyleDateWithoutYear;
- (NSString *)fullStyleChineseDateWithoutYear;
- (NSString *)fullStyleDateWithoutDay;
- (NSString *)fullStyleDateWithSep:(NSString *)sepStr;
- (NSString *)fullStyleDateTimeWithoutSecond;
- (NSString *)fullStyleDateTime;
- (NSString *)dateStringWithFormat:(NSString *)format;
- (NSString *)dateStringWithFormatter:(NSDateFormatter *)formatter;
- (NSString *)timeInDay;
//取分钟
- (NSString*)minuteInDay;
- (NSNumber*) dayNumber;
- (NSString*) monthYearString;
@end

@interface NSDate (NSCalendar)

#define  KMinuteOneDay   86400

struct DateInformation {
	int day;
	int month;
	int year;
	int weekday;
	int minute;
	int hour;
	int second;

};
typedef struct DateInformation DateInformation;
- (DateInformation)dateInformation;
- (NSDateComponents*)dateComponentsDetail;
+ (NSDate*)dateFromDateInformation:(DateInformation)info;
+ (NSDate*)GMTDateFromDateInformation:(DateInformation)info;
+ (NSDate*)dateFromDescriptionString:(NSString *)desStr;
+ (NSDate*)dateFromDateString:(NSString *)dateTimeStr;
+ (NSDate*)currentDateTime;
- (NSDate *)getDatePart;

@property (readonly,nonatomic) NSInteger weekdayWithMondayFirst;


- (NSString *)simpleChineseWeekdayStr;
- (NSString *)ChineseWeekdayStr;

- (NSInteger)differenceInDaysTo:(NSDate *)toDate;
- (NSInteger)differenceInMonthsTo:(NSDate *)toDate;
- (NSInteger)differenceYearsFrom:(NSDate *)start;
@property (readonly,nonatomic) BOOL isToday;

- (long long)toMilliSecond;
+ (long long)timestamp;
- (NSString*) dateDescription;
+ (NSDate*)dateFromMilliSecond:(long long)milliSecond;
- (NSDate*)dateWithNewTimeZone:(NSString*)timeZone;

- (NSDate *)firstDayOfMonth;
+ (NSDate *)firstMonthDayOfDate:(NSDate *)date;
- (NSDate *)lastDayOfMonth;
+ (NSDate *)lastMonthDayOfDate:(NSDate *)date;

- (NSInteger)weekday;
- (NSInteger)daysInMonth;
- (NSInteger)dayOfWeekInMonth;
- (NSString *)yearMonthStrWithSep:(NSString *)sepSt;
- (CFGregorianDate)getGregorianDate;
+ (NSDate *)dateFromCFGregorianDate:(CFGregorianDate)info;
+ (NSDate*) GMTDateFromCFGregorianDate:(CFGregorianDate)info;


//判断两个时间是不是同一天
- (BOOL)isSameDay:(NSDate*)anotherDate;
- (BOOL)isSameDay2:(long long)date;

//截至到现在的时间。
+(NSString*)getTimeStampFromReceiveTime:(long long)receiveTime;
@end
