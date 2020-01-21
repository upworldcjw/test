//
//  NotificationTool.h
//  inke
//
//  Created by Chenxiaocheng on 15/8/27.
//  Copyright (c) 2015年 MeeLive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IKNotificationTool : NSObject

+ (void)showNotification:(NSString *)content playload:(NSString *)payloadMsg __attribute__ ((deprecated("showNotification:playload:application:")));
+ (void)showNotification:(NSString *)content playload:(NSString *)payloadMsg application:(UIApplication *)application;

@end
