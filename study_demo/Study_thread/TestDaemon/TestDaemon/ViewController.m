//
//  ViewController.m
//  TestDaemon
//
//  Created by JianweiChen on 2020/2/24.
//  Copyright © 2020 inke. All rights reserved.
//

#import "ViewController.h"
#import "IKTestThread.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [IKTestThread test];
}


@end
