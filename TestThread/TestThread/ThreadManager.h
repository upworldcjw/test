//
//  ThreadManager.h
//  TestThread
//
//  Created by JianweiChen on 2018/8/23.
//  Copyright © 2018 inke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThreadManager : NSObject

+ (instancetype)shareInstance;

- (void)asynBlock:(dispatch_block_t)block;

@end
