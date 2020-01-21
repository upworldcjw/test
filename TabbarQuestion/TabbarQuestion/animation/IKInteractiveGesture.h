//
//  IKInteractiveTransitionHeader.h
//  inke
//
//  Created by JianweiChen on 2018/7/5.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IKInteractiveTransitionHeader.h"

@interface IKInteractiveGesture : NSObject

@property (nonatomic, weak)   id<IKInteractiveProtocol> delegate;
@property (nonatomic, assign) IKInteractiveTransitionGestureDirection direction;

- (void)removeGesture;
@end

@interface IKInteractivePanGesture : IKInteractiveGesture

@property (nonatomic, strong) UIPanGestureRecognizer *pan;

- (instancetype)initWithGestureDirection:(IKInteractiveTransitionGestureDirection)direction;

- (void)addPanGestureAtView:(UIView *)view;


@end
