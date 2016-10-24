//
//  ViewControllerCar.m
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/20.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import "ViewControllerCar.h"
#import "UIViewController+ActionButton.h"
#import "ULAnimationCarView.h"
@interface ViewControllerCar ()

@end

@implementation ViewControllerCar

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    CGRect frame = self.view.bounds;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    [self.view addSubview:scrollView];
    [scrollView setContentSize:CGSizeMake(3*self.view.frame.size.width, self.view.frame.size.height)];
    
    ULAnimationCarView *car = [[ULAnimationCarView alloc] initWithImageName:@"保时捷.gif"];
    [car performSelector:@selector(animation) withObject:nil afterDelay:1];
    
    [scrollView addSubview:car];
    
    [self loadActionButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
