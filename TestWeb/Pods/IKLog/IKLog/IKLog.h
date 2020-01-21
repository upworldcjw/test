//
//  IKLog.h
//  IKLog
//
//  Created by zhang fan on 14-10-16.
//
//

#import <Foundation/Foundation.h>
#import "CocoaLumberjack.h"
#import "IKLogMacros.h"
#import "IKErrorCheck.h"
#import "IKFilterLogger.h"

//--------------------------------------------------------------------------------------------------------------------------------------------------------------

extern const DDLogLevel ddLogLevel;

@interface IKLogger : NSObject

@property(nonatomic, readonly) IKFilterLogger* filterLogger;
@property(nonatomic, readonly) NSString* logsDirectory;

+ (instancetype)sharedInstance;
- (instancetype)init NS_UNAVAILABLE;

- (void)start;
- (void)stop;
- (NSString*)zipLogFiles;

@end

//--------------------------------------------------------------------------------------------------------------------------------------------------------------

@interface IKLogTraceStack : NSObject

- (instancetype)initWithFile: (const char*)file Function: (const char*)func Line: (int)line;
- (void)nothing;

@end

//--------------------------------------------------------------------------------------------------------------------------------------------------------------

#define IKTraceStack \
IKLogTraceStack* __IKTraceStack__; \
if(ddLogLevel != DDLogLevelOff){\
    __IKTraceStack__ = [[IKLogTraceStack alloc] initWithFile:__FILE__ Function:__PRETTY_FUNCTION__ Line:__LINE__];\
    [__IKTraceStack__ nothing];\
}\

//--------------------------------------------------------------------------------------------------------------------------------------------------------------
