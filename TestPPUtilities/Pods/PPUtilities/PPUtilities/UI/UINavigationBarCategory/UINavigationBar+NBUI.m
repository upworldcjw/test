//
//  UINavigationBar+NBUI.m
//  pengpeng
//
//  Created by 巩鹏军 on 14/11/5.
//  Copyright (c) 2014年 AsiaInnovations. All rights reserved.
//

#import "UINavigationBar+NBUI.h"
#import <objc/runtime.h>
// reference: http://www.appcoda.com/customize-navigation-status-bar-ios-7/

@implementation UINavigationBar (NBUI)
@dynamic navBarTranslucent;

-(BOOL)navBarTranslucent{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

-(void)setNavBarTranslucent:(BOOL)navBarTranslucent{
    objc_setAssociatedObject(self, @selector(navBarTranslucent), @(navBarTranslucent), OBJC_ASSOCIATION_RETAIN);
    
    if (![self navBarTranslucent]) {
//        [self fixNaviBarColorShift];
        [self setBackgroundImage:[UIImage imageNamed:@"nav_bg_320_64"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }else{
        [self setBackgroundImage:[UIImage imageNamed:@"chatNavi_bg"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
}

//+ (void)configAppearance;
//{
//    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
//    [[UINavigationBar appearance] setTintColor:DEFAULT_MAINBODY_COLOR];
//}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    if (newWindow != nil) {//
        if (![self navBarTranslucent]) {
//            [self fixNaviBarColorShift];
            [self setBackgroundImage:[UIImage imageNamed:@"nav_bg_320_64"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        }else{
            [self setBackgroundImage:[UIImage imageNamed:@"chatNavi_bg"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        }
    }

    [super willMoveToWindow:newWindow];
}

- (void)fixNaviBarColorShift
{
    self.translucent = NO;
}

@end
