//
//  IKLogMacros.h
//  IKLogDemo
//
//  Created by fanzhang on 2016/12/28.
//  Copyright © 2016年 meelive. All rights reserved.
//

#ifndef IKLogMacros_h
#define IKLogMacros_h

#import "CocoaLumberjack.h"

#define IKLogE(frmt, ...)   LOG_MAYBE(NO,                LOG_LEVEL_DEF, DDLogFlagError,   0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
#define IKLogW(frmt, ...)   LOG_MAYBE(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagWarning, 0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
#define IKLogI(frmt, ...)   LOG_MAYBE(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagInfo,    0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
#define IKLogD(frmt, ...)   LOG_MAYBE(NO, LOG_LEVEL_DEF, DDLogFlagDebug,   0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__); [DDLog flushLog];
#define IKLogV(frmt, ...)   LOG_MAYBE(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagVerbose, 0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)

#define IKLog IKLogD

#endif /* IKLogMacros_h */
