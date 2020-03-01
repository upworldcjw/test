//
//  IKPsersonalFeedInteractiveTransition.h
//  inke
//
//  Created by JianweiChen on 2018/7/5.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKInteractiveTransitionHeader.h"
#import "IKInteractiveGesture.h"

typedef void(^GestureConifg)(void);
typedef void (^updatePercent) (CGFloat percent);

@interface IKPsersonalFeedInteractiveTransition : UIPercentDrivenInteractiveTransition <IKInteractiveProtocol>
/**记录是否开始手势，判断pop操作是手势触发还是返回键触发*/
@property (nonatomic, assign) BOOL interation;
/**促发手势push的时候的config，config中初始化并push需要弹出的控制器*/
@property (nonatomic, copy) GestureConifg pushConifg;
@property (nonatomic, copy) GestureConifg popConifg;
@property (nonatomic, copy) updatePercent percentBlock;
@property (nonatomic, copy) void (^interationEndBlock)(BOOL completion,CGFloat percent);
@property (nonatomic, assign) BOOL hasPush;
@property (nonatomic, assign, readonly) CGFloat transition;
@property (nonatomic, strong) IKInteractiveGesture *gesture;

//初始化方法
+ (instancetype)interactiveTransitionWithTransitionType:(IKInteractiveTransitionType)type GestureDirection:(IKInteractiveTransitionGestureDirection)direction;

- (instancetype)initWithTransitionType:(IKInteractiveTransitionType)type GestureDirection:(IKInteractiveTransitionGestureDirection)direction;

@end
