//
//  SecondViewController.m
//  TabbarQuestion
//
//  Created by JianweiChen on 2018/8/3.
//  Copyright © 2018 inke. All rights reserved.
//

#import "SecondViewController.h"
#import "UITabBar+MyExtension.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tabBarController.tabBar forceShow];
}



@end
