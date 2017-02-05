//
//  ViewController.m
//  TestSKReviewController
//
//  Created by JianweiChenJianwei on 2017/2/4.
//  Copyright © 2017年 UL. All rights reserved.
//

#import "ViewController.h"
@import StoreKit;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(20, 100, 40, 60);
    [self.view addSubview:but];
    but.backgroundColor = [UIColor redColor];
    [but addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view, typically from a nib.

//    NSURL *url = [NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/jie-zou-da-shi/id493901993?mt=8&action=write-review"];
//    
//    url = [NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/jie-zou-da-shi/id493901993?mt=8"];
//    [[UIApplication sharedApplication] openURL:url];

//    [[UIApplication sharedApplication] openURL:url options:nil completionHandler:NULL];
//    [[UIApplication sharedApplication] openURL:url];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
}

-(void)test{
    NSLog(@"touch");
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }else{
        [SKStoreReviewController requestReview];
//        [self performSelector:@selector(present) withObject:nil afterDelay:10];
    }
}

- (void)present{
    ViewController *vc =[[ViewController alloc] init];
    vc.view.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.5];
    [self presentViewController:vc animated:NO completion:NULL];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
