//
//  ViewController.m
//  Test
//
//  Created by JianweiChen on 2017/6/14.
//  Copyright © 2017年 IK. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view];
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.fromValue = [NSNumber numberWithFloat: 100];
    animation.toValue = [NSNumber numberWithFloat:200];
    animation.duration = 3;//pString.length/0.5;
    animation.removedOnCompletion = NO;
    animation.repeatCount = 1000;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [view.layer addAnimation:animation forKey:@"position.y" ];
    
//    [UIView animateWithDuration:1.2 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveLinear animations:^{
//        view.frame = CGRectMake(0, 200, 100, 100);
//    } completion:^(BOOL finished) {
//        
//    }];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:but];
    [but addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    but.backgroundColor = [UIColor redColor];
    [but setFrame:CGRectMake(10, 64, 40, 40)];;
}

- (void)test{
    ViewController *viewC = [ViewController new];
    viewC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(test2)];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewC];
    [self presentViewController:nav animated:YES completion:NULL];
}

- (void)test2{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
