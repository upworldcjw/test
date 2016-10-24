//
//  ViewControllerShip.m
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/20.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import "ViewControllerShip.h"
#import "UIViewController+ActionButton.h"
#import "ULAnimationShipView.h"

@interface ViewControllerShip ()

@end

@implementation ViewControllerShip

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    [scrollView setContentSize:CGSizeMake(3*self.view.frame.size.width, self.view.frame.size.height)];
    

    ULAnimationShipView *shipView = [[ULAnimationShipView alloc] initWithImageName:@"ship"];
    
//    CGFloat height = [ULAnimationShipView properHeght];
//    shipView.backgroundColor = [UIColor redColor];
    [scrollView addSubview:shipView];
    [shipView performSelector:@selector(animation) withObject:nil afterDelay:1];
    
    [self loadActionButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
