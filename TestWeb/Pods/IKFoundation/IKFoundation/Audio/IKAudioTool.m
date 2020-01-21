//
//  IKAudioTool.m
//  IKFoundation
//
//  Created by Chenxiaocheng on 16/7/20.
//  Copyright © 2016年 inke. All rights reserved.
//

#import "IKAudioTool.h"
#import <AVFoundation/AVFoundation.h>

@implementation IKAudioTool

+ (void)checkAndOpenAudio {
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        if (!granted) {
        } else {
        }
    }];
}

+ (BOOL)isHeadphonePluggedIn {
    AVAudioSessionRouteDescription *route =
    [[AVAudioSession sharedInstance] currentRoute];
    for (AVAudioSessionPortDescription *desc in [route outputs]) {
        NSString* portTypeValue = [desc portType];
        if ([portTypeValue isEqualToString:AVAudioSessionPortHeadphones]
            || [portTypeValue isEqualToString:AVAudioSessionPortBluetoothA2DP]
            || [portTypeValue isEqualToString:AVAudioSessionPortBluetoothLE]
            || [portTypeValue isEqualToString:AVAudioSessionPortBluetoothHFP]) {
            return YES;
        }
    }
    
    return NO;
}

@end
