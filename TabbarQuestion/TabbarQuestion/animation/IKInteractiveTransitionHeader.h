//
//  IKInteractiveTransitionHeader.h
//  inke
//
//  Created by JianweiChen on 2018/7/5.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#ifndef IKInteractiveTransitionHeader_h
#define IKInteractiveTransitionHeader_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, IKInteractiveTransitionGestureDirection) {//手势的方向
    IKInteractiveTransitionGestureDirectionLeft = 0,
    IKInteractiveTransitionGestureDirectionRight,
    IKInteractiveTransitionGestureDirectionUp,
    IKInteractiveTransitionGestureDirectionDown
};

typedef NS_ENUM(NSUInteger, IKInteractiveTransitionType) {//手势控制哪种转场
    IKInteractiveTransitionTypePush,
    IKInteractiveTransitionTypePop,
};

@protocol IKInteractiveProtocol <NSObject>

//开始交互
- (void)startGesture;

//交互过程
- (void)updatePercent:(CGFloat)percent;

//交互结束
- (BOOL)gestureEndPercent:(CGFloat)percent;

@end



#endif /* IKInteractiveTransitionHeader_h */
