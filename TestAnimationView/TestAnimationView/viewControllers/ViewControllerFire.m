//
//  ViewControllerShip.m
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/20.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import "ViewControllerFire.h"
#import "UIViewController+ActionButton.h"
#import "ULAnimationFireView.h"
@interface ViewControllerFire ()

@end

@implementation ViewControllerFire

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadActionButton];
    self.view.backgroundColor = [UIColor grayColor];
    
    CGRect frame = self.view.bounds;
    frame.size.height = frame.size.height - 100;
    ULAnimationFireView *fireView = [[ULAnimationFireView alloc] initWithFrame:frame];
    [self.view addSubview:fireView];
    


    
    [fireView performSelector:@selector(animation) withObject:nil afterDelay:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
