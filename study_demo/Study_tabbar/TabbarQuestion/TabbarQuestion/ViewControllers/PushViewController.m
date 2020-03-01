//
//  PushViewController.m
//  TabbarQuestion
//
//  Created by JianweiChen on 2018/8/3.
//  Copyright © 2018 inke. All rights reserved.
//

#import "PushViewController.h"
#import "PublicHeader.h"

@interface PushViewController ()

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"push" style:UIBarButtonItemStylePlain target:self action:@selector(push)];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"pop" style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    
    self.title = @(self.navigationController.viewControllers.count).description;
}

- (void)push{
    PushViewController *push = [[PushViewController alloc] init];
    [self.navigationController pushViewController:push animated:YES];
}

- (void)pop{
//    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kChangeTabKey object:nil];
}

@end
