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
    [self testMethod_8];
    //    [self testMethod_12];
    
    //    [self testTargetQueue];
    //    [self testTargetQueue2];
    
    //[self dispatchBarrierAsyncDemo];
    
    //[self dispatchBlockWaitDemo];
//        [self dispatchBlockNotifyDemo];
//    [self dispatchBlockCancelDemo];
//    [self deadLockCase1];
//    [self deadLockCase3];
//    [self deadLockCase5];
}


- (void)deadLockCase1 {
    NSLog(@"1");
    //主队列的同步线程，按照FIFO的原则（先入先出），2排在3后面会等3执行完，但因为同步线程，3又要等2执行完，相互等待成为死锁。
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
}
- (void)deadLockCase2 {
    NSLog(@"1");
    //3会等2，因为2在全局并行队列里，不需要等待3，这样2执行完回到主队列，3就开始执行
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
}
- (void)deadLockCase3 {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.starming.gcddemo.serialqueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    dispatch_async(serialQueue, ^{
        NSLog(@"2");
        //串行队列里面同步一个串行队列就会死锁
        dispatch_sync(serialQueue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
}
//- (void)deadLockCase4 {
//    NSLog(@"1");
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"2");
//        //将同步的串行队列放到另外一个线程就能够解决
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSLog(@"3");
//        });
//        NSLog(@"4");
//    });
//    NSLog(@"5");
//}
- (void)deadLockCase5 {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1");
        //回到主线程发现死循环后面就没法执行了
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"2");
        });
        NSLog(@"3");
    });
    NSLog(@"4");
}
//ceshi
- (void)testDeallocQueue {
    //
    static void  *kTargetQueue = &kTargetQueue;
    static void  *kQueue1 = &kQueue1;
    static void  *kQueue2 = &kQueue2;
    
    dispatch_queue_t targetQueue = dispatch_queue_create("targetQueue", DISPATCH_QUEUE_SERIAL);//目标队列
    dispatch_queue_set_specific(targetQueue, kTargetQueue, kTargetQueue, NULL);
    
    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_SERIAL);//串行队列
    dispatch_queue_set_specific(queue1, kQueue1, kQueue1, NULL);

    dispatch_queue_t queue2 = dispatch_queue_create("queu2", DISPATCH_QUEUE_CONCURRENT);//并发队列
    dispatch_queue_set_specific(queue2, kQueue2, kQueue2, NULL);

    //设置参考
    dispatch_set_target_queue(queue1, targetQueue);
    dispatch_set_target_queue(queue2, targetQueue);
    __block int i = 0;
    dispatch_block_t block = ^{
        i ++;
        if (dispatch_get_specific(kQueue1) == kQueue1) {
            NSLog(@"%d => onQueue1",i);
        }
        if (dispatch_get_specific(kQueue2) == kQueue2) {
             NSLog(@"%d => onQueue2",i);
         }
        if (dispatch_get_specific(kTargetQueue) == kTargetQueue) {
             NSLog(@"%d => onTargetQueue",i);
         }
    };
    dispatch_async(queue2, ^{
        block();
        NSLog(@"job3 in");
        //下面会死死锁
//        dispatch_sync(queue2, ^{
//            block();
//            NSLog(@"job3 middle");
//        });
        
        //下面会死死锁，targetQueue也可能造成死锁
//        dispatch_sync(targetQueue, ^{
//            block();
//            NSLog(@"job3 middle");
//        });
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"job3 out");
    });
    
    dispatch_sync(targetQueue, ^{
        block();
        NSLog(@"job4 excute");
    });
    
    dispatch_sync(queue1, ^{
        NSLog(@"job5 excute");
    });
    
    dispatch_async(queue2, ^{
        block();
        NSLog(@"job2 in");
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"job2 out");
    });
    dispatch_async(queue1, ^{
        block();
        NSLog(@"job1 in");
        [NSThread sleepForTimeInterval:3.f];
        NSLog(@"job1 out");
    });
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

///!!!dispatch_barrier_async只在自己创建的队列上有这种作用，在全局并发队列和串行队列上，效果和dispatch_sync一样
- (void)dispatchBarrierAsyncDemo {
    //防止文件读写冲突，可以创建一个串行队列，操作都在这个队列中进行，没有更新数据读用并行，写用串行。
    dispatch_queue_t dataQueue = dispatch_queue_create("com.starming.gcddemo.dataqueue", DISPATCH_QUEUE_CONCURRENT);
    //dispatch_queue_t dataQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dataQueue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"read data 1");
    });
    dispatch_async(dataQueue, ^{
        NSLog(@"read data 2");
    });
    //等待前面的都完成，在执行barrier后面的
    dispatch_barrier_async(dataQueue, ^{
        NSLog(@"write data 1");
        [NSThread sleepForTimeInterval:1];
    });
    dispatch_async(dataQueue, ^{
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"read data 3");
    });
    dispatch_async(dataQueue, ^{
        NSLog(@"read data 4");
    });
}

///dispatch_block_wait 阻塞当前线程，直到当前队列block执行完
-(void)dispatchBlockWaitDemo {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.starming.gcddemo.serialqueue", DISPATCH_QUEUE_SERIAL);
    dispatch_block_t block = dispatch_block_create(0, ^{
        NSLog(@"star");
        [NSThread sleepForTimeInterval:5.f];
        NSLog(@"end");
    });
    dispatch_async(serialQueue, block);
    //设置DISPATCH_TIME_FOREVER会一直等到前面任务都完成
    dispatch_block_wait(block, DISPATCH_TIME_FOREVER);
    NSLog(@"ok, now can go on");
}

//dispatch_block_notify
- (void)dispatchBlockNotifyDemo {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.starming.gcddemo.serialqueue", DISPATCH_QUEUE_SERIAL);
    dispatch_block_t firstBlock = dispatch_block_create(0, ^{
        NSLog(@"first block start");
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"first block end");
    });
    dispatch_async(serialQueue, firstBlock);
    dispatch_block_t secondBlock = dispatch_block_create(0, ^{
        NSLog(@"second block run");
    });
    //first block执行完才在serial queue中执行second block
    dispatch_block_notify(firstBlock, serialQueue, secondBlock);
}

//dispatch_block_cancel：iOS8后GCD支持对dispatch block的取消
-(void)dispatchBlockCancelDemo {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.starming.gcddemo.serialqueue", DISPATCH_QUEUE_SERIAL);
    dispatch_block_t firstBlock = dispatch_block_create(0, ^{
        NSLog(@"first block start");
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"first block end");
    });
    dispatch_block_t secondBlock = dispatch_block_create(0, ^{
        NSLog(@"second block run");
    });
    dispatch_async(serialQueue, firstBlock);
    dispatch_async(serialQueue, secondBlock);
    //取消secondBlock
    dispatch_block_cancel(secondBlock);
}


//dispatch_group_wait
-(void)dispatchGroupWaitDemo {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.starming.gcddemo.concurrentqueue",DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    //在group中添加队列的block
    dispatch_group_async(group, concurrentQueue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"1");
    });
    dispatch_group_async(group, concurrentQueue, ^{
        NSLog(@"2");
    });
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"go on");
}

//dispatch_group_notify
- (void)dispatchGroupNotifyDemo {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.starming.gcddemo.concurrentqueue",DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, concurrentQueue, ^{
        NSLog(@"1");
    });
    dispatch_group_async(group, concurrentQueue, ^{
        NSLog(@"2");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"end");
    });
    NSLog(@"can continue");
    
}
//dispatch_group_enter dispatch_group_leave
////给Core Data的-performBlock:添加groups。组合完成任务后使用dispatch_group_notify来运行一个block即可。
//- (void)withGroup:(dispatch_group_t)group performBlock:(dispatch_block_t)block
//{
//    if (group == NULL) {
//        [self performBlock:block];
//    } else {
//        dispatch_group_enter(group);
//        [self performBlock:^(){
//            block();
//            dispatch_group_leave(group);
//        }];
//    }
//}
//
////NSURLConnection也可以这样做
//+ (void)withGroup:(dispatch_group_t)group
//sendAsynchronousRequest:(NSURLRequest *)request
//            queue:(NSOperationQueue *)queue
//completionHandler:(void (^)(NSURLResponse*, NSData*, NSError*))handler
//{
//    if (group == NULL) {
//        [self sendAsynchronousRequest:request
//                                queue:queue
//                    completionHandler:handler];
//    } else {
//        dispatch_group_enter(group);
//        [self sendAsynchronousRequest:request
//                                queue:queue
//                    completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
//                        handler(response, data, error);
//                        dispatch_group_leave(group);
//                    }];
//    }
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
