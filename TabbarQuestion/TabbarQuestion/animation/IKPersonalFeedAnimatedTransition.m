//
//  IKPersonalFeedAnimatedTransition.m
//  inke
//
//  Created by JianweiChen on 2018/7/5.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import "IKPersonalFeedAnimatedTransition.h"
#import "IKTLPersonalFeedViewController.h"
#import "PublicHeader.h"

@interface IKPersonalFeedAnimatedTransition ()

@end

@implementation IKPersonalFeedAnimatedTransition

+ (instancetype)transitionWithType:(XWPageCoverTransitionType)type{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(XWPageCoverTransitionType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}
/**
 *  动画时长
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}

/**
 *  如何执行过渡动画
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_type) {
        case XWPageCoverTransitionTypePush:
            [self doPushAnimation:transitionContext];
            break;
            
        case XWPageCoverTransitionTypePop:
            [self doPopAnimation:transitionContext];
            break;
    }
}

/**
 *  执行push过渡动画
 */
- (void)doPushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    CGFloat alpha = 0.6;
    if ([toVC isKindOfClass:[IKTLPersonalFeedViewController class]]) {
        alpha = [(IKTLPersonalFeedViewController *)toVC bgAlpha];
    }
    UIView *tmpView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    tmpView.backgroundColor = [IKHexColor(0x000000, 1) colorWithAlphaComponent:alpha];
    [containerView addSubview:tmpView];
    tmpView.alpha = 0;
    
    [containerView addSubview:toVC.view];
    toVC.view.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        tmpView.alpha = 1;
//        NSLog(@"cjw cjw begin aimain");
    } completion:^(BOOL finished) {
//        NSLog(@"cjw cjw end aimain");
        [tmpView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            if (self.animatedTransitionEnd) {
                self.animatedTransitionEnd(NO);
            }
        }else{
            if (self.animatedTransitionEnd) {
                self.animatedTransitionEnd(YES);
            }
        }
    }];
}

/**
 *  执行pop过渡动画
 */
- (void)doPopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    BOOL isTabBarRoomVC = NO;
    if (toVC.navigationController.viewControllers.firstObject == toVC && [toVC.tabBarController.viewControllers containsObject:toVC.navigationController]) {
        isTabBarRoomVC = YES;
    }
    if (isTabBarRoomVC) {
        toVC.tabBarController.tabBar.hidden = YES;
    }
    [containerView addSubview:toVC.view];
    UIView *tmpView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    CGFloat alpha = 0.6;
    if ([fromVC isKindOfClass:[IKTLPersonalFeedViewController class]]) {
        alpha = [(IKTLPersonalFeedViewController *)fromVC bgAlpha];
    }
    tmpView.backgroundColor = [IKHexColor(0x000000, 1) colorWithAlphaComponent:alpha];
    [containerView addSubview:tmpView];
    [containerView addSubview:fromVC.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.frame = CGRectMake(0, kScreenHeight, kScreenWidth , kScreenHeight);
        tmpView.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (isTabBarRoomVC) {
            [CATransaction begin];
            [CATransaction setDisableActions:YES];
            toVC.tabBarController.tabBar.hidden = NO;
            [CATransaction commit];
        }
        [tmpView removeFromSuperview];
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
            if (self.animatedTransitionEnd) {
                self.animatedTransitionEnd(NO);
            }
        }else{
            [transitionContext completeTransition:YES];
            if (self.animatedTransitionEnd) {
                self.animatedTransitionEnd(YES);
            }
        }

    }];
}

@end
