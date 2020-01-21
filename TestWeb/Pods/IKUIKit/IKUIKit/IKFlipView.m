//
//  IKFlipView.m
//  IKUIKit
//
//  Created by zld on 17/07/2017.
//  Copyright © 2017 zld. All rights reserved.
//

#import "IKFlipView.h"

static const CGFloat duration = 0.3;
static const CGFloat delta = 0.6;
static const CGFloat idleDuration = 1;

@interface IKFlipView ()

@property (nonatomic, assign) BOOL isCancelled;

@end

@implementation IKFlipView

- (instancetype)initWithFlipViews:(NSArray<UIView *> *)flipViews {
    self = [super init];
    if (self) {
        self.flipViews = flipViews;
    }
    return self;
}

- (void)start {
    self.isCancelled = NO;
    NSUInteger totalCount = [self.flipViews count];
    if (totalCount == 0) {
        return;
    }
    
    static NSUInteger index = 0;
    
    UIView *currentView = self.flipViews[index];
    UIView *nextView = self.flipViews[index + 1 >= totalCount ? 0 : index + 1];
    currentView.layer.transform = CATransform3DMakeRotation(0, 1, 0, 0);
    currentView.layer.anchorPoint = CGPointMake(0.5, 0);
    nextView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 1, 0, 0);
    nextView.layer.anchorPoint = CGPointMake(0.5, 1);
    currentView.frame = self.bounds;
    nextView.frame = self.bounds;
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    currentView.layer.sublayerTransform = transform;
    nextView.layer.sublayerTransform = transform;
    [self addSubview:currentView];
    [self addSubview:nextView];
    
    [UIView animateWithDuration:duration animations:^{
        currentView.layer.transform = [self getTransForm3DWithAngle:M_PI_2];
    }];
    [UIView animateWithDuration:duration delay:delta * duration options:0 animations:^{
        nextView.layer.transform = [self getTransForm3DWithAngle:0];
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(idleDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.isCancelled) {
                return;
            }
            [self start];
        });
    }];
    
    if (index >= totalCount - 1) {
        index = 0;
    } else {
        index++;
    }
}

- (void)stop {
    self.isCancelled = YES;
}

-(CATransform3D)getTransForm3DWithAngle:(CGFloat)angle{
    CATransform3D transform = CATransform3DIdentity;//获取一个标准默认的CATransform3D仿射变换矩阵
//    transform.m34=4.5/-2000;//透视效果
    transform.m34 = -0.001;
    transform=CATransform3DRotate(transform,angle,1,0,0);//获取旋转angle角度后的rotation矩阵。
    return transform;
}


@end
