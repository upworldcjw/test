//
//  ViewController.m
//  TestWeb
//
//  Created by JianweiChen on 2017/7/13.
//  Copyright © 2017年 IK. All rights reserved.
//

#import "ViewController.h"
#import "UITestCollectionViewController.h"
#import <WeexSDK/WeexSDK.h>
#import <WeexSDK/WXSDKInstance.h>
#import <IKUIKit/IKUIKit.h>
@import WebKit;

@interface ViewController ()<UIScrollViewDelegate>{
    UITableView *tableView;
    WXSDKInstance *_instance;
    
}
@property (nonatomic, strong) UIView *weexView;
@property (nonatomic, strong) NSURL *url;
@end

@implementation ViewController

- (void)dealloc{
    [_instance destroyInstance];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(100, 40, 40, 40);
    but.backgroundColor = [UIColor redColor];
    [but setTitle:self.title forState:UIControlStateNormal];
    [self.view addSubview:but];
    [but addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
//
//    WKWebView * webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 100)];
//    webView.backgroundColor = [UIColor clearColor];
//    //    webView.navigationDelegate = self;
//    [self.view addSubview:webView];
//    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
//    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
//    tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:tableView];
//    
//    tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
//    tableView.backgroundColor = [UIColor redColor];
//    
//    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
//    but.frame = CGRectMake(0, 0, 40, 40);
//    but.backgroundColor = [UIColor blueColor];
//    [tableView addSubview:but];
//    [but addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
//    tableView.delegate = self;
//    
//    _instance = [[WXSDKInstance alloc] init];
//    _instance.viewController = self;
//    _instance.frame = self.view.frame;
//    __weak typeof(self) weakSelf = self;
//    _instance.onCreate = ^(UIView *view) {
//        [weakSelf.weexView removeFromSuperview];
//        weakSelf.weexView = view;
//        [weakSelf.view addSubview:weakSelf.weexView];
//    };
//    _instance.onFailed = ^(NSError *error) {
//        //process failure
//    };
//    _instance.renderFinish = ^ (UIView *view) {
//        //process renderFinish
//    };
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"js"];
//    [_instance renderWithURL:url options:@{@"bundleUrl":[self.url absoluteString]} data:nil];
}

- (void)test:(id)sender{
    ViewController *vc = [[ViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    vc.title = @"2";
//    vc.modalPresentationStyle 
    [self.navigationController presentViewController:vc animated:YES completion:NULL];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ViewController *vc2 = [[ViewController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        vc2.title = @"3";
        [self.navigationController presentViewController:vc2 animated:YES completion:NULL];
    });
    
//        [IKUIDynamicEffect showEffectMessage:@"testtesttesttesttesttesttesttesttesttesttest" startY:40 inView:self.view];
//    
//        __weak typeof(self) weakSelf = self;
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//        
//        UIAlertAction *actionAll = [UIAlertAction actionWithTitle:@"all" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
//        }];
//        
//        UIAlertAction *actionGirl = [UIAlertAction actionWithTitle:@"girl" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
//        }];
//        
//        UIAlertAction *actionBoy = [UIAlertAction actionWithTitle:@"boy" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
//        }];
//        
//        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        }];
//        
//        [alert addAction:actionAll];
//        [alert addAction:actionGirl];
//        [alert addAction:actionBoy];
//        [alert addAction:actionCancel];
//        [alert setTextFont:[UIFont systemFontOfSize:16] textColor:[UIColor redColor]];
////        [alert setTextColor:[UIColor blueColor]];
////        [actionGirl setTextColor:[UIColor greenColor]];
////        [actionBoy setTextColor:[UIColor colorWithRed:0.333 green:0.518 blue:0.984 alpha:1.0]];
////        [actionCancel setTextColor:[UIColor grayColor]];
//        [self presentViewController:alert animated:NO completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.y);
}



- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [tableView setContentOffset:CGPointMake(0, -40)];
}

//- (void)test:(id)sender{
//    [self test:<#(id)#>];
//    UITestCollectionViewController *vc = [[UITestCollectionViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
//    [self presentViewController:vc animated:NO completion:NULL];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
