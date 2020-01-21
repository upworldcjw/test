//
//  IKWeakTimer.h
//  IKFoundation
//
//  Created by Chenxiaocheng on 16/8/8.
//  Copyright © 2016年 inke. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^IKTimerHandler)(id userInfo);

@interface IKWeakTimer : NSObject


+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                     target:(id)aTarget
                                   selector:(SEL)aSelector
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats;

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      block:(IKTimerHandler)block
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats;

@end
