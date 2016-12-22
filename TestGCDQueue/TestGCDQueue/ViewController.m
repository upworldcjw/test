//
//  ViewController.m
//  TestGCDQueue
//
//  Created by jianwei on 01/12/2016.
//  Copyright © 2016 jianwei. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+TestSynOrAsyn.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    if (!_serialQueue){
        static NSString *queueSerialName = @"test.serial.queue";
        _serialQueue =
        dispatch_queue_create([queueSerialName UTF8String], DISPATCH_QUEUE_SERIAL);
    }
    if (!_concurrentQueue){
        static NSString *queueConcurrentName = @"test.concurrent.queue";
        _concurrentQueue =
        dispatch_queue_create([queueConcurrentName UTF8String], DISPATCH_QUEUE_CONCURRENT);
    }
    
    [super viewDidLoad];
    //    [self testMethod_12];
    
    //    [self testTargetQueue];
    [self testTargetQueue2];
}


- (void)testTargetQueue {
    dispatch_queue_t targetQueue = dispatch_queue_create("test.target.queue", DISPATCH_QUEUE_SERIAL);
    //    dispatch_queue_t targetQueue = dispatch_queue_create("test.target.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue1 = dispatch_queue_create("test.1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("test.2", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue3 = dispatch_queue_create("test.3", DISPATCH_QUEUE_SERIAL);
    
    dispatch_set_target_queue(queue1, targetQueue);
    dispatch_set_target_queue(queue2, targetQueue);
    dispatch_set_target_queue(queue3, targetQueue);
    
    
    dispatch_async(queue1, ^{
        NSLog(@"queue1_1 in");
        [NSThread sleepForTimeInterval:3.f];
        NSLog(@"queue1_1 out");
    });
    dispatch_async(queue1, ^{
        NSLog(@"queue1_2 in");
        [NSThread sleepForTimeInterval:3.f];
        NSLog(@"queue1_2 out");
    });
    
    
    dispatch_async(queue2, ^{
        NSLog(@"2 in");
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"2 out");
    });
    dispatch_async(queue3, ^{
        NSLog(@"3 in");
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"3 out");
    });
    
}


//http://www.cnblogs.com/denz/archive/2016/02/24/5214297.html
- (void)testTargetQueue2 {
    //创建一个串行队列queue1
    dispatch_queue_t queue1 = dispatch_queue_create("test.1", DISPATCH_QUEUE_SERIAL);
    //创建一个串行队列queue2
    dispatch_queue_t queue2 = dispatch_queue_create("test.2", DISPATCH_QUEUE_SERIAL);
    
    //使用dispatch_set_target_queue()实现队列的动态调度管理
    dispatch_set_target_queue(queue1, queue2);
    
    
    /*
     12
     13     <*>dispatch_set_target_queue(Dispatch Queue1, Dispatch Queue2);
     14     那么dispatchA上还未运行的block会在dispatchB上运行。这时如果暂停dispatchA运行：
     15
     16     <*>dispatch_suspend(dispatchA);
     17     这时则只会暂停dispatchA上原来的block的执行，dispatchB的block则不受影响。而如果暂停dispatchB的运行，则会暂停dispatchA的运行。
     18
     19     这里只简单举个例子，说明dispatch队列运行的灵活性，在实际应用中你会逐步发掘出它的潜力。
     20
     21     dispatch队列不支持cancel（取消），没有实现dispatch_cancel()函数，不像NSOperationQueue，不得不说这是个小小的缺憾
     22
     23 */
    dispatch_async(queue1, ^{
        for (NSInteger i = 0; i < 10; i++) {
            NSLog(@"queue1:%@, %ld", [NSThread currentThread], i);
            if (i == 5) {
                dispatch_async(dispatch_get_main_queue(), ^{
//                    NSLog(@"dispatch_suspend");
//                    dispatch_suspend(queue2);
//                    [NSThread sleepForTimeInterval:5];
//                    dispatch_resume(queue2);
//                    NSLog(@"dispatch_suspend end");
                    NSLog(@"dispatch_suspend");
                    dispatch_suspend(queue1);
                    [NSThread sleepForTimeInterval:5];
                    dispatch_resume(queue1);
                    NSLog(@"dispatch_suspend end");
                });
            }
        }
    });
    
    dispatch_async(queue1, ^{
        for (NSInteger i = 20; i < 30; i++) {
            [NSThread sleepForTimeInterval:0.005];
            NSLog(@"queue1:%@, %ld", [NSThread currentThread], i);
        }
        
    });
    
    dispatch_async(queue1, ^{
        for (NSInteger i = 50; i < 60; i++) {
            [NSThread sleepForTimeInterval:0.005];
            NSLog(@"queue1:%@, %ld", [NSThread currentThread], i);
        }
        
    });
    
    dispatch_async(queue2, ^{
        for (NSInteger i = 70; i < 80; i++) {
            [NSThread sleepForTimeInterval:0.005];
            NSLog(@"queue2:%@, %ld", [NSThread currentThread], i);
        }
    });
    

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
