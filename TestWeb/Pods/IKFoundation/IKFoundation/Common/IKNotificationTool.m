//
//  NotificationTool.m
//  inke
//
//  Created by Chenxiaocheng on 15/8/27.
//  Copyright (c) 2015年 MeeLive. All rights reserved.
//

#import "IKNotificationTool.h"

static NSString *LOCAL_NOTIFY_SCHEDULE_ID = @"";

@implementation IKNotificationTool

+ (void)showNotification:(NSString *)content playload:(NSString *)payloadMsg {
    
}

+ (void)showNotification:(NSString *)content playload:(NSString *)payloadMsg application:(UIApplication *)application {
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    if (localNotification == nil) {
        return;
    }
    // 设置本地通知的触发时间（如果要立即触发，无需设置），这里设置为20妙后
    // localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:20];
    // 设置本地通知的时区
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置通知的内容
    localNotification.alertBody = content;
    // 设置通知动作按钮的标题
    localNotification.alertAction = NSLocalizedString(@"COMMON_inke", nil);
    // 设置提醒的声音，可以自己添加声音文件，这里设置为默认提示声
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    
    // 设置通知的相关信息，这个很重要，可以添加一些标记性内容，方便以后区分和获取通知的信息
    // NSDictionary *infoDic = @{ @"payload" : payloadMsg };
    //
    // localNotification.userInfo = infoDic;
    
    // //在规定的日期触发通知
    // [[UIApplication sharedApplication]
    //      scheduleLocalNotification:localNotification];
    
    // 立即触发一个通知
    if (application) {
        [application presentLocalNotificationNow:localNotification];
    }
}

@end
