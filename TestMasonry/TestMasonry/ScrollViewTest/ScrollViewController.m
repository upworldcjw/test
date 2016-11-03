//
//  ScrollViewControllerTestViewController.m
//  TestMasonry
//
//  Created by jianwei on 11/1/16.
//  Copyright © 2016 jianwei. All rights reserved.
//

#import "ScrollViewController.h"
#import <Masonry/Masonry.h>
@interface ScrollViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView * testView;
@property (nonatomic, strong) UIButton * testButton;

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ScrollView";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [UIScrollView new];
    self.scrollView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.scrollView];
    
    self.containerView = [UIView new];
    self.containerView.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:.5];
    
    self.testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.testButton.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:.5];
    
    self.testView = [UIView new];
    self.testView.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:.5];
    
    [self.scrollView addSubview:self.containerView];
    [self.containerView addSubview:self.testButton];
    [self.containerView addSubview:self.testView];
    // 设置约束
    [self setupConstraints];
}

- (void)setupConstraints {
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {

//        make.width.equalTo(self.scrollView);
        make.top.equalTo(self.scrollView);
        make.left.equalTo(self.scrollView);
        make.right.equalTo(self.scrollView);
//        make.right.left.equalTo(self.scrollView);
    }];
    
    [self.testButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView).offset(100);
        make.left.equalTo(self.containerView).offset(50);
        make.right.equalTo(self.containerView).offset(-50);
        make.height.equalTo(@40);
    }];
    
    [self.testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.testButton.mas_bottom).offset(200);
        make.left.right.equalTo(self.containerView);
        make.height.equalTo(@400);
        make.bottom.equalTo(self.containerView);
    }];
}

- (void)testButtonClick {
    [self setupConstraints];
}

@end
