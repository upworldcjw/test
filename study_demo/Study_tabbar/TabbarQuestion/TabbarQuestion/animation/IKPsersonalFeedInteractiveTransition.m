//
//  IKPsersonalFeedInteractiveTransition.m
//  inke
//
//  Created by JianweiChen on 2018/7/5.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import "IKPsersonalFeedInteractiveTransition.h"

@interface IKPsersonalFeedInteractiveTransition ()<IKInteractiveProtocol>
/**手势方向*/
@property (nonatomic, assign) IKInteractiveTransitionGestureDirection direction;
/**手势类型*/
@property (nonatomic, assign) IKInteractiveTransitionType type;

@end

@implementation IKPsersonalFeedInteractiveTransition

+ (instancetype)interactiveTransitionWithTransitionType:(IKInteractiveTransitionType)type GestureDirection:(IKInteractiveTransitionGestureDirection)direction{
    return [[self alloc] initWithTransitionType:type GestureDirection:direction];
}

- (instancetype)initWithTransitionType:(IKInteractiveTransitionType)type GestureDirection:(IKInteractiveTransitionGestureDirection)direction{
    self = [super init];
    if (self) {
        _direction = direction;
        _type = type;
    }
    return self;
}

- (void)setGesture:(IKInteractiveGesture *)gesture{
    _gesture = gesture;
    _gesture.delegate = self;
}

#pragma mark - XWInteractiveProtocol
- (void)updatePercent:(CGFloat)percent{
    [self updateInteractiveTransition:percent];
    if (self.percentBlock) {
        self.percentBlock(percent);
    }
}

- (BOOL)gestureEndPercent:(CGFloat)percent{
    self.interation = NO;
    if (percent * [UIScreen mainScreen].bounds.size.width > 60) {
        [self finishInteractiveTransition];
        if(self.interationEndBlock){
            self.interationEndBlock(YES,percent);
        }
        return YES;
    }else{
        [self cancelInteractiveTransition];
        if (self.interationEndBlock) {
            self.interationEndBlock(NO,percent);
        }
        return NO;
    }
}

- (void)startGesture{
    self.interation = YES;
    switch (_type) {
        case IKInteractiveTransitionTypePush:{
            if (_pushConifg) {
                _pushConifg();
            }
        }
            break;
        case IKInteractiveTransitionTypePop:
            if(_popConifg){
                _popConifg();
            }
            break;
    }
}
@end
