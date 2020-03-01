//
//  ViewControllerA.m
//  TestNavi
//
//  Created by jianwei.chen on 15/11/12.
//  Copyright © 2015年 jianwei.chen. All rights reserved.
//

#import "Nav2ViewController.h"

@interface Nav2ViewController ()

@end

@implementation Nav2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)push{
    
    NSInteger i = [self.navigationController.viewControllers count];
    NSString *title = [NSString stringWithFormat:@"second Navi leavel %d",i];
    BaseViewController *baseVC =[[BaseViewController alloc] initWithTitle:title];
    [self.navigationController pushViewController:baseVC animated:YES];
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
