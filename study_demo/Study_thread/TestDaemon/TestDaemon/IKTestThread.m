//
//  IKTestThread.m
//  inke
//
//  Created by JianweiChen on 2020/2/16.
//  Copyright © 2020 MeeLive. All rights reserved.
//

#import "IKTestThread.h"

@implementation IKTestThread

static NSThread *cfstreamThread2;
static NSInteger cfstreamThreadRetainCount2 ;
static dispatch_queue_t cfstreamThreadSetupQueue2;

+ (void)test {
    [IKTestThread startCFStreamThreadIfNeeded];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [IKTestThread stopCFStreamThreadIfNeeded];
    });
}

+ (void)ignore:(id)_
{}

+ (void)startCFStreamThreadIfNeeded
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        cfstreamThreadRetainCount2 = 0;
        cfstreamThreadSetupQueue2 = dispatch_queue_create("GCDAsyncSocket-CFStreamThreadSetup", DISPATCH_QUEUE_SERIAL);
    });
    
    dispatch_sync(cfstreamThreadSetupQueue2, ^{ @autoreleasepool {
        
        if (++cfstreamThreadRetainCount2 == 1)
        {
            cfstreamThread2 = [[NSThread alloc] initWithTarget:self
                                                     selector:@selector(cfstreamThread)
                                                       object:nil];
            [cfstreamThread2 start];
        }
    }});
}

+ (void)stopCFStreamThreadIfNeeded
{
    
    // The creation of the cfstreamThread is relatively expensive.
    // So we'd like to keep it available for recycling.
    // However, there's a tradeoff here, because it shouldn't remain alive forever.
    // So what we're going to do is use a little delay before taking it down.
    // This way it can be reused properly in situations where multiple sockets are continually in flux.
    
    int delayInSeconds = 30;
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(when, cfstreamThreadSetupQueue2, ^{ @autoreleasepool {
    #pragma clang diagnostic push
    #pragma clang diagnostic warning "-Wimplicit-retain-self"
        
        if (cfstreamThreadRetainCount2 == 0)
        {
//            LogWarn(@"Logic error concerning cfstreamThread start / stop");
//            return_from_block;
        }
        
        if (--cfstreamThreadRetainCount2 == 0)
        {
            [cfstreamThread2 cancel]; // set isCancelled flag
            
            // wake up the thread
            [[self class] performSelector:@selector(ignore:)
                                 onThread:cfstreamThread2
                               withObject:[NSNull null]
                            waitUntilDone:NO];
            
            cfstreamThread2 = nil;
        }
        
    #pragma clang diagnostic pop
    }});
}

+ (void)cfstreamThread { @autoreleasepool
{
    [[NSThread currentThread] setName:@"IKTestThread"];
    
//    LogInfo(@"CFStreamThread: Started");
    
    // We can't run the run loop unless it has an associated input source or a timer.
    // So we'll just create a timer that will never fire - unless the server runs for decades.
    [NSTimer scheduledTimerWithTimeInterval:[[NSDate distantFuture] timeIntervalSinceNow]
                                     target:self
                                   selector:@selector(ignore:)
                                   userInfo:nil
                                    repeats:YES];
    
    NSThread *currentThread = [NSThread currentThread];
    NSRunLoop *currentRunLoop = [NSRunLoop currentRunLoop];
    
    BOOL isCancelled = [currentThread isCancelled];
    
    while (!isCancelled && [currentRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]])
    {
        isCancelled = [currentThread isCancelled];
    }
    
    NSLog(@"CFStreamThread: Stopped");
}}


@end

