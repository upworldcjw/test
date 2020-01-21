//
//  IKPopView.m
//  IKUIKit
//
//  Created by Chenxiaocheng on 17/2/10.
//  Copyright © 2017年 inke. All rights reserved.
//

#import "IKPopView.h"
#import <IKFoundation/IKFoundation.h>

@interface IKPopView()

@property (nonatomic, strong) UIButton *dismissTarget;
@property (nonatomic, strong) UIWindow *window;

@end

@implementation IKPopView

- (instancetype)initWithCutomView:(UIView *)customView
{
    self = [super initWithFrame:customView.frame];
    if (self) {
        [self addSubview:customView];
    }
    
    return self;
}

- (void)presentInNewWindowWithBackgroundBlackAlpha:(CGFloat)alpha animated:(BOOL)animated {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.windowLevel = UIWindowLevelAlert;
    self.window.backgroundColor = [UIColor clearColor];
    
    self.dismissTarget = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.dismissTarget addTarget:self action:@selector(dismissTapAnywhereFired:) forControlEvents:UIControlEventTouchUpInside];
    [self.dismissTarget setTitle:@"" forState:UIControlStateNormal];
    self.dismissTarget.frame = self.window.bounds;
    [self.window addSubview:self.dismissTarget];
    [self.window addSubview:self];
    
    CGRect frame     = self.frame;
    frame.size.width = self.window.frame.size.width;
    frame.origin.y   = self.window.frame.size.height - frame.size.height;
    
    [self.window makeKeyAndVisible];
    if (animated) {
        CGRect startFrame = frame;
        startFrame.origin.y = kScreenHeight;
        self.frame = startFrame;
        
        [self setNeedsDisplay];
        
        [UIView beginAnimations:nil context:nil];
        self.frame = frame;
        self.window.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:alpha];
        [UIView commitAnimations];
    }else {
        [self setNeedsDisplay];
        self.window.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:alpha];
        self.frame = frame;
    }
    
    self.isPoping = YES;
}

- (void)presentPointingInView:(UIView *)containerView animated:(BOOL)animated
{
    self.dismissTarget = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.dismissTarget addTarget:self action:@selector(dismissTapAnywhereFired:) forControlEvents:UIControlEventTouchUpInside];
    [self.dismissTarget setTitle:@"" forState:UIControlStateNormal];
    self.dismissTarget.frame = containerView.bounds;
    [containerView addSubview:self.dismissTarget];
    
    [containerView addSubview:self];
    
    CGRect frame     = self.frame;
    frame.size.width = containerView.frame.size.width;
    frame.origin.y   = containerView.frame.size.height - frame.size.height;
    
    if (animated) {
        CGRect startFrame = frame;
        startFrame.origin.y = kScreenHeight;
        self.frame = startFrame;
        
        [self setNeedsDisplay];
        
        [UIView beginAnimations:nil context:nil];
        self.frame = frame;
        [UIView commitAnimations];
    }else {
        [self setNeedsDisplay];
        self.frame = frame;
    }
    
    self.isPoping = YES;
}

- (void)dismissTapAnywhereFired:(__unused UIButton *)button
{
    [self dismissByUser];
}

- (void)dismissByUser
{
    [self setNeedsDisplay];
    
    [self dismissAnimated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(popViewWasDismissedByUser:)]) {
        [self.delegate popViewWasDismissedByUser:self];
    }
}

- (void)dismissAnimationDidStop:(__unused NSString *)animationID finished:(__unused NSNumber *)finished context:(__unused void *)context
{
    [self finaliseDismiss];
}

- (void)finaliseDismiss
{
    self.isPoping = NO;
    if (self.dismissTarget) {
        [self.dismissTarget removeFromSuperview];
        self.dismissTarget = nil;
    }
    
    [self removeFromSuperview];
    [self.window resignKeyWindow];
    self.window = nil;
}

#pragma mark - Public Methods

- (void)dismissAnimated:(BOOL)animated
{
    if (animated) {
        CGRect frame = self.frame;
        frame.origin.y = kScreenHeight;
        
        [UIView beginAnimations:nil context:nil];
        self.frame = frame;
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(dismissAnimationDidStop:finished:context:)];
        self.window.backgroundColor = [UIColor clearColor];
        [UIView commitAnimations];
    } else {
        [self finaliseDismiss];
    }
}

@end
