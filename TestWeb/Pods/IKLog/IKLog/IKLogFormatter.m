//
//  IKLogFormatter.m
//  IKLog
//
//  Created by zhang fan on 14-10-16.
//
//

#import "IKLogFormatter.h"

@implementation IKLogFormatter
{
	NSDateFormatter* _formatter;
}

- (NSString*)formatLogMessage:(DDLogMessage *)logMessage
{
	if (!_formatter)
	{
		_formatter = [[NSDateFormatter alloc] init];
		[_formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
		[_formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss.SSS"];
	}

	NSString *dateAndTime = [_formatter stringFromDate:(logMessage.timestamp)];
    
    NSString *logLevel = nil;
    switch (logMessage.flag) {
        case DDLogFlagError     : logLevel = @"E"; break;
        case DDLogFlagWarning   : logLevel = @"W"; break;
        case DDLogFlagInfo      : logLevel = @"I"; break;
        case DDLogFlagDebug     : logLevel = @"D"; break;
		case DDLogFlagVerbose   : logLevel = @"V"; break;
        default                 : logLevel = @"?"; break;
    }
    
    logLevel = [NSString stringWithFormat:@"[%@]", logLevel];
    
    NSString *formattedLog = [NSString stringWithFormat:@"%@\t %@\t %d:%lu\t %@\t %@\t %@(%lu)",
                              dateAndTime,
                              logLevel,
                              [[NSProcessInfo processInfo] processIdentifier],
                              logMessage.threadSequenceNumber,
                              logMessage.message,
                              logMessage.function,
                              logMessage.file.lastPathComponent,
                              (unsigned long)logMessage.line];
    
    return formattedLog;
}

@end

@implementation IKLogDebugFormatter
{
    NSDateFormatter* _formatter;
}

- (NSString*)formatLogMessage:(DDLogMessage *)logMessage
{
    if (!_formatter)
    {
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [_formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss.SSS"];
    }
    
    NSString *dateAndTime = [_formatter stringFromDate:(logMessage.timestamp)];
    
    NSString *logLevel = nil;
    switch (logMessage.flag) {
        case DDLogFlagError     : logLevel = @"E"; break;
        case DDLogFlagWarning   : logLevel = @"W"; break;
        case DDLogFlagInfo      : logLevel = @"I"; break;
        case DDLogFlagDebug     : logLevel = @"D"; break;
        case DDLogFlagVerbose   : logLevel = @"V"; break;
        default                 : logLevel = @"?"; break;
    }
    
    logLevel = [NSString stringWithFormat:@"[%@]", logLevel];
    
    NSString *formattedLog = [NSString stringWithFormat:@"⏰%@ %@ %d:%lu 📜 %@(%lu) 🚕 %@ 🖍 %@",
                              dateAndTime,
                              logLevel,
                              [[NSProcessInfo processInfo] processIdentifier],
                              logMessage.threadSequenceNumber,
                              logMessage.file.lastPathComponent,
                              (unsigned long)logMessage.line,
                              logMessage.function,
                              logMessage.message];
    
    return formattedLog;
}

@end
