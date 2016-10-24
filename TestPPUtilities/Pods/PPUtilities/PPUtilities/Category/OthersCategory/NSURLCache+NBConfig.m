//
//  NSURLCache+NBConfig.m
//  pengpeng
//
//  Created by 巩鹏军 on 14/12/1.
//  Copyright (c) 2014年 AsiaInnovations. All rights reserved.
//

#import "NSURLCache+NBConfig.h"

@implementation NSURLCache (NBConfig)

// Config and clean URLCache correctly
// http://stackoverflow.com/questions/22945198/crash-on-mmapfiledeallocate
// http://stackoverflow.com/questions/9968050/how-to-disable-afnetworking-cache/17063060#17063060
// http://twobitlabs.com/2012/01/ios-ipad-iphone-nsurlcache-uiwebview-memory-utilization/

+ (void)configURLCache
{
    NSUInteger cacheSizeMemory =  4*1024*1024; //  4MB
    NSUInteger cacheSizeDisk   = 32*1024*1024; // 32MB
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory
                                                            diskCapacity:cacheSizeDisk
                                                                diskPath:@"nsurlcache"];
    [NSURLCache setSharedURLCache:sharedCache];
}

+ (void)cleanURLCache
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
