//
//  NetworkTool.m
//  IKFoundation
//
//  Created by Chenxiaocheng on 16/8/1.
//  Copyright © 2016年 inke. All rights reserved.
//

#import "IKWifiSSID.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation IKWifiSSID

+ (id)fetchSSIDInfo
{
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSLog(@"Supported interfaces: %@", ifs);
    id info = nil;
    
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        NSLog(@"%@ => %@", ifnam, info);
        if (info && [info count]) { break; }
    }
    
    return info;
}

@end
