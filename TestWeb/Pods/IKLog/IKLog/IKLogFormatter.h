//
//  IKLogFormatter.h
//  IKLog
//
//  Created by zhang fan on 14-10-16.
//
//

#import <Foundation/Foundation.h>
#import "DDDispatchQueueLogFormatter.h"

@interface IKLogFormatter : DDDispatchQueueLogFormatter<DDLogFormatter>

@end

@interface IKLogDebugFormatter : DDDispatchQueueLogFormatter<DDLogFormatter>

@end
