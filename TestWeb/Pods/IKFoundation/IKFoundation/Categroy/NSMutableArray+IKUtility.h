//
//  NSMutableArray+IKUtility.h
//  IKFoundation
//
//  Created by fanzhang on 2016/12/1.
//  Copyright © 2016年 inke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (IKUtility)

// queue
- (id) ik_head;
- (id) ik_dequeue;
- (void) ik_enqueue:(id)obj;

// stack
- (id)ik_pop;
- (void)ik_push:(id)obj;

/*!
 @method objectAtIndexCheck:
 @abstract 检查是否越界和NSNull如果是返回nil
 @result 返回对象
 */
- (id)objectAtIndexCheck:(NSUInteger)index;

@end
