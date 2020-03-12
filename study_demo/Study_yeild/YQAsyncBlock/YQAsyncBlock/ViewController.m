//
//  ViewController.m
//  YQAsyncBlock
//
//  Created by Yaqiang Wang on 2018/11/19.
//  Copyright © 2018 Yaqiang Wang. All rights reserved.
//

#import "ViewController.h"
#import "YQAsyncBlock.h"

#include <setjmp.h>
@interface ViewController ()

@end

@implementation ViewController
jmp_buf buf;
- (void)viewDidLoad {

    [super viewDidLoad];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self test];
//    });
    
//    
//    NSMethodSignature *a = [ViewController instanceMethodSignatureForSelector:@selector(test:)];
//    NSMethodSignature *b = [ViewController instanceMethodSignatureForSelector:@selector(test1:)];
//    NSMethodSignature *c = [ViewController instanceMethodSignatureForSelector:@selector(test2)];
//    NSMethodSignature *d = [ViewController methodSignatureForSelector:@selector(test3)];
//    NSLog(@"====%@",a);
//    NSLog(@"=====%@",b);
//    NSInvocation *invok = [NSInvocation invocationWithMethodSignature:a];
//    NSString *arg = @"111";
//    [invok setArgument:&arg atIndex:2];
//    [invok retainArguments];
//    [invok setTarget:self];
//    [invok setSelector:@selector(test:)];
//    [invok invoke];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(YQAsyncClosure)test1{
    return ^(YQAsyncCallback callback){
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,2 * NSEC_PER_SEC), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //处理成功
            callback(@"1", nil);
        });
    };
}

-(YQAsyncClosure)test2{
    return ^(YQAsyncCallback callback){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //处理成功
            callback(@"2", nil);
        });
    };
}

-(void)test{

    yq_async(^{
       YQResult *result =yq_await([self test1]);
        NSLog(@"%@",result.value);
        result =yq_await([self test2]);
        NSLog(@"%@",result.value);
        NSLog(@"3");
        yq_async(^{
            
        });
         
    });
    
    NSLog(@"0");
//    yq_async(^{
//        YQResult *result =yq_await([self test1]);
//        NSLog(@"%@",result.value);
//        result =yq_await([self test2]);
//        NSLog(@"%@",result.value);
//        NSLog(@"3");
//    });
//    NSLog(@"00");
//    yq_async(^{
//        YQResult *result =yq_await([self test1]);
//        NSLog(@"%@",result.value);
//        result =yq_await([self test2]);
//        NSLog(@"%@",result.value);
//        NSLog(@"3");
//    });
//    NSLog(@"00");
//    yq_async(^{
//        YQResult *result =yq_await([self test1]);
//        NSLog(@"%@",result.value);
//        result =yq_await([self test2]);
//        NSLog(@"%@",result.value);
//        NSLog(@"3");
//    });
//    NSLog(@"00");
//    yq_async(^{
//        YQResult *result =yq_await([self test1]);
//        NSLog(@"%@",result.value);
//        result =yq_await([self test2]);
//        NSLog(@"%@",result.value);
//        NSLog(@"3");
//    });
//    NSLog(@"00");
//    yq_async(^{
//        YQResult *result =yq_await([self test1]);
//        NSLog(@"%@",result.value);
//        result =yq_await([self test2]);
//        NSLog(@"%@",result.value);
//        NSLog(@"3");
//    });
//    NSLog(@"00");
//    yq_async(^{
//        YQResult *result =yq_await([self test1]);
//        NSLog(@"%@",result.value);
//        result =yq_await([self test2]);
//        NSLog(@"%@",result.value);
//        NSLog(@"3");
//    });
//    NSLog(@"00");
//    yq_async(^{
//        YQResult *result =yq_await([self test1]);
//        NSLog(@"%@",result.value);
//        result =yq_await([self test2]);
//        NSLog(@"%@",result.value);
//        NSLog(@"3");
//    });
//    NSLog(@"00");
}
- (IBAction)btnClick:(id)sender{
    NSLog(@"=======点击");
}
+(void)test3{
    
}
@end
