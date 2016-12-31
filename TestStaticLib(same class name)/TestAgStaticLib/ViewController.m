//
//  ViewController.m
//  TestAgStaticLib
//
//  Created by jianwei on 10/19/16.
//  Copyright © 2016 jianwei. All rights reserved.
//

#import "ViewController.h"
#import "TestStaticLib/TestStaticLib.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[TestStaticLib alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
