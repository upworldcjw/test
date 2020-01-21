//
//  IKPersonalFeedAnimatedTransition.h
//  inke
//
//  Created by JianweiChen on 2018/7/5.
//  Copyright © 2018 MeeLive. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XWPageCoverTransitionType) {
    XWPageCoverTransitionTypePush = 0,
    XWPageCoverTransitionTypePop
};

@interface IKPersonalFeedAnimatedTransition : NSObject<UIViewControllerAnimatedTransitioning>
/**
 *  动画过渡代理管理的是push还是pop
 */
@property (nonatomic, assign) XWPageCoverTransitionType type;
@property (nonatomic, copy) void (^animatedTransitionEnd)(BOOL completion);
/**
 *  初始化动画过渡代理
 * @prama type 初始化pop还是push的代理
 */
+ (instancetype)transitionWithType:(XWPageCoverTransitionType)type;

- (instancetype)initWithTransitionType:(XWPageCoverTransitionType)type;

@end
