//
//  ViewController.m
//  TestRefrence
//
//  Created by jianwei.chen on 15/9/16.
//  Copyright (c) 2015年 jianwei.chen. All rights reserved.
//

#import "ViewController.h"

//知识点一：User Header Map
//引用错误 工程没有引用工程文件
//如果 User Header Map == NO,下面编译不过。只有 User Header Map == YES 才能编译过
//#import "Person.h"
#import "TestOuter/Person.h"

//知识点二：工程不引用头文件，只引用.m文件不影响编译
//支持引用方式一,不需要xcode做任何配置。只需要引入工程文件路劲
//注意工程没有引入TestClassA.h
#import "ViewController/TestClassA.h"

//知识点三：配置Header search path，需要用<>引用
//需要配置Header search path = $(SRCROOT)/TestRefrence
#include <ViewController/TestClassA.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    TestClassA *a = [[TestClassA alloc] initWithTest:@""];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
