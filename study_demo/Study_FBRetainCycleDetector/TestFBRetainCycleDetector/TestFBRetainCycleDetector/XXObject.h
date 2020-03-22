//
//  XXObject.h
//  TestFBRetainCycleDetector
//
//  Created by JianweiChen on 2020/3/12.
//  Copyright © 2020 inke. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

struct Struct1 {
    int a;              //4 + 4
    double b;           //8
    int c;              // 4
    char d;             //1
    short e;            //2
};

struct Struct2 {
    int a;                  //4 + 4
    double b;               //8
    char d;                 //1 + 3
    int c;                  //4
    short e;                //2
                            //补+6 //8的倍数
};

@interface XXObject : NSObject

@property (nonatomic, assign) int intA;
@property (nonatomic, assign) char charB;
@property (nonatomic, strong) id first;
@property (nonatomic, weak)   id second;
@property (nonatomic, assign) struct Struct2 test1;

//@property (nonatomic, assign) struct TestStruct{
//    char charC;
//    NSString *structStr;
//    NSInteger *structInt;
//} testStruct;

@property (nonatomic, strong) id third;
@property (nonatomic, assign) char charC;
@property (nonatomic, strong) id forth;
@property (nonatomic, weak)   id fifth;
@property (nonatomic, strong) id sixth;

@end

NS_ASSUME_NONNULL_END
