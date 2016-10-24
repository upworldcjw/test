//
//  ViewControllerShip.m
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/20.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import "ViewControllerPlane.h"
#import "UIViewController+ActionButton.h"
#import "ULAnimationPlaneView.h"
@interface ViewControllerPlane ()

@end

@implementation ViewControllerPlane

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect frame = self.view.bounds;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    [self.view addSubview:scrollView];
    [scrollView setContentSize:CGSizeMake(3*self.view.frame.size.width, self.view.frame.size.height)];
    
    ULAnimationPlaneView *plane = [[ULAnimationPlaneView alloc] initWithImageName:@"bomber.gif"];
//    [self.view addSubview:plane];
    [scrollView addSubview:plane];
    [plane performSelector:@selector(animation) withObject:nil afterDelay:1];
    
    [self loadActionButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
