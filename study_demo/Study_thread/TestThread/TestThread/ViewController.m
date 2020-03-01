//
//  ViewController.m
//  TestThread
//
//  Created by JianweiChen on 2018/8/23.
//  Copyright © 2018 inke. All rights reserved.
//

#import "ViewController.h"
#import "ThreadManager.h"

@interface ViewController ()
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, strong) dispatch_queue_t queue2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i = 0; i < 100000; i++) {
        [[ThreadManager shareInstance] asynBlock:^{
//            sleep(10);
//            NSLog(@"do block %d",i);
            NSLog(@"do block %d",i);
            sleep(0.001);
            NSLog(@"do block %d end",i);
        }];
    }
    
//     self.queue = dispatch_queue_create("com.up.1", DISPATCH_QUEUE_CONCURRENT);
//     self.queue2 = dispatch_queue_create("com.up.2", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_queue_t *conqueue = dispatch_queue_create("com.up.1", DISPATCH_QUEUE_CONCURRENT);
    
//    dispatch_async(self.queue, ^{
//        NSLog(@"1%@",[NSThread currentThread]);
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSLog(@"");
//        });
//        dispatch_sync(self.queue2, ^{
//            NSLog(@"2%@",[NSThread currentThread]);
//        });
//
//    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
