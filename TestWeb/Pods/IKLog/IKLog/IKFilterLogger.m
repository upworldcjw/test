//
//  IKFilterLogger.m
//  IKLogDemo
//
//  Created by fanzhang on 2016/12/30.
//  Copyright © 2016年 meelive. All rights reserved.
//

#import "IKFilterLogger.h"

@interface IKFilterLogger()
{
    NSMutableArray* _filters;
}
@end;

@implementation IKFilterLogger

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _filters = [NSMutableArray new];
    }
    
    return self;
}

- (void)addFilter:(id<IKLogFilterDelegate>)filter
{
    @synchronized (self)
    {
        [_filters addObject:filter];
    }
}

- (void)removeFilter:(id<IKLogFilterDelegate>)filter
{
    @synchronized (self)
    {
        [_filters removeObject:filter];
    }
}

- (void)logMessage:(DDLogMessage *)logMessage;
{
    NSString * message = _logFormatter ? [_logFormatter formatLogMessage:logMessage] : logMessage->_message;
    if (message.length)
    {
        @synchronized (self)
        {
            for (id<IKLogFilterDelegate> filter in _filters)
            {
                if ([filter respondsToSelector:@selector(onLogMessage:)])
                    [filter onLogMessage:message];
            }
        }
    }
}

@end
