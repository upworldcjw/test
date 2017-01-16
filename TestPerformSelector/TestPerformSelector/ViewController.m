//
//  ViewController.m
//  TestBase
//
//  Created by jianwei on 06/01/2017.
//  Copyright © 2017 jianwei. All rights reserved.
//

#import "ViewController.h"

@interface Person : NSObject
@end

@implementation Person
- (void)personTest{
    NSLog(@"personTest");
}

- (void)invoke{
    [self performSelector:@selector(personTest) withObject:nil afterDelay:0];
}
- (void)dealloc{
    [self invoke];
//    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testMethod_1];
    [self testMethod_2];
}

- (void)testMethod_1{
    [self performSelector:@selector(test1) withObject:nil afterDelay:0];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)test1{
    NSLog(@"test1");
}

- (void)testMethod_2{
//    @autoreleasepool {
        Person *person = [Person new];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
