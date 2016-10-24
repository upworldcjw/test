//
//  ViewController.m
//  TestChain
//
//  Created by jianwei.chen on 15/8/24.
//  Copyright (c) 2015年 jianwei.chen. All rights reserved.
//

#import "ViewController.h"
#import "ViewA.h"
#import "ViewB.h"
#import "ViewC.h"
#import "ViewE.h"
#import "ViewF.h"
#import "ButtonA.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ViewA *viewA = [[ViewA alloc] initWithFrame:CGRectMake(0, 0, 400, 400)];
    [self.view addSubview:viewA];
    [viewA setBackgroundColor:[UIColor grayColor]];
    
    ViewB *viewB = [[ViewB alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [viewA addSubview:viewB];
    [viewB setBackgroundColor:[UIColor orangeColor]];
    
    ViewC *viewc = [[ViewC alloc] initWithFrame:CGRectMake(0, 150, 200, 200)];
    [viewA addSubview:viewc];
    [viewc setBackgroundColor:[UIColor purpleColor]];
    
    ViewE *viewe= [[ViewE alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [viewc addSubview:viewe];
    [viewe setBackgroundColor:[UIColor grayColor]];
    
    ViewF *viewf = [[ViewF alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    [viewc addSubview:viewf];
    [viewf setBackgroundColor:[UIColor orangeColor]];
    
    ButtonA *buttonA= [ButtonA buttonWithType:UIButtonTypeCustom];
    [viewf addSubview:buttonA];
    [buttonA setFrame:CGRectInset(viewf.bounds, 25, 25)];
    [buttonA setBackgroundColor:[UIColor greenColor]];
    [buttonA setTouchInset:UIEdgeInsetsMake(-25, -25, -25, -25)];
    [buttonA addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
}


-(void)test{
    NSLog(@"%@ %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
