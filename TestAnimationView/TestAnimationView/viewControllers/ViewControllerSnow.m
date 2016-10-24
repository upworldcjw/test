//
//  ViewControllerSnow.m
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/20.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import "ViewControllerSnow.h"
#import "UIViewController+ActionButton.h"
#import "ULAnimationStarFall.h"
@interface ViewControllerSnow ()

@end

@implementation ViewControllerSnow

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadActionButton];
    self.view.backgroundColor = [UIColor whiteColor];
    
    ULAnimationStarFall *starFail = [[ULAnimationStarFall alloc] initWithView:self.view];
    [starFail makeStarFall];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
