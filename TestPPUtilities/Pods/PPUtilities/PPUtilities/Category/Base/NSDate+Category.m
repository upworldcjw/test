//
//  NSDate+Category.m
//  cal365
//
//  Created by Li Xiang
//

#import "NSDate+Category.h"
//#import "NBAppDelegate.h"

@implementation NSDate (DateFormatter)
- (NSDateFormatter *)sharedDateFormatter
{
    static NSDateFormatter *sUserVisibleDateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sUserVisibleDateFormatter == nil) {
            sUserVisibleDateFormatter = [[NSDateFormatter alloc] init];
        }
    });
    return sUserVisibleDateFormatter;
}

- (NSString *)yearStr {
    [[self sharedDateFormatter] setDateFormat:@"yyyy"];
    return [[self sharedDateFormatter] stringFromDate:self];
}

- (NSString *)monthStr {
    [[self sharedDateFormatter] setDateFormat:@"MMMM"];
    return [[self sharedDateFormatter] stringFromDate:self];
}

- (NSString *)dayStr {
    [[self sharedDateFormatter] setDateFormat:@"d"];
    return [[self sharedDateFormatter] stringFromDate:self];
}

- (NSString *)hourStr {
    [[self sharedDateFormatter] setDateFormat:@"h a"];
    return [[self sharedDateFormatter] stringFromDate:self];
}


- (NSString *)fullStyleDate {
    [[self sharedDateFormatter] setDateFormat:@"yyyy-MM-dd"];
    return [[self sharedDateFormatter] stringFromDate:self];
}

- (NSString *)dateStringWithFormat:(NSString *)format {
    [[self sharedDateFormatter] setDateFormat:format];
    return [[self sharedDateFormatter] stringFromDate:self];
}

- (NSString *)dateStringWithFormatter:(NSDateFormatter *)formatter {
    return [formatter stringFromDate:self];
}

- (NSString *)fullStyleDateChinese {
    [[self sharedDateFormatter] setDateFormat:@"yyyy年MM月dd日"];
    return [[self sharedDateFormatter] stringFromDate:self];
}

- (NSString *)fullStyleDateWithWeekDay {
    [[self sharedDateFormatter] setDateFormat:@"yyyy年MM月dd日"];
    return [NSString stringWithFormat:@"%@ %@", [[self sharedDateFormatter] stringFromDate:self], [self ChineseWeekdayStr]];
}

- (NSString *)fullStyleDateWithoutDay {
    [[self sharedDateFormatter] setDateFormat:@"yyyy年MM月"];
    return [[self sharedDateFormatter] stringFromDate:self];
}

- (NSString *)fullStyleDateWithoutYear {
    [[self sharedDateFormatter] setDateFormat:@"MM-dd"];
    return [[self sharedDateFormatter] stringFromDate:self];
}
- (NSString *)timeInDay {
    [[self sharedDateFormatter] setDateFormat:@"HH:mm"];
    return [[self sharedDateFormatter] stringFromDate:self];
}

- (NSString *)fullStyleChineseDateWithoutYear {
    [[self sharedDateFormatter] setDateFormat:@"MM月dd日"];
    return [[self sharedDateFormatter] stringFromDate:self];
}

- (NSString *)fullStyleDateWithSep:(NSString *)sepStr {
    [[self sharedDateFormatter] setDateFormat:[NSString stringWithFormat:@"yyyy%@MM%@dd", sepStr, sepStr]];
    return [[self sharedDateFormatter] stringFromDate:self];
}

- (NSString *)fullStyleDateTimeWithoutSecond {
    [[self sharedDateFormatter] setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [[self sharedDateFormatter] stringFromDate:self];
}

- (NSString *)fullStyleDateTime {
    [[self sharedDateFormatter] setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [[self sharedDateFormatter] stringFromDate:self];
}

- (NSString*)minuteInDay;
{
    [[self sharedDateFormatter] setDateFormat:@"mm"];
    return [[self sharedDateFormatter] stringFromDate:self];
}


- (NSNumber*) dayNumber{
    [[self sharedDateFormatter] setDateFormat:@"d"];
    return [NSNumber numberWithInt:[[[self sharedDateFormatter] stringFromDate:self] intValue]];
}

- (NSString*) monthYearString{
    [[self sharedDateFormatter] setDateFormat:@"MMMM yyyy"];
    return [[self sharedDateFormatter] stringFromDate:self];
}

@end

@implementation NSDate (NSCalendar)

+ (NSDate*)currentDateTime {
    return [NSDate dateFromDateInformation:[[NSDate date] dateInformation]];
}

- (DateInformation) dateInformation{
	
	DateInformation info;
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comp = [gregorian components:(NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit | 
													NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit) 
										  fromDate:self];
	info.day = (int)[comp day];
	info.month = (int)[comp month];
	info.year = (int)[comp year];
	info.weekday = (int)[comp weekday];
	info.hour = (int)[comp hour];
	info.minute = (int)[comp minute];
	info.second = (int)[comp second];
	
	return info;
}

- (NSDateComponents*)dateComponentsDetail {
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comp = [gregorian components:(NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit | 
													NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit | NSWeekCalendarUnit | NSWeekOfMonthCalendarUnit) 
										  fromDate:self];

	return comp;
}

+ (NSDate*) dateFromDateInformation:(DateInformation)info {
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
	NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:[NSDate date]];
	
	[comp setDay:info.day];
	[comp setMonth:info.month];
	[comp setYear:info.year];
	[comp setHour:info.hour];
	[comp setMinute:info.minute];
	[comp setSecond:info.second];
    
	return [gregorian dateFromComponents:comp];
}

+ (NSDate*) GMTDateFromDateInformation:(DateInformation)info {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
    [gregorian setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:[NSDate date]];
	
	[comp setDay:info.day];
	[comp setMonth:info.month];
	[comp setYear:info.year];
	[comp setHour:info.hour];
	[comp setMinute:info.minute];
	[comp setSecond:info.second];
	
	return [gregorian dateFromComponents:comp];
}

+ (NSDate*) dateFromDescriptionString:(NSString *)desStr {
	// desStr: "2010-06-28 00:00:00.0"
	int year = [[desStr substringWithRange:NSMakeRange(0, 4)] intValue];
	int month = [[desStr substringWithRange:NSMakeRange(5, 2)] intValue];
	int day = [[desStr substringWithRange:NSMakeRange(8, 2)] intValue];
    int hour = 0;
    int minute = 0;
    if (desStr.length > 10) {
        hour = [[desStr substringWithRange:NSMakeRange(11, 2)] intValue];
        minute = [[desStr substringWithRange:NSMakeRange(14, 2)] intValue];
    }
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
	NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:[NSDate date]];
	
	[comp setDay:day];
	[comp setMonth:month];
	[comp setYear:year];
	[comp setHour:hour];
	[comp setMinute:minute];
	[comp setSecond:0];
	
	return [gregorian dateFromComponents:comp];
}

+ (NSDate*)dateFromDateString:(NSString *)dateTimeStr {
    // desStr: "2012-12-3 23:1"
    NSArray *dateTimeArr = [dateTimeStr componentsSeparatedByString:@" "];
    if (dateTimeArr.count > 1) {
        NSString *dateStr = dateTimeArr[0];
        NSArray *dateArr = [dateStr componentsSeparatedByString:@"-"];
        NSString *timeStr = dateTimeArr[1];
        NSArray *timeArr = [timeStr componentsSeparatedByString:@":"];
        if (dateArr.count > 2 && timeArr.count > 1) {
            NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
            NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:[NSDate date]];
            [comp setYear:[dateArr[0] intValue]];
            [comp setMonth:[dateArr[1] intValue]];
            [comp setDay:[dateArr[2] intValue]];
            [comp setHour:[timeArr[0] intValue]];
            [comp setMinute:[timeArr[1] intValue]];
            [comp setSecond:0];
            
            return [gregorian dateFromComponents:comp];
        }
    }
    
    return nil;
}


// ------------------
+ (NSDate*) firstOfCurrentMonth{
	
	NSDate *day = [NSDate date];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
	NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:day];
	[comp setDay:1];
	return [gregorian dateFromComponents:comp];
	
}
+ (NSDate*) lastOfCurrentMonth{
	NSDate *day = [NSDate date];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:day];
	[comp setDay:0];
	[comp setMonth:comp.month+1];
	return [gregorian dateFromComponents:comp];
}

- (NSDate*) timelessDate {
	NSDate *day = self;
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:day];
	return [gregorian dateFromComponents:comp];
}
- (NSDate*) monthlessDate {
	NSDate *day = self;
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:day];
	return [gregorian dateFromComponents:comp];
}

- (NSDate*) firstOfCurrentMonthForDate {
	NSDate *day = self;
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:day];
	[comp setDay:1];
	return [gregorian dateFromComponents:comp];
}

- (NSDate*) firstOfNextMonthForDate {
    // This method is not tested. Confirm it before use.
	NSDate *day = self;
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
	NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:day];
    NSInteger nxtMonth = (comp.month + 1);
    comp.year += nxtMonth / 12;
    comp.month = nxtMonth % 12;
    [comp setDay:1];
	return [gregorian dateFromComponents:comp];
}

- (NSInteger)dayOfWeekInMonth {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps = [gregorian components:NSWeekdayOrdinalCalendarUnit fromDate:self];
    NSInteger weekdayOrdinal = [comps weekdayOrdinal];
    
    return weekdayOrdinal;
}

- (NSString *)simpleChineseWeekdayStr {
    NSArray *weekdayStrAry = [NSArray arrayWithObjects:@"一", @"二", @"三", @"四", @"五", @"六", @"日" , nil];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSWeekdayCalendarUnit) fromDate:self];
	NSInteger weekday = [comps weekday];
	
	CFCalendarRef currentCalendar = CFCalendarCopyCurrent();
	if (YES) {
		weekday -= 1;
		if (weekday == 0) {
			weekday = 7;
		}
	}
	CFRelease(currentCalendar);
	
	return [weekdayStrAry objectAtIndex:weekday-1];
}

- (NSString *)ChineseWeekdayStr {
    NSArray *weekdayStrAry = [NSArray arrayWithObjects:
                              NSLocalizedString(@"Monday", @"周一"), 
                              NSLocalizedString(@"Tuesday", @"周二"), 
                              NSLocalizedString(@"Wednesday", @"周三"), 
                              NSLocalizedString(@"Thursday", @"周四"),
                              NSLocalizedString(@"Friday", @"周五"), 
                              NSLocalizedString(@"Saturday", @"周六"), 
                              NSLocalizedString(@"Sunday", @"周日"), 
                              nil];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSWeekdayCalendarUnit) fromDate:self];
	NSInteger weekday = [comps weekday];
	
	CFCalendarRef currentCalendar = CFCalendarCopyCurrent();
	if (YES) {
		weekday -= 1;
		if (weekday == 0) {
			weekday = 7;
		}
	}
	CFRelease(currentCalendar);
	
	return [weekdayStrAry objectAtIndex:weekday-1];
}


- (NSInteger)weekday {
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSWeekdayCalendarUnit) fromDate:self];
	NSInteger weekday = [comps weekday];
	return weekday;
}


// Calendar starting on Monday instead of Sunday (Australia, Europe against US american calendar)
- (NSInteger)weekdayWithMondayFirst {
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSWeekdayCalendarUnit) fromDate:self];
	NSInteger weekday = [comps weekday];
	
	CFCalendarRef currentCalendar = CFCalendarCopyCurrent();
	//if (CFCalendarGetFirstWeekday(currentCalendar) == 2) {
	if (YES) {
		weekday -= 1;
		if (weekday == 0) {
			weekday = 7;
		}
	}
	CFRelease(currentCalendar);
	
	return weekday;
}


- (NSInteger)differenceInDaysTo:(NSDate *)toDate{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [gregorian components:NSDayCalendarUnit
                                                fromDate:self
                                                  toDate:toDate
                                                 options:0];
    NSInteger days = [components day];
    return days;
}
- (NSInteger)differenceInMonthsTo:(NSDate *)toDate{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [gregorian components:NSMonthCalendarUnit
                                                fromDate:[self monthlessDate]
                                                  toDate:[toDate monthlessDate]
                                                 options:0];
    NSInteger months = [components month];
    return months;
}
- (NSInteger)differenceYearsFrom:(NSDate *)start{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit
                                                fromDate:start
                                                  toDate:self
                                                 options:0];
    NSInteger years = [components year];
    return years;
}
- (BOOL)isSameDay:(NSDate*)anotherDate{
	NSCalendar* calendar = [NSCalendar currentCalendar];
	NSDateComponents* components1 = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];
	NSDateComponents* components2 = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:anotherDate];
    BOOL ret =  ([components1 year] == [components2 year] && [components1 month] == [components2 month] && [components1 day] == [components2 day]);
	return ret;
} 
- (BOOL)isToday{
	return [self isSameDay:[NSDate date]];
} 


- (NSString*) dateDescription{
	return [[self description] substringToIndex:10];
	
}

- (long long)toMilliSecond {
    double timeInterval = [self timeIntervalSince1970];
    return (long long)(timeInterval * 1000.0);
}
+ (long long)timestamp;
{
    return [[NSDate date] timeIntervalSince1970];
}

+ (NSDate*)dateFromMilliSecond:(long long)milliSecond {
    NSDate *result = [[NSDate alloc] initWithTimeIntervalSince1970:milliSecond / 1000.0];
    return result ;
}

- (NSDate *)getDatePart {
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //[cal setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDateComponents *comp = [cal components:(NSYearCalendarUnit   | 
                                              NSMonthCalendarUnit  |
                                              NSDayCalendarUnit    ) fromDate:self];
    [comp setHour:0];
	[comp setMinute:0];
	[comp setSecond:0];
    //[comp setTimeZone:cal.timeZone];
    NSDate *date = [cal dateFromComponents:comp];
    return date;
}

- (NSDate*)dateWithNewTimeZone:(NSString *)timeZone {
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
    NSDateComponents *comp = [cal components:(NSYearCalendarUnit   | 
                                              NSMonthCalendarUnit  |
                                              NSDayCalendarUnit    |
                                              NSHourCalendarUnit   |
                                              NSMinuteCalendarUnit |
                                              NSSecondCalendarUnit ) fromDate:self];
    
    [comp setTimeZone:[NSTimeZone timeZoneWithName:timeZone]];
    return [cal dateFromComponents:comp];
}


- (NSDate *)firstDayOfMonth {
    return [NSDate firstMonthDayOfDate:self];
}

+ (NSDate *)firstMonthDayOfDate:(NSDate *)date {
    CFGregorianDate gDate = [date getGregorianDate];
    gDate.day = 1;
    return [NSDate dateFromCFGregorianDate:gDate];
}

- (NSDate *)lastDayOfMonth {
    return [NSDate lastMonthDayOfDate:self];
}

+ (NSDate *)lastMonthDayOfDate:(NSDate *)date {
    NSDate *nxtMonthFirstDate = [NSDate firstMonthDayOfDate:[[date firstDayOfMonth] dateByAddingTimeInterval:32 * 86400]];
    return [[nxtMonthFirstDate getDatePart] dateByAddingTimeInterval:-86400];
}

- (NSInteger)daysInMonth {
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:self];
	[comp setDay:0];
	[comp setMonth:comp.month+1];
	
	NSInteger days = [[gregorian components:NSDayCalendarUnit fromDate:[gregorian dateFromComponents:comp]] day];
	
	return days;
}

- (NSString *)yearMonthStrWithSep:(NSString *)sepStr {
    [[self sharedDateFormatter] setDateFormat:[NSString stringWithFormat:@"yyyy%@MM", sepStr]];
    return [[self sharedDateFormatter] stringFromDate:self];
}

- (CFGregorianDate)getGregorianDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comp = [gregorian components:(NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit | 
													NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit) 
										  fromDate:self];
    CFGregorianDate gDate = (CFGregorianDate){(SInt32)[comp year], (SInt8)[comp month], (SInt8)[comp day],
        (SInt8)[comp hour], (SInt8)[comp minute], [comp second]};
	
	
    return gDate;
}


+ (NSDate *)dateFromCFGregorianDate:(CFGregorianDate)info {
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
	NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:[NSDate date]];
	
	[comp setDay:info.day];
	[comp setMonth:info.month];
	[comp setYear:info.year];
	[comp setHour:info.hour];
	[comp setMinute:info.minute];
	[comp setSecond:info.second];
    
	return [gregorian dateFromComponents:comp];
}

+ (NSDate*) GMTDateFromCFGregorianDate:(CFGregorianDate)info {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
    [gregorian setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:[NSDate date]];
	
	[comp setDay:info.day];
	[comp setMonth:info.month];
	[comp setYear:info.year];
	[comp setHour:info.hour];
	[comp setMinute:info.minute];
	[comp setSecond:info.second];
	
	return [gregorian dateFromComponents:comp];
}



- (int)firstDayWeekDayOfCurrentMonth {
	CFTimeZoneRef tz = CFTimeZoneCopyDefault();
	CFGregorianDate gDate = [self getGregorianDate];
	gDate.day = 1;
	gDate.hour = 0;
	gDate.minute = 0;
	gDate.second = 1;
    int monthWeekday = (int)CFAbsoluteTimeGetDayOfWeek(CFGregorianDateGetAbsoluteTime(gDate,tz),tz);
    CFRelease(tz);
	return monthWeekday;
}



//判断两个时间是不是同一天
- (BOOL)isSameDay2:(long long)date;
{
    NSDate *dt = [NSDate dateWithTimeIntervalSince1970:date];
    return  [self isSameDay:dt];
}

//截至到现在的时间。
+(NSString*)getTimeStampFromReceiveTime:(long long)receiveTime{
    if (!receiveTime) {
        return @"刚刚";
    }
    
    NSDate *timeDate = [[NSDate alloc] initWithTimeIntervalSince1970:receiveTime];
    NSTimeInterval time=[[NSDate date] timeIntervalSinceDate:timeDate];
    NSString *logoutTimeStr = @"";

    long temp = 0;
    if (time < 60) {
        logoutTimeStr = @"刚刚";
    } else if ((temp=time/60) < 60) {
        logoutTimeStr=[NSString stringWithFormat:@"%ld分钟前",temp];
    } else if((temp = temp/60) <24){
        logoutTimeStr = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if((temp = temp/24) <30){
        logoutTimeStr = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        logoutTimeStr = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        logoutTimeStr = [NSString stringWithFormat:@"%ld年前",temp];
    }
    return logoutTimeStr;
}
@end
