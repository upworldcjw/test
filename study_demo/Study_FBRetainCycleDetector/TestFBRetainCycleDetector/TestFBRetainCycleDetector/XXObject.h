//
//  XXObject.h
//  TestFBRetainCycleDetector
//
//  Created by JianweiChen on 2020/3/12.
//  Copyright © 2020 inke. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XXObject : NSObject

@property (nonatomic, assign) int intA;
@property (nonatomic, assign) char charB;
@property (nonatomic, strong) id first;
@property (nonatomic, weak)   id second;

@property (nonatomic, assign) struct TestStruct{
    char charC;
    NSString *structStr;
    NSInteger *structInt;
} testStruct;

@property (nonatomic, strong) id third;
@property (nonatomic, assign) char charC;
@property (nonatomic, strong) id forth;
@property (nonatomic, weak)   id fifth;
@property (nonatomic, strong) id sixth;

@end

NS_ASSUME_NONNULL_END
