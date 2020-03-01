//
//  ViewController.m
//  TestRunLoop
//
//  Created by JianweiChen on 2018/7/13.
//  Copyright © 2018 inke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

//typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
//    //即将进入RunLoop的执行循环 1
//    kCFRunLoopEntry = (1UL << 0),
//    //即将处理Timer事件 2
//    kCFRunLoopBeforeTimers = (1UL << 1),
//    //即将处理Source事件 4
//    kCFRunLoopBeforeSources = (1UL << 2),
//    //RunLoop即将进入休眠状态 32
//    kCFRunLoopBeforeWaiting = (1UL << 5),
//    //RunLoop即将被唤醒 64
//    kCFRunLoopAfterWaiting = (1UL << 6),
//    //RunLoop即将退出 128
//    kCFRunLoopExit = (1UL << 7),
//    //监听RunLoop的全部状态
//    kCFRunLoopAllActivities = 0x0FFFFFFFU
//};

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    // 创建观察者
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"Status has changed into: %zd", activity);
    });
    
    /*
     将监听器添加到当前RunLoop对象中，在RunLoop循环中就会执行上述回调块
     监听的是kCFRunLoopDefaultMode即默认状态
     也可以使用kCFRunLoopCommonModes，同时监听默认状态以及滑动视图的状态
     */
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    //CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopCommonModes);
    
    //Core Foundation需要手动释放observer
    CFRelease(observer);
    
//    //添加一个textView，它是UIScrollView的子类
//    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 300)];
//    textView.text = @"Hello, World";
//    [textView setBackgroundColor:[UIColor redColor]];
//    [self.view addSubview:textView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
