//
//  CustomTableViewController.m
//  TabbarQuestion
//
//  Created by JianweiChen on 2018/8/3.
//  Copyright © 2018 inke. All rights reserved.
//

#import "CustomTableViewController.h"
#import "PublicHeader.h"

@interface CustomTableViewController ()

@end

@implementation CustomTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTab) name:kChangeTabKey object:nil];
}

- (void)changeTab{
    [self.selectedViewController popToRootViewControllerAnimated:YES];
    if (self.selectedIndex == 0) {
        [self setSelectedIndex:1];
    }else{
        [self setSelectedIndex:0];
    }
}

@end
