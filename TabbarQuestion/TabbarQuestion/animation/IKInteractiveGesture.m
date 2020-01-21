//
//  XWInteractiveGesture.m
//  inke
//
//  Created by JianweiChen on 2018/7/5.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import "IKInteractiveGesture.h"

@implementation IKInteractiveGesture

- (void)dealloc{
    NSLog(@"dealloc");
}

- (void)removeGesture{
    
}

@end

@implementation IKInteractivePanGesture

- (void)dealloc{
    [self removeGesture];
}

- (instancetype)initWithGestureDirection:(IKInteractiveTransitionGestureDirection)direction{
    if (self = [super init]){
        self.direction = direction;
    }
    return self;
}

- (void)addPanGestureAtView:(UIView *)view{
    [self removeGesture];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:pan];
    self.pan = pan;
}

- (void)removeGesture{
    if (self.pan) {
//        NSLog(@"cjw cjw %@",self.pan.view);
        [self.pan.view removeGestureRecognizer:self.pan];
        self.pan = nil;
    }
}


/**
 *  手势过渡的过程
 */
- (void)handleGesture:(UIPanGestureRecognizer *)panGesture{
    //手势百分比
    CGFloat persent = 0;
    CGFloat transitionX = 0;
    CGFloat transitionY = 0;
    switch (self.direction) {
        case IKInteractiveTransitionGestureDirectionLeft:{
            transitionX = -[panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case IKInteractiveTransitionGestureDirectionRight:{
            transitionX = [panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case IKInteractiveTransitionGestureDirectionUp:{
            transitionY = -[panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
        }
            break;
        case IKInteractiveTransitionGestureDirectionDown:{
            transitionY = [panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
        }
            break;
    }
    //    [panGesture setTranslation:CGPointZero inView:panGesture.view];
    //    [panGesture setTranslation:CGPointZero inView:panGesture.view];
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            //手势开始的时候标记手势状态，并开始相应的事件
            [self.delegate startGesture];
            break;
        case UIGestureRecognizerStateChanged:{
            //            手势过程中，通过updateInteractiveTransition设置pop过程进行的百分比
            //            NSLog(@"cjw cjw UIGestureRecognizerStateChanged %f",persent);
            [self.delegate updatePercent:persent];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            //            手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作
            [self.delegate gestureEndPercent:persent];
            
            break;
        }
        default:
            break;
    }
}

@end



