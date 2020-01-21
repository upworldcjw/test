//
//  IKAudioTool.h
//  IKFoundation
//
//  Created by Chenxiaocheng on 16/7/20.
//  Copyright © 2016年 inke. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  音频相关工具类
 */
@interface IKAudioTool : NSObject

+ (void)checkAndOpenAudio;

/**
 *  是否插入耳麦
 *
 *  @return YES:插入耳麦 NO:外放
 */
+ (BOOL)isHeadphonePluggedIn;

@end
