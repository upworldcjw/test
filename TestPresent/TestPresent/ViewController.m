//
//  ViewController.m
//  TestPresent
//
//  Created by JianweiChen on 2018/2/12.
//  Copyright © 2018年 inke. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerA.h"
#import "ViewControllerC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view, typically from a nib.
    
//    ViewControllerA *va = [ViewControllerA new];
//    UIViewController *nav = [UINavigationController new];
//    [self addChildViewController:nav];
//    [self.view addSubview:nav.view];
//    [nav addChildViewController:va];
//    [va didMoveToParentViewController:self];
    
//    ViewControllerA *va = [ViewControllerA new];
//    UIViewController *nav = [UINavigationController new];
//    [self addChildViewController:nav];
//    [self.view addSubview:nav.view];
//    [nav addChildViewController:va];
//    [va didMoveToParentViewController:nav];
    
//    ViewControllerA *va = [ViewControllerA new];
//    UIViewController *nav = [[UINavigationController alloc] initWithRootViewController:va];
//    [self addChildViewController:nav];
//    [self.view addSubview:nav.view];
//    [nav addChildViewController:va];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ViewControllerA *va = [ViewControllerA new];
        UIViewController *nav = [[UINavigationController alloc] initWithRootViewController:va];
        [self presentViewController:nav animated:NO completion:^{
            NSLog(@"completion");
        }];
//        self.presentingViewController = nav;
//        NSLog(@"end");
    });

//    [self addChildViewController:nav];
//    [self.view addSubview:nav.view];
//    [nav addChildViewController:va];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
