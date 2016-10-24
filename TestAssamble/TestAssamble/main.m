//
//  main.m
//  TestAssamble
//
//  Created by jianwei on 9/20/16.
//  Copyright © 2016 jianwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

__attribute__((noinline))
int addFunction(int a, int b) {
    int c = a + b;
    return c;
}

void fooFunction() {
    int add = addFunction(12, 34);
    printf("add = %i", add);
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
