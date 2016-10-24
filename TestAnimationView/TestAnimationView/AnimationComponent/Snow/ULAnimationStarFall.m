//
//  ULAnimationStarFall.m
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/21.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import "ULAnimationStarFall.h"
#import "ULAnimationStarView.h"
#import "ULAnimationStarFallView.h"

@interface ULAnimationStarFall()
@property (nonatomic,weak) UIView *onView;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) NSInteger stareFallCount;
@property (nonatomic,assign) CGFloat timeInterval;
@property (nonatomic,assign) NSInteger starFallPlayedCount;
@end

@implementation ULAnimationStarFall

- (instancetype)initWithView:(UIView *)view;{
    if (self = [super init]) {
        self.onView = view;
        self.stareFallCount = 0;
        self.stareFallCount = 0;
        self.timeInterval = 0.04;
    }
    return  self;
}

- (void)dealloc{
    [self stop];
}

- (void)stop{
    [self.timer invalidate];
    self.timer = nil;
    if ([self.delegate respondsToSelector:@selector(ulAnimation:playFinished:)]) {
        [self.delegate ulAnimation:self playFinished:YES];
    }
}

- (void)makeStarFall{
    NSTimer *timer = [NSTimer timerWithTimeInterval:self.timeInterval target:self selector:@selector(doMakeStare) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)playFinisehd{
    if (self.starFallPlayedCount == 4/self.timeInterval) {
        [self stop];
    }
}

- (void)doMakeStare{
    self.stareFallCount ++;
    if (self.onView == nil || self.stareFallCount >= 4/self.timeInterval) {
        [self stop];
        return;
    }
    CGFloat angle = 1/6.0*M_PI;
    
    NSInteger i = arc4random() % 4;
    switch (i) {
        case 0:{
            CGFloat beginY = -tan(angle) * self.onView.frame.size.width;
            CGFloat endY = 0.6 * self.onView.frame.size.height - tan(angle) * self.onView.frame.size.width;
            CGFloat factor = (arc4random() * 1.0)/UINT32_MAX;
            CGFloat randomY = beginY + (endY - beginY) * factor;
            CGPoint randomPoint = CGPointMake(self.onView.frame.size.width, randomY);
            
            __weak typeof(self) wself = self;
            ULAnimationStarFallView *starView = [[ULAnimationStarFallView alloc] initWithFallType:i finished:^{
                [wself playFinisehd];
            }];
            [self.onView addSubview:starView];
            starView.beginPoint = randomPoint;
            [starView animation];
        }
            break;
        case 3:{
            
            CGFloat beginY = -tan(angle) * self.onView.frame.size.width;
            CGFloat endY = 0.25 * self.onView.frame.size.height - tan(angle) * self.onView.frame.size.width;
            CGFloat factor = (arc4random() * 1.0)/UINT32_MAX;
            CGFloat randomY = beginY + (endY - beginY) * factor;
            CGPoint randomPoint = CGPointMake(self.onView.frame.size.width, randomY);
            
            __weak typeof(self) wself = self;
            ULAnimationStarView *starView = [[ULAnimationStarView alloc] initWithImageName:nil finished:^{
                [wself playFinisehd];
            }];
            [self.onView addSubview:starView];
            starView.beginPoint = randomPoint;
            [starView animation];
        }
            break;
        default:
            break;
    }
}

@end
