//
//  UIViewController+InteractivePop.m
//  pengpeng
//
//  Created by jianwei.chen on 15/11/27.
//  Copyright © 2015年 AsiaInnovations. All rights reserved.
//

#import "UIViewController+InteractivePop.h"
#import <JRSwizzle/JRSwizzle.h>
@implementation UIViewController (InteractivePop)

+(void)load{
    [self jr_swizzleMethod:@selector(viewWillAppear:) withMethod:@selector(interactivePop_viewWillAppear:) error:nil];
}

-(void)interactivePop_viewWillAppear:(BOOL)animation{
    if (![self isKindOfClass:[UINavigationController class]]) {
//        if(self.navigationController.viewControllers.)
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    [self interactivePop_viewWillAppear:animation];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    if (![self isKindOfClass:[UINavigationController class]]) {
        if (self.navigationController.viewControllers.count == 1){//关闭主界面的右滑返回
            return NO;
        }else{
            return YES;
        }
//    }
//    return NO;
}
@end
