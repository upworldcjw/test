//
//  UITabBar+IKFadeAnimation.m
//  inke
//
//  Created by Vincent Yu on 2018/6/12.
//  Copyright © 2018年 MeeLive. All rights reserved.
//

#import "UITabBar+IKFadeAnimation.h"
#import <objc/runtime.h>

static void *sPreSuperView = &sPreSuperView;
@interface UITabBar (IKFadeAnimation_Inner)

@property (nonatomic, strong) UIView *preSuperView;

@end


@implementation UITabBar (IKFadeAnimation)

-(id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event{
    if ([event isEqualToString:@"position"]) {
        if(layer.position.x<0){
            //show tabbar
            CATransition *pushFromTop = [[CATransition alloc] init];
            pushFromTop.duration = 0.25;
            pushFromTop.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            pushFromTop.type = kCATransitionFade;
            pushFromTop.subtype = kCATransitionFromTop;
            return pushFromTop;
        }else if (layer.position.x>0&&(layer.position.y>layer.bounds.size.height)&&(layer.position.y<[UIScreen mainScreen].bounds.size.height)){
            //hide tabbar
            CATransition *pushFromBottom = [[CATransition alloc] init];
            pushFromBottom.duration = 0.25;
            pushFromBottom.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            pushFromBottom.type = kCATransitionFade;
            pushFromBottom.subtype = kCATransitionFromBottom;
            return pushFromBottom;
        }
    }
    return (id<CAAction>)[NSNull null];
}

-(void)runActionForKey:(NSString *)event object:(id)anObject arguments:(NSDictionary *)dict{
    
}


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
