//
//  UIViewController+ActionButton.m
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/20.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import "UIViewController+ActionButton.h"

@implementation UIViewController (ActionButton)

- (void)loadActionButton{
    CGFloat width = 80;
    CGFloat height = 40;
    CGFloat margin = 5;
    


            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            CGFloat xPoint = 2 * (width + margin);
            CGFloat yPoint = 2 * (height + margin);
            button.frame = CGRectMake(xPoint, yPoint, width, height);
            [button addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
            button.backgroundColor = [UIColor grayColor];
            button.titleLabel.adjustsFontSizeToFitWidth = YES;
            button.titleLabel.textColor = [UIColor whiteColor];
            [button setTitle:@"返回" forState:UIControlStateNormal];
            [self.view addSubview:button];

}

- (void)touch:(id)sender{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
