//
//  NSDate+Category.m
//  cal365
//
//  Created by jianwei.chen
//

#import "NSDate+IM.h"

static int OneDaySecond = 24 * 3600;

#define OneDaySeconds OneDaySecond
@implementation NSDate (ChatList)
//1). 聊天对话页面
//若系统设置为12小时制：凌晨 0：00～05：00  上午：05：00～12：00  下午：12：00～24：00
//a. 一天内的消息，显示时间为 凌晨/上午/下午 XX:XX    eg：上午 10：08     下午 11：22
//b. 前一天的消息，显示为 昨天 凌晨/上午/下午 XX:XX     eg：昨天 上午 11：08
//c. 7天内的消息，显示为  星期N 凌晨/上午/下午 XX:XX   eg：星期二 上午 11：12
//d. 7天前的消息，显示为 2015-07-12 凌晨/上午/下午 XX:XX   eg：2015-07-12 上午/下午 XX:XX
//如果是24小时制，则不用显示 凌晨/上午/下午，直接显示时间。

static inline NSString * prefixForHour(NSInteger hour){
    if (hour < 5) {
        return @"凌晨";//[00:00,05:00)
    }else if(hour < 12){//[05:00,12:00)
        return @"上午";
    }else{
        return @"下午";//[12:00,23:59)
    }
};

+(NSString*)getChatListTimeStampFromReceiveTime:(long long)receiveTime{//receiveTime 距离1970年的秒数
    BOOL is24HoursSetting = [NSDate isDaySetting24Hours];
    if (receiveTime < 0) {
        return @"刚刚";
    }
    if (receiveTime == 0) {
        return @"刚刚";
    }
    NSDate *timeDate = [[NSDate alloc] initWithTimeIntervalSince1970:receiveTime];
    NSDate *currentDate = [NSDate date];
    NSTimeInterval second =[currentDate timeIntervalSinceDate:timeDate];
//    NSLog(@"%d",second);
    DateInformation currentDateInfo = [currentDate dateInformation];
    DateInformation dateInfo = [timeDate dateInformation];
    NSMutableArray *mutArr = [[NSMutableArray alloc] initWithCapacity:3];
    
    NSString *prefix = nil;
    if (!is24HoursSetting) {//12小时制
        prefix = prefixForHour(dateInfo.hour);
    }
    NSString *dateDuration = nil;
    NSInteger oneDayTimeLeft = currentDateInfo.hour * 60 * 60 + currentDateInfo.minute*60 + currentDateInfo.second;
    
    if(second > 0){
        if (second < oneDayTimeLeft) {//当天的
            
        }else if(second < OneDaySecond + oneDayTimeLeft){
            dateDuration = @"昨天";
        }else if (second < 6*OneDaySecond + oneDayTimeLeft){
            dateDuration = [timeDate ChineseWeekdayStr];
        }else{
            //相对[timeDate fullStyleDate]，高效
            dateDuration = [NSString stringWithFormat:@"%04d-%02d-%02d",dateInfo.year,dateInfo.month,dateInfo.day];;
        }
    }else{
        second = - second;
        oneDayTimeLeft = OneDaySecond - oneDayTimeLeft;
        if(second < oneDayTimeLeft){//当天
            
        }else if (second < oneDayTimeLeft + 6 * OneDaySecond) {
            dateDuration = [timeDate ChineseWeekdayStr];
        }else{
            dateDuration = [NSString stringWithFormat:@"%04d-%02d-%02d",dateInfo.year,dateInfo.month,dateInfo.day];;
        }
    }

    if (dateDuration) {
        [mutArr addObject:dateDuration];
    }
    if (prefix) {
        [mutArr addObject:prefix];
    }
    
    NSString *hhMMStr = [NSString stringWithFormat:@"%02d:%02d",dateInfo.hour,dateInfo.minute];
    [mutArr addObject:hhMMStr];
    return [mutArr componentsJoinedByString:@" "];
}
@end


@implementation NSDate (MessageList)
//2) 消息列表页面
//a. 一天内的最近一条消息发送时间，12小时制： 凌晨/上午/下午 XX:XX     24小时制：XX:XX
//b. 前一天的最近一条消息，显示为：昨天
//c. 7天内的消息，显示为：星期几
//d. 7天前到当年的消息，显示为：07-12
//e. 前一年的消息：2014-12-25

static inline NSString * currentDayTime(DateInformation dateInfo){
    //当天的
    NSString *dateDuration = nil;
    BOOL is24HoursSetting = [NSDate isDaySetting24Hours];
    NSString *prefix = nil;
    if (!is24HoursSetting) {//12小时制
        prefix = prefixForHour(dateInfo.hour);
    }
    NSString *hhMMStr = [NSString stringWithFormat:@"%02d:%02d",dateInfo.hour,dateInfo.minute];
    if (prefix) {
        dateDuration = [prefix stringByAppendingFormat:@" %@",hhMMStr];
    }else{
        dateDuration = hhMMStr;
    }
    return dateDuration;
}

+(NSString*)getMessageListTimeStampFromReceiveTime:(long long)receiveTime{
//    BOOL is24HoursSetting = [self isDaySetting24Hours]
    if (receiveTime < 0) {
        return @"刚刚";
    }
    if (receiveTime == 0) {
        return @"刚刚";
    }
    
    NSDate *timeDate = [[NSDate alloc] initWithTimeIntervalSince1970:receiveTime];
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval second =[currentDate timeIntervalSinceDate:timeDate];
//    NSLog(@"%d",second);
    DateInformation currentDateInfo = [currentDate dateInformation];
    DateInformation dateInfo = [timeDate dateInformation];
    
    NSInteger oneDayTimeLeft = currentDateInfo.hour * 60 * 60 + currentDateInfo.minute*60 + currentDateInfo.second;
    
    NSString *dateDuration = nil;
    if (second > 0) {
        if (second > 6*OneDaySecond + oneDayTimeLeft) {
            if(currentDateInfo.year == dateInfo.year){//同一年
                dateDuration = [NSString stringWithFormat:@"%02d-%02d",dateInfo.month,dateInfo.day];
            }else{
                dateDuration = [NSString stringWithFormat:@"%04d-%02d-%02d",dateInfo.year,dateInfo.month,dateInfo.day];
            }
        }else{//6天内的
            if (second < oneDayTimeLeft){
                //当天的
                dateDuration = currentDayTime(dateInfo);
            }else if(second < OneDaySecond + oneDayTimeLeft){
                dateDuration = @"昨天";
            }else{
                dateDuration = [timeDate ChineseWeekdayStr];
            }
        }
    }else{//超前手机时间
        second = - second;
        oneDayTimeLeft = OneDaySecond - oneDayTimeLeft;
        if(second < oneDayTimeLeft){//当天
            //当天的
            dateDuration = currentDayTime(dateInfo);
        }else if (second < oneDayTimeLeft + 6 * OneDaySecond) {//6天内的
            dateDuration = [timeDate ChineseWeekdayStr];
        }else{
            dateDuration = [NSString stringWithFormat:@"%04d-%02d-%02d",dateInfo.year,dateInfo.month,dateInfo.day];;
        }
    }
    return dateDuration;
}

@end



#ifdef Debug
@implementation NSDate(Debug)
-(void)logDate:(NSDate *)date{
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    NSString *dateStr = [NSDate getMessageListTimeStampFromReceiveTime:timeInterval];
    NSLog(@"%@",dateStr);
}

-(void)test{
    NSDate *date = [NSDate date];
    
    NSDate *date1 = [NSDate dateWithTimeInterval:-5 sinceDate:date];//5秒前
    [self logDate:date1];
    
    NSDate *date3 = [NSDate dateWithTimeInterval:-OneDaySecond -5 sinceDate:date];
    [self logDate:date3];
    
    NSDate *date5 = [NSDate dateWithTimeInterval:-2*OneDaySecond -5 sinceDate:date];
    [self logDate:date5];
    
    NSDate *date7 = [NSDate dateWithTimeInterval:-7*OneDaySecond - 5 sinceDate:date];
    [self logDate:date7];
    
    NSDate *date8 = [NSDate dateWithTimeInterval:-365 * OneDaySecond sinceDate:date];
    [self logDate:date8];
}
@end
#endif


