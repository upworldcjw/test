//
//  BaseViewController.m
//  TestNavi
//
//  Created by jianwei.chen on 15/11/12.
//  Copyright © 2015年 jianwei.chen. All rights reserved.
//

#import "BaseViewController.h"
#import "Nav2ViewController.h"
@interface BaseViewController ()
@end

@implementation BaseViewController

-(void)dealloc{
    NSLog(@"dealloc %@ %@",NSStringFromClass([self class]),self.title);
}

-(instancetype)initWithTitle:(NSString *)title{
    if (self = [super init]) {
        self.title = title;
        NSLog(@"init %@ %@",NSStringFromClass([self class]),title);
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(push)];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:but];
    [but addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [but setFrame:CGRectMake(0, 0, 100, 100)];
    [but setBackgroundColor:[UIColor redColor]];
}

-(void)test{
    NSString *title = [NSString stringWithFormat:@"second Navi leavel %d",0];
    Nav2ViewController *viewController = [[Nav2ViewController alloc] initWithTitle:title];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    [UIApplication sharedApplication].keyWindow.rootViewController = nav;
}

-(void)push{
    
    NSInteger i = [self.navigationController.viewControllers count];
    NSString *title = [NSString stringWithFormat:@"first Navi leavel %d",i];
    BaseViewController *baseVC =[[BaseViewController alloc] initWithTitle:title];
    [self.navigationController pushViewController:baseVC animated:YES];
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
