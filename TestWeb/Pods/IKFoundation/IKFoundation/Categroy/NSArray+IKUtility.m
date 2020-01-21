//
//  NSArray+IKUtility.m
//  IKFoundation
//
//  Created by 马汝军 on 2017/6/2.
//  Copyright © 2017年 inke. All rights reserved.
//

#import "NSArray+IKUtility.h"

@implementation NSArray (IKUtility)

- (id)ik_objectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self objectAtIndex:index];
    }
    
    return nil;
}

@end

@implementation NSMutableArray (IKUtility)

- (void)ik_removeObjectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        [self removeObjectAtIndex:index];
    }
}

@end
