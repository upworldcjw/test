//
//  NSArray+IKUtility.h
//  IKFoundation
//
//  Created by 马汝军 on 2017/6/2.
//  Copyright © 2017年 inke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (IKUtility)

- (id)ik_objectAtIndex:(NSUInteger)index;

@end


@interface NSMutableArray (IKUtility)

- (void)ik_removeObjectAtIndex:(NSUInteger)index;

@end
