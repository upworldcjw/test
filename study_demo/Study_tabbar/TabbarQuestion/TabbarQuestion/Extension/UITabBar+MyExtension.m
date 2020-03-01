//
//  UITabBar+MyExtension.m
//  TabbarQuestion
//
//  Created by JianweiChen on 2018/8/3.
//  Copyright © 2018 inke. All rights reserved.
//

#import "UITabBar+MyExtension.h"
#import <objc/runtime.h>

static void *sPreSuperView = &sPreSuperView;

@interface UITabBar (MyExtensionInner)

@property (nonatomic, strong) UIView *preSuperView;

@end

@implementation UITabBar (MyExtension)

- (void)setPreSuperView:(UIView *)preSuperView{
    objc_setAssociatedObject(self, sPreSuperView, preSuperView, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)preSuperView{
    return objc_getAssociatedObject(self, sPreSuperView);
}

- (void)forceShow{
    self.hidden = NO;
    //下面方法能解决 popToRootViewControllerAnimation:YES, 然后selecteTab 造成白屏问题
    //不可以恢复，不在window上了
    if (self.window) {
        if (self.preSuperView == nil) {
            self.preSuperView = self.superview;
        }
    }else{
        if (self.preSuperView.window) {
            [self.preSuperView addSubview:self];
        }
    }
    //下面解决交互手势，半路取消造成tabbar 白屏问题
    //交互白屏是因为actionForLayer:forKey: 重写event的position事件
    CGRect newFrame = self.frame;
    if (newFrame.origin.x != 0) {
        newFrame.origin.x = 0;
        self.frame = newFrame;
    }
}

@end

