//
//  ViewControllerShip.m
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/20.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import "ViewControllerTower.h"
#import "UIViewController+ActionButton.h"
#import "ULAnimationTowerView.h"

@interface ViewControllerTower ()

@end

@implementation ViewControllerTower

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadActionButton];
    self.view.backgroundColor = [UIColor grayColor];
    
//    CGRect frame = self.view.bounds;
//    frame.size.height = frame.size.height - 100;
    ULAnimationTowerView *fireView = [[ULAnimationTowerView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:fireView];
    
    [fireView performSelector:@selector(animation) withObject:nil afterDelay:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
