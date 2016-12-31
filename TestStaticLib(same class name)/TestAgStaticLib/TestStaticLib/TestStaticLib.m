//
//  TestStaticLib.m
//  TestStaticLib
//
//  Created by jianwei on 10/19/16.
//  Copyright © 2016 jianwei. All rights reserved.
//

#import "TestStaticLib.h"
#import "Person.h"
#import "Teacher.h"
@implementation Person

- (void)printPerson{
    NSLog(@"printPerson");
}

@end

@implementation TestStaticLib
- (instancetype)init{
    if (self = [super init]) {
        [[Teacher alloc] init];
    }
    return self;
}
@end
