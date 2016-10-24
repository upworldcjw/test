//
//  ViewController.m
//  UsedDylibTest
//
//  Created by jianwei on 9/29/16.
//  Copyright © 2016 jianwei. All rights reserved.
//

#import "ViewController.h"
#import <dlfcn.h>
#import <mach-o/dyld.h>
#import "Person.h"
#import <DylibTest/Manager.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self onDlopenLoadAtPathAction1:nil];
    
    [Manager test];
    
    Person *person = [[Person alloc] init];
//    person.name = @"hello";
    [person printName];
    
    
    Class rootClass = NSClassFromString(@"Person");
    if (rootClass) {
        id object = [[rootClass alloc] init];
        
        [object performSelector:@selector(printName)];
        [object performSelector:NSSelectorFromString(@"printName")];
    }
}

- (void)onDlopenLoadAtPathAction1:(id)sender
{
    //TODO:把工程目录下的动态库DylibTest，放到app的Documents目录下。
    //要不然没法加载动态库
    NSString *documentsPath = [NSString stringWithFormat:@"%@/Documents/DylibTest.framework/DylibTest",NSHomeDirectory()];
//    NSString *path = @"/Users/jianwei/Desktop/DylibTest.framework/DylibTest";
//    [self dlopenLoadDylibWithPath:documentsPath];
    
    documentsPath = [NSString stringWithFormat:@"%@/Documents/DylibTest.framework",NSHomeDirectory()];
    [self bundleLoadDylibWithPath:documentsPath];
}

- (void)dlopenLoadDylibWithPath:(NSString *)path
{
    void *libHandle = NULL;
    libHandle = dlopen([path cStringUsingEncoding:NSUTF8StringEncoding], RTLD_NOW);
    if (libHandle == NULL) {
        char *error = dlerror();
        NSLog(@"dlopen error: %s", error);
    } else {
        NSLog(@"dlopen load framework success.");
    }
}

- (void)bundleLoadDylibWithPath:(NSString *)path
{
    NSError *err = nil;
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    if ([bundle loadAndReturnError:&err]) {
        NSLog(@"bundle load framework success.");
    } else {
        NSLog(@"bundle load framework err:%@",err);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
