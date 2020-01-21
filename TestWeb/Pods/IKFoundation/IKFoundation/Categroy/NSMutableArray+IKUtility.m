//
//  NSMutableArray+IKUtility.m
//  IKFoundation
//
//  Created by fanzhang on 2016/12/1.
//  Copyright © 2016年 inke. All rights reserved.
//

#import "NSMutableArray+IKUtility.h"

@implementation NSMutableArray (IKUtility)

- (id) ik_head
{
	if (![self count])
		return nil;
	
	return [self objectAtIndex:0];
}

- (id) ik_dequeue
{
    if (![self count])
		return nil;
	
    id headObject = [self objectAtIndex:0];
        [self removeObjectAtIndex:0];
	
    return headObject;
}

- (void) ik_enqueue:(id)anObject
{
    [self addObject:anObject];
}

- (id)ik_pop
{
    if (![self count])
        return nil;
    
    id lastObject = [self lastObject];
    [self removeLastObject];
    
    return lastObject;
}

- (void)ik_push:(id)obj
{
    [self addObject: obj];
}

#pragma mark -

- (id)objectAtIndexCheck:(NSUInteger)index
{
    if (index >= [self count]) {
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}

@end
