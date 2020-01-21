//
//  IKLog.m
//  IKLog
//
//  Created by zhang fan on 14-10-16.
//
//

#import "DDTTYLogger.h"
#import "DDFileLogger.h"
#import "DDASLLogger.h"
#import <SSZipArchive/SSZipArchive.h>
#import "IKLog.h"
#import "IKLogFormatter.h"
#import "IKLogEncryptFormatter.h"
#import "IKErrorCheck.h"
#import "IKFilterLogger.h"

#ifdef DEBUG
const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
const DDLogLevel ddLogLevel = DDLogLevelInfo;
#endif

#define kSeconds1Day        (60 * 60 * 24)
#define kMegaByte           (1024 * 1024 * 1)

@interface IKLogger()
{
    DDFileLogger*   _fileLogger;
    IKFilterLogger* _filterLogger;
}

@end

//--------------------------------------------------------------------------------------------------------------------------------------------------------------

@implementation IKLogger

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static IKLogger* instance;
    dispatch_once(&onceToken, ^
    {
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

- (NSString*)logsDirectory
{
    return [_fileLogger.logFileManager logsDirectory];
}

- (void)start
{
#ifdef DEBUG
    [[DDTTYLogger sharedInstance] setLogFormatter:[IKLogDebugFormatter new]];
    [DDTTYLogger sharedInstance].colorsEnabled = YES;
    
    [DDLog addLogger:[DDTTYLogger sharedInstance] withLevel:ddLogLevel];
#endif
	
    _fileLogger = [[DDFileLogger alloc] init];
    [_fileLogger setLogFormatter:[[IKLogEncryptFormatter alloc] initWithEncryptKey:@"xiebaogua"]];
    [_fileLogger setRollingFrequency: kSeconds1Day];
    [_fileLogger setMaximumFileSize: 10 * kMegaByte];
    [_fileLogger.logFileManager setMaximumNumberOfLogFiles:7];
    [DDLog addLogger:_fileLogger withLevel:ddLogLevel];
    
    _filterLogger = [IKFilterLogger new];
    [_filterLogger setLogFormatter:[IKLogFormatter new]];
    [DDLog addLogger:_filterLogger withLevel:ddLogLevel];
}

- (void)stop
{
    [DDLog removeAllLoggers];
}

- (NSString*)zipLogFiles
{
    {
        [DDLog flushLog];
        
        // create temp folder
        NSString* tempLogFolder = [NSTemporaryDirectory() stringByAppendingPathComponent:[self _UUID]];
        [[NSFileManager defaultManager] createDirectoryAtPath:tempLogFolder withIntermediateDirectories:NO attributes:nil error:nil];
        IKErrorCheck([[NSFileManager defaultManager] fileExistsAtPath:tempLogFolder isDirectory:nil]);
        
        // copy ddlog files
        NSString* ddLogFolder = [_fileLogger.logFileManager logsDirectory];
        NSArray* ddLogFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:ddLogFolder error:nil];
        for (NSString* logFile in ddLogFiles)
        {
            NSString* logFilePath = [ddLogFolder stringByAppendingPathComponent:logFile];
            BOOL isDir;
            [[NSFileManager defaultManager] fileExistsAtPath:logFilePath isDirectory:&isDir];
            if (!isDir)
            {
                NSString* destPath = [tempLogFolder stringByAppendingPathComponent:logFilePath.lastPathComponent];
                [[NSFileManager defaultManager] copyItemAtPath:logFilePath toPath:destPath error:nil];
            }
        }
        
        // copy media sdk log files
        NSString* mediaSdkLogFolder = NSTemporaryDirectory();
        NSArray* mediaSdkLogFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:mediaSdkLogFolder error:nil];
        for (NSString* logFile in mediaSdkLogFiles)
        {
            NSString* logFilePath = [mediaSdkLogFolder stringByAppendingPathComponent:logFile];
            BOOL isDir;
            [[NSFileManager defaultManager] fileExistsAtPath:logFilePath isDirectory:&isDir];
            if (!isDir)
            {
                if ([logFilePath.pathExtension.lowercaseString isEqualToString:@"txt"])
                {
                    NSString* destPath = [tempLogFolder stringByAppendingPathComponent:logFilePath.lastPathComponent];
                    [[NSFileManager defaultManager] copyItemAtPath:logFilePath toPath:destPath error:nil];
                }
            }
        }
        
        // zip log files
        NSString* tempZip = [[NSTemporaryDirectory() stringByAppendingPathComponent:[self _UUID]] stringByAppendingPathExtension:@"zip"];
        BOOL ret = [SSZipArchive createZipFileAtPath:tempZip withContentsOfDirectory:tempLogFolder];
        IKErrorCheck(ret);
        
        // cleanup
        [[NSFileManager defaultManager] removeItemAtPath:tempLogFolder error:nil];
        
        return tempZip;
    }
    
IKExit:
    return nil;
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------

- (NSString*)_UUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString*)string;
}

@end

@implementation IKLogTraceStack
{
	const char* _file;
	const char* _function;
	int         _line;
}

- (instancetype)initWithFile: (const char*)file Function: (const char*)func Line: (int)line
{
	self = [super init];
	
    if (self) {
        _file     = file;
        _line     = line;
        _function = func;
        
        [DDLog log:YES level:DDLogLevelInfo flag:DDLogFlagInfo context:0 file:_file function:_function line:_line tag:nil format:@"[IN]", nil];
    }
	
	return self;
}

- (void)nothing
{
    
}

- (void)dealloc
{
	[DDLog log:YES level:DDLogLevelInfo flag:DDLogFlagInfo context:0 file:_file function:_function line:_line tag:nil format:@"[OUT]", nil];
}

@end
