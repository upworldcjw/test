//
//  Teacher.m
//  TestStaticLib
//
//  Created by jianwei on 10/19/16.
//  Copyright © 2016 jianwei. All rights reserved.
//

#import "Teacher.h"

@implementation Teacher
- (instancetype)init{
    if (self = [super init]) {
        NSLog(@"inner Teacher");
    }
    return self;
}
@end
