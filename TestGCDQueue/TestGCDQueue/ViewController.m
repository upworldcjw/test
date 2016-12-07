//
//  ViewController.m
//  TestGCDQueue
//
//  Created by jianwei on 01/12/2016.
//  Copyright © 2016 jianwei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    dispatch_queue_t _serialQueue;
    dispatch_queue_t _concurrentQueue;
}

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
    [self testMethod_12];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//同一个线程串行queue asy会创建一个线程，所有都在这个线程执行 fifo
- (void)testMethod_1{
    [self testSerialMethodSyn:NO withTag:@"one"];
    [self testSerialMethodSyn:NO withTag:@"two"];
    [self testSerialMethodSyn:NO withTag:@"three"];
    [self testSerialMethodSyn:NO withTag:@"five"];
    //one ==== 1  <NSThread: 0x17406f480>{number = 3, name = (null)} Main:NO
    //one ==== 2  <NSThread: 0x17406f480>{number = 3, name = (null)} Main:NO
    //one ==== 3  <NSThread: 0x17406f480>{number = 3, name = (null)} Main:NO
    //one ==== 4  <NSThread: 0x17406f480>{number = 3, name = (null)} Main:NO
    //two ==== 1  <NSThread: 0x17406f480>{number = 3, name = (null)} Main:NO
    //two ==== 2  <NSThread: 0x17406f480>{number = 3, name = (null)} Main:NO
    //two ==== 3  <NSThread: 0x17406f480>{number = 3, name = (null)} Main:NO
    //two ==== 4  <NSThread: 0x17406f480>{number = 3, name = (null)} Main:NO
    //three ==== 1  <NSThread: 0x17406f480>{number = 3, name = (null)} Main:NO
    //three ==== 2  <NSThread: 0x17406f480>{number = 3, name = (null)} Main:NO
    //three ==== 3  <NSThread: 0x17406f480>{number = 3, name = (null)} Main:NO
    //three ==== 4  <NSThread: 0x17406f480>{number = 3, name = (null)} Main:NO
    //five ==== 1  <NSThread: 0x17406f480>{number = 3, name = (null)} Main:NO
    //five ==== 2  <NSThread: 0x17406f480>{number = 3, name = (null)} Main:NO
    //five ==== 3  <NSThread: 0x17406f480>{number = 3, name = (null)} Main:NO
    //five ==== 4  <NSThread: 0x17406f480>{number = 3, name = (null)} Main:NO
}

//不同线程串行queue asy会创建一个线程，所有都在这个线程执行 fifo
- (void)testMethod_2{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"before %@",[NSThread currentThread]);
        [self testSerialMethodSyn:NO withTag:@"one"];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"before %@",[NSThread currentThread]);
        [self testSerialMethodSyn:NO withTag:@"two"];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"before %@",[NSThread currentThread]);
        [self testSerialMethodSyn:NO withTag:@"three"];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"before %@",[NSThread currentThread]);
        [self testSerialMethodSyn:NO withTag:@"five"];
    });
//    2016-12-01 15:23:10.135 TestGCDQueue[246:49982] before <NSThread: 0x15e97480>{number = 2, name = (null)}
//    2016-12-01 15:23:10.136 TestGCDQueue[246:49984] before <NSThread: 0x15e97ab0>{number = 3, name = (null)}
//    2016-12-01 15:23:10.135 TestGCDQueue[246:49983] before <NSThread: 0x15d96360>{number = 4, name = (null)}
//    2016-12-01 15:23:10.139 TestGCDQueue[246:49982] before <NSThread: 0x15e97480>{number = 2, name = (null)}
//    one ==== 1  <NSThread: 0x15e97620>{number = 5, name = (null)} Main:NO
//    one ==== 2  <NSThread: 0x15e97620>{number = 5, name = (null)} Main:NO
//    one ==== 3  <NSThread: 0x15e97620>{number = 5, name = (null)} Main:NO
//    one ==== 4  <NSThread: 0x15e97620>{number = 5, name = (null)} Main:NO
//    three ==== 1  <NSThread: 0x15e97620>{number = 5, name = (null)} Main:NO
//    three ==== 2  <NSThread: 0x15e97620>{number = 5, name = (null)} Main:NO
//    three ==== 3  <NSThread: 0x15e97620>{number = 5, name = (null)} Main:NO
//    three ==== 4  <NSThread: 0x15e97620>{number = 5, name = (null)} Main:NO
//    two ==== 1  <NSThread: 0x15e97620>{number = 5, name = (null)} Main:NO
//    two ==== 2  <NSThread: 0x15e97620>{number = 5, name = (null)} Main:NO
//    two ==== 3  <NSThread: 0x15e97620>{number = 5, name = (null)} Main:NO
//    two ==== 4  <NSThread: 0x15e97620>{number = 5, name = (null)} Main:NO
//    five ==== 1  <NSThread: 0x15e97620>{number = 5, name = (null)} Main:NO
//    five ==== 2  <NSThread: 0x15e97620>{number = 5, name = (null)} Main:NO
//    five ==== 3  <NSThread: 0x15e97620>{number = 5, name = (null)} Main:NO
//    five ==== 4  <NSThread: 0x15e97620>{number = 5, name = (null)} Main:NO
}

//同一个线程串行queue syn不会创建线程，所有都在原来线程执行，fifo
- (void)testMethod_3{
    [self testSerialMethodSyn:YES withTag:@"one"];
    [self testSerialMethodSyn:YES withTag:@"two"];
    [self testSerialMethodSyn:YES withTag:@"three"];
    [self testSerialMethodSyn:YES withTag:@"five"];
//    one ==== 1  <NSThread: 0x17e4c090>{number = 1, name = main} Main:YES
//    one ==== 2  <NSThread: 0x17e4c090>{number = 1, name = main} Main:YES
//    one ==== 3  <NSThread: 0x17e4c090>{number = 1, name = main} Main:YES
//    one ==== 4  <NSThread: 0x17e4c090>{number = 1, name = main} Main:YES
//    two ==== 1  <NSThread: 0x17e4c090>{number = 1, name = main} Main:YES
//    two ==== 2  <NSThread: 0x17e4c090>{number = 1, name = main} Main:YES
//    two ==== 3  <NSThread: 0x17e4c090>{number = 1, name = main} Main:YES
//    two ==== 4  <NSThread: 0x17e4c090>{number = 1, name = main} Main:YES
//    three ==== 1  <NSThread: 0x17e4c090>{number = 1, name = main} Main:YES
//    three ==== 2  <NSThread: 0x17e4c090>{number = 1, name = main} Main:YES
//    three ==== 3  <NSThread: 0x17e4c090>{number = 1, name = main} Main:YES
//    three ==== 4  <NSThread: 0x17e4c090>{number = 1, name = main} Main:YES
//    five ==== 1  <NSThread: 0x17e4c090>{number = 1, name = main} Main:YES
//    five ==== 2  <NSThread: 0x17e4c090>{number = 1, name = main} Main:YES
//    five ==== 3  <NSThread: 0x17e4c090>{number = 1, name = main} Main:YES
//    five ==== 4  <NSThread: 0x17e4c090>{number = 1, name = main} Main:YES
}


//不同线程串行queue syn 不会创建线程，fifo
- (void)testMethod_4{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"one before %@",[NSThread currentThread]);
        [self testSerialMethodSyn:YES withTag:@"one"];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"two before %@",[NSThread currentThread]);
        [self testSerialMethodSyn:YES withTag:@"two"];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"three before %@",[NSThread currentThread]);
        [self testSerialMethodSyn:YES withTag:@"three"];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"five before %@",[NSThread currentThread]);
        [self testSerialMethodSyn:YES withTag:@"five"];
    });
//    2016-12-01 15:33:40.610 TestGCDQueue[268:51700] two before <NSThread: 0x14593820>{number = 4, name = (null)}
//    two ==== 1  <NSThread: 0x14593820>{number = 4, name = (null)} Main:NO
//    two ==== 2  <NSThread: 0x14593820>{number = 4, name = (null)} Main:NO
//    two ==== 3  <NSThread: 0x14593820>{number = 4, name = (null)} Main:NO
//    2016-12-01 15:33:40.609 TestGCDQueue[268:51698] one before <NSThread: 0x1468d890>{number = 2, name = (null)}
//    two ==== 4  <NSThread: 0x14593820>{number = 4, name = (null)} Main:NO
//    2016-12-01 15:33:40.610 TestGCDQueue[268:51701] three before <NSThread: 0x14584970>{number = 3, name = (null)}
//    one ==== 1  <NSThread: 0x1468d890>{number = 2, name = (null)} Main:NO
//    one ==== 2  <NSThread: 0x1468d890>{number = 2, name = (null)} Main:NO
//    one ==== 3  <NSThread: 0x1468d890>{number = 2, name = (null)} Main:NO
//    one ==== 4  <NSThread: 0x1468d890>{number = 2, name = (null)} Main:NO
//    2016-12-01 15:33:40.619 TestGCDQueue[268:51700] five before <NSThread: 0x14593820>{number = 4, name = (null)}
//    five ==== 1  <NSThread: 0x14593820>{number = 4, name = (null)} Main:NO
//    five ==== 2  <NSThread: 0x14593820>{number = 4, name = (null)} Main:NO
//    five ==== 3  <NSThread: 0x14593820>{number = 4, name = (null)} Main:NO
//    five ==== 4  <NSThread: 0x14593820>{number = 4, name = (null)} Main:NO
//    three ==== 1  <NSThread: 0x14584970>{number = 3, name = (null)} Main:NO
//    three ==== 2  <NSThread: 0x14584970>{number = 3, name = (null)} Main:NO
//    three ==== 3  <NSThread: 0x14584970>{number = 3, name = (null)} Main:NO
//    three ==== 4  <NSThread: 0x14584970>{number = 3, name = (null)} Main:NO
}

//同一个线程，并行queue，会启动多个线程分别执行，不满足fifo
- (void)testMethod_5{
    [self testConcurrentSyn:NO withTag:@"one"];
    [self testConcurrentSyn:NO withTag:@"two"];
    [self testConcurrentSyn:NO withTag:@"three"];
    [self testConcurrentSyn:NO withTag:@"five"];
    
//    one ==== 1  <NSThread: 0x14564030>{number = 2, name = (null)} Main:NO
//    one ==== 2  <NSThread: 0x14564030>{number = 2, name = (null)} Main:NO
//    one ==== 3  <NSThread: 0x14564030>{number = 2, name = (null)} Main:NO
//    two ==== 1  <NSThread: 0x1456f0b0>{number = 3, name = (null)} Main:NO
//    two ==== 2  <NSThread: 0x1456f0b0>{number = 3, name = (null)} Main:NO
//    one ==== 4  <NSThread: 0x14564030>{number = 2, name = (null)} Main:NO
//    five ==== 1  <NSThread: 0x14564030>{number = 2, name = (null)} Main:NO
//    five ==== 2  <NSThread: 0x14564030>{number = 2, name = (null)} Main:NO
//    five ==== 3  <NSThread: 0x14564030>{number = 2, name = (null)} Main:NO
//    five ==== 4  <NSThread: 0x14564030>{number = 2, name = (null)} Main:NO
//    three ==== 1  <NSThread: 0x146724e0>{number = 4, name = (null)} Main:NO
//    three ==== 2  <NSThread: 0x146724e0>{number = 4, name = (null)} Main:NO
//    three ==== 3  <NSThread: 0x146724e0>{number = 4, name = (null)} Main:NO
//    three ==== 4  <NSThread: 0x146724e0>{number = 4, name = (null)} Main:NO
//    two ==== 3  <NSThread: 0x1456f0b0>{number = 3, name = (null)} Main:NO
//    two ==== 4  <NSThread: 0x1456f0b0>{number = 3, name = (null)} Main:NO
}

//不同线程，并行queue，会启动多个线程分别执行，不满足fifo
- (void)testMethod_6{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"one before %@",[NSThread currentThread]);
        [self testConcurrentSyn:NO withTag:@"one"];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"two before %@",[NSThread currentThread]);
        [self testConcurrentSyn:NO withTag:@"two"];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"three before %@",[NSThread currentThread]);
        [self testConcurrentSyn:NO withTag:@"three"];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"five before %@",[NSThread currentThread]);
        [self testConcurrentSyn:NO withTag:@"five"];
    });
//    2016-12-01 15:47:49.722 TestGCDQueue[307:54480] two before <NSThread: 0x16d81de0>{number = 3, name = (null)}
//    2016-12-01 15:47:49.723 TestGCDQueue[307:54481] one before <NSThread: 0x16d81d20>{number = 2, name = (null)}
//    2016-12-01 15:47:49.723 TestGCDQueue[307:54482] three before <NSThread: 0x16d95ea0>{number = 4, name = (null)}
//    2016-12-01 15:47:49.726 TestGCDQueue[307:54480] five before <NSThread: 0x16d81de0>{number = 3, name = (null)}
//    one ==== 1  <NSThread: 0x16d95ea0>{number = 4, name = (null)} Main:NO
//    three ==== 1  <NSThread: 0x16d81de0>{number = 3, name = (null)} Main:NO
//    one ==== 2  <NSThread: 0x16d95ea0>{number = 4, name = (null)} Main:NO
//    one ==== 3  <NSThread: 0x16d95ea0>{number = 4, name = (null)} Main:NO
//    three ==== 2  <NSThread: 0x16d81de0>{number = 3, name = (null)} Main:NO
//    one ==== 4  <NSThread: 0x16d95ea0>{number = 4, name = (null)} Main:NO
//    three ==== 3  <NSThread: 0x16d81de0>{number = 3, name = (null)} Main:NO
//    three ==== 4  <NSThread: 0x16d81de0>{number = 3, name = (null)} Main:NO
//    five ==== 1  <NSThread: 0x16d95ea0>{number = 4, name = (null)} Main:NO
//    two ==== 1  <NSThread: 0x16d81d20>{number = 2, name = (null)} Main:NO
//    five ==== 2  <NSThread: 0x16d95ea0>{number = 4, name = (null)} Main:NO
//    two ==== 2  <NSThread: 0x16d81d20>{number = 2, name = (null)} Main:NO
//    five ==== 3  <NSThread: 0x16d95ea0>{number = 4, name = (null)} Main:NO
//    two ==== 3  <NSThread: 0x16d81d20>{number = 2, name = (null)} Main:NO
//    five ==== 4  <NSThread: 0x16d95ea0>{number = 4, name = (null)} Main:NO
//    two ==== 4  <NSThread: 0x16d81d20>{number = 2, name = (null)} Main:NO
}


//同一个线程，并行queue，会在当前线程fifo
- (void)testMethod_7{
    [self testConcurrentSyn:YES withTag:@"one"];
    [self testConcurrentSyn:YES withTag:@"two"];
    [self testConcurrentSyn:YES withTag:@"three"];
    [self testConcurrentSyn:YES withTag:@"five"];
//    one ==== 1  <NSThread: 0x16564f60>{number = 1, name = main} Main:YES
//    one ==== 2  <NSThread: 0x16564f60>{number = 1, name = main} Main:YES
//    one ==== 3  <NSThread: 0x16564f60>{number = 1, name = main} Main:YES
//    one ==== 4  <NSThread: 0x16564f60>{number = 1, name = main} Main:YES
//    two ==== 1  <NSThread: 0x16564f60>{number = 1, name = main} Main:YES
//    two ==== 2  <NSThread: 0x16564f60>{number = 1, name = main} Main:YES
//    two ==== 3  <NSThread: 0x16564f60>{number = 1, name = main} Main:YES
//    two ==== 4  <NSThread: 0x16564f60>{number = 1, name = main} Main:YES
//    three ==== 1  <NSThread: 0x16564f60>{number = 1, name = main} Main:YES
//    three ==== 2  <NSThread: 0x16564f60>{number = 1, name = main} Main:YES
//    three ==== 3  <NSThread: 0x16564f60>{number = 1, name = main} Main:YES
//    three ==== 4  <NSThread: 0x16564f60>{number = 1, name = main} Main:YES
//    five ==== 1  <NSThread: 0x16564f60>{number = 1, name = main} Main:YES
//    five ==== 2  <NSThread: 0x16564f60>{number = 1, name = main} Main:YES
//    five ==== 3  <NSThread: 0x16564f60>{number = 1, name = main} Main:YES
//    five ==== 4  <NSThread: 0x16564f60>{number = 1, name = main} Main:YES
}

//不同线程，并行queue，会在当前线程。fifo
- (void)testMethod_8{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"one before %@",[NSThread currentThread]);
        [self testConcurrentSyn:YES withTag:@"one"];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"two before %@",[NSThread currentThread]);
        [self testConcurrentSyn:YES withTag:@"two"];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"three before %@",[NSThread currentThread]);
        [self testConcurrentSyn:YES withTag:@"three"];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"five before %@",[NSThread currentThread]);
        [self testConcurrentSyn:YES withTag:@"five"];
    });
//    2016-12-01 15:53:50.718 TestGCDQueue[324:55585] two before <NSThread: 0x16d91b40>{number = 3, name = (null)}
//    2016-12-01 15:53:50.718 TestGCDQueue[324:55586] one before <NSThread: 0x16d919b0>{number = 2, name = (null)}
//    two ==== 1  <NSThread: 0x16d91b40>{number = 3, name = (null)} Main:NO
//    two ==== 2  <NSThread: 0x16d91b40>{number = 3, name = (null)} Main:NO
//    two ==== 3  <NSThread: 0x16d91b40>{number = 3, name = (null)} Main:NO
//    two ==== 4  <NSThread: 0x16d91b40>{number = 3, name = (null)} Main:NO
//    one ==== 1  <NSThread: 0x16d919b0>{number = 2, name = (null)} Main:NO
//    one ==== 2  <NSThread: 0x16d919b0>{number = 2, name = (null)} Main:NO
//    one ==== 3  <NSThread: 0x16d919b0>{number = 2, name = (null)} Main:NO
//    one ==== 4  <NSThread: 0x16d919b0>{number = 2, name = (null)} Main:NO
//    2016-12-01 15:53:50.723 TestGCDQueue[324:55585] five before <NSThread: 0x16d91b40>{number = 3, name = (null)}
//    five ==== 1  <NSThread: 0x16d91b40>{number = 3, name = (null)} Main:NO
//    five ==== 2  <NSThread: 0x16d91b40>{number = 3, name = (null)} Main:NO
//    five ==== 3  <NSThread: 0x16d91b40>{number = 3, name = (null)} Main:NO
//    five ==== 4  <NSThread: 0x16d91b40>{number = 3, name = (null)} Main:NO
//    2016-12-01 15:53:50.718 TestGCDQueue[324:55583] three before <NSThread: 0x16d91cf0>{number = 4, name = (null)}
//    three ==== 1  <NSThread: 0x16d91cf0>{number = 4, name = (null)} Main:NO
//    three ==== 2  <NSThread: 0x16d91cf0>{number = 4, name = (null)} Main:NO
//    three ==== 3  <NSThread: 0x16d91cf0>{number = 4, name = (null)} Main:NO
//    three ==== 4  <NSThread: 0x16d91cf0>{number = 4, name = (null)} Main:NO
}


//如果串行queue，在asy执行的时候，syn不能够执行，直到asy执行完才有机会.
- (void)testMethod_9{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self testSerialMethodSyn:YES withTag:@"one"];
        exit(0);
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self gcdTestSerialQueueMethod:^{
            while (YES) {
                printf("asyn");
            }
        } syn:NO];
    });
}

//如果并行queue，在asy执行的时候，syn能够执行.
- (void)testMethod_10{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self testConcurrentSyn:YES withTag:@"one"];
        exit(0);
    });
    [self gcdTestConcurrentQueueMethod:^{
        while (YES) {
            printf("asyn");
        }
    } syn:NO];
    //  *****  asynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynone ==== 2  <NSThread: 0x7f98fef00510>{number = 1, name = main} Main:YES
    //    asynone ==== 3  <NSThread: 0x7f98fef00510>{number = 1, name = main} Main:YES
    //    asynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynone ==== 4  <NSThread: 0x7f98fef00510>{number = 1, name = main} Main:YES
    //    asynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynasynas
    //    ****
}



//如果并行queue，在asy执行的时候，dispatch_barrier_sync不能够执行.
- (void)testMethod_11{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_barrier_sync(_concurrentQueue, ^{
            for (int i=1; i<100; i++)
            {
                NSString *isMain = [[NSThread currentThread] isMainThread]?@"YES":@"NO";
                NSString *string = [NSString stringWithFormat:@"%@ ====% 2d  %@ Main:%@",@"dispatch_barrier_sync",i,[NSThread currentThread],isMain];
                printf("%s\n", [string UTF8String]);
            }

        });
        exit(0);
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self gcdTestConcurrentQueueMethod:^{
            while (YES) {
                printf("asyn");
            }
        } syn:NO];
    });
}

//如果并行queue，在asy执行的时候，dispatch_barrier_sync不能够执行.
- (void)testMethod_12{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self gcdTestConcurrentQueueMethod:^{
            for (int i=1; i<100; i++)
            {
                NSString *isMain = [[NSThread currentThread] isMainThread]?@"YES":@"NO";
                NSString *string = [NSString stringWithFormat:@"%@ ====% 2d  %@ Main:%@",@"dispatch_barrier_sync",i,[NSThread currentThread],isMain];
                printf("%s\n", [string UTF8String]);
            }
        } syn:YES];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_barrier_async(_concurrentQueue, ^{
            while (YES) {
                printf("asyn");
            }
        });
    });
}



//- (dispatch_block_t)blockWithTag:(NSString *)tag{
//    return ^{
//        for (int i=1; i<5; i++)
//        {
//            NSString *isMain = [[NSThread currentThread] isMainThread]?@"YES":@"NO";
//            NSString *string = [NSString stringWithFormat:@"%@ ====% 2d  %@ Main:%@",bTag,i,[NSThread currentThread],isMain];
//            printf("%s\n", [string UTF8String]);
//        }
//}


- (void)testSerialMethodSyn:(BOOL)syn withTag:(NSString *)tag{
    __block NSString *bTag = tag;
    [self gcdTestSerialQueueMethod:^{
        for (int i=1; i<5; i++)
        {
            NSString *isMain = [[NSThread currentThread] isMainThread]?@"YES":@"NO";
            //            NSLog(@"%@ ====% 2d  %@ Main:%@",bTag,i,[NSThread currentThread],isMain);
            NSString *string = [NSString stringWithFormat:@"%@ ====% 2d  %@ Main:%@",bTag,i,[NSThread currentThread],isMain];
            printf("%s\n", [string UTF8String]);
        }
    } syn:syn];
}

- (void)testConcurrentSyn:(BOOL)syn withTag:(NSString *)tag {
    __block NSString *bTag = tag;
    [self gcdTestConcurrentQueueMethod:^{
        for (int i=1; i<5; i++)
        {
            NSString *isMain = [[NSThread currentThread] isMainThread]?@"YES":@"NO";
            NSString *string = [NSString stringWithFormat:@"%@ ====% 2d  %@ Main:%@",bTag,i,[NSThread currentThread],isMain];
            printf("%s\n", [string UTF8String]);
        }
    } syn:syn];
}


- (void)gcdTestSerialQueueMethod:(dispatch_block_t)oneGcdObject syn:(BOOL)syn 
{
    if (syn) {
        dispatch_sync(_serialQueue, oneGcdObject);
    }else{
        dispatch_async(_serialQueue, oneGcdObject);
    }
}

- (void)gcdTestConcurrentQueueMethod:(dispatch_block_t)oneGcdObject syn:(BOOL)syn{
    if (syn) {
        dispatch_sync(_concurrentQueue, oneGcdObject);
    }else{
        dispatch_async(_concurrentQueue, oneGcdObject);
    }
}
@end
