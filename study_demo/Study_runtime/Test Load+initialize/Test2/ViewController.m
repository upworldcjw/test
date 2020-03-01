//
//  ViewController.m
//  Test2
//
//  Created by JianweiChenJianwei on 2016/12/7.
//  Copyright © 2016年 UL. All rights reserved.
//

#import "ViewController.h"

@interface Father  : NSObject

@end

@implementation Father

+ (void)load{
    NSLog(@"Father load");
}

+ (void)initialize{
    NSLog(@"Father initialize");
}
- (void)test{
    
}
@end

@interface Son  :  Father

@end

@implementation Son

+ (void)load{
    NSLog(@"Son load");
}

+ (void)initialize{
    NSLog(@"Son initialize");
}

- (void)test{
    
}

@end


@interface ViewController ()

@end

@implementation ViewController

+ (void)load{
    NSLog(@"ViewController load");
    [self test];
}

+ (void)initialize{
    NSLog(@"ViewController init");
}

+ (void)test{
    NSLog(@"ViewController test");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[Father new] test];
    [[Son new] test];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

@interface ViewController (inner1)

@end

@implementation ViewController(inner1)
+(void)load{
    NSLog(@"load (inner1)");
}
@end

@interface ViewController (inner2)

@end

@implementation ViewController(inner2)
+(void)load{
    NSLog(@"load (inner2)");
}
@end
