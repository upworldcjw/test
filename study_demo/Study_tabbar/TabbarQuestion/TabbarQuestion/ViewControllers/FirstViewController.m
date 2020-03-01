//
//  FirstViewController.m
//  TabbarQuestion
//
//  Created by JianweiChen on 2018/8/3.
//  Copyright © 2018 inke. All rights reserved.
//

#import "FirstViewController.h"
#import "PushViewController.h"
#import "PushViewController.h"
#import "UITabBar+MyExtension.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"push" style:UIBarButtonItemStylePlain target:self action:@selector(push)];
    
    
//    UIVisualEffect *blurEffect;
//    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//
//    UIVisualEffectView *visualEffectView;
//    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test.png"]];
//    imageView.frame = [UIScreen mainScreen].bounds;
//    visualEffectView.frame = imageView.bounds;
//    [imageView addSubview:visualEffectView];
//    [self.view addSubview:imageView];
    
    
//    UIBlurEffect *blurEffect;
//    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//
//    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
//
//    UIVisualEffectView *visualEffectView;
//    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
//
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test.png"]];
//    imageView.frame = [UIScreen mainScreen].bounds;
//    visualEffectView.frame = imageView.bounds;
//    [imageView addSubview:visualEffectView];
//    [self.view addSubview:imageView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test.png"]];
    imageView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:imageView];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    for (UIView *view in blurEffectView.subviews) {
        if (![view isKindOfClass:NSClassFromString(@"_UIVisualEffectBackdropView")]) {
            view.alpha = 0.8;
        }
    }
//    UIView  *testVeiw = [[UIView alloc] initWithFrame:self.view.bounds];
//    testVeiw.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
//    [blurEffectView.contentView addSubview:testVeiw];
//    blurEffectView.contentView.backgroundColor = [UIColor clearColor];
    blurEffectView.frame = self.view.bounds;
    [self.view addSubview:blurEffectView];
    
//    // Vibrancy effect 生动效果
//    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
//    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
//    vibrancyEffectView.frame = self.view.bounds;
//    [blurEffectView.contentView addSubview:vibrancyEffectView];
//    [imageView addSubview:blurEffectView];
}

- (void)push{
    PushViewController *push = [[PushViewController alloc] init];
    push.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:push animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tabBarController.tabBar forceShow];
}

@end
