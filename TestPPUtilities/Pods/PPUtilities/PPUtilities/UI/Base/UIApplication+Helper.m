//
//  UIApplication+Helper.m
//  pengpeng
//
//  Created by 巩鹏军 on 15/1/20.
//  Copyright (c) 2015年 AsiaInnovations. All rights reserved.
//

#import "UIApplication+Helper.h"
@implementation UIApplication (Helper)

- (UIWindow*)topWindow;
{
    //comment the following,for return not wanted window,such as uitextfieldWindow...
//    UIWindow *keyboardWindow = nil;
//    for (UIWindow *testWindow in [UIApplication sharedApplication].windows) {
//        if (![[testWindow class] isEqual:[UIWindow class]]) {
//            keyboardWindow = testWindow;
//            return keyboardWindow;
//        }
//    }
    
    UIWindow *topWindow =[UIApplication sharedApplication].keyWindow;
    if (topWindow == nil) {
        topWindow = [[[UIApplication sharedApplication] delegate] window];
    }
    return topWindow;
}
@end
