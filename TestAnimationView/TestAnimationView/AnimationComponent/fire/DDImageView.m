//
//  DDImageView.m
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/21.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import "DDImageView.h"

@implementation DDImageView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _frameCounter  = 0;
        _repeatCounter = 0;
        _timeElapsed = 0;
        _animaitonInterval = 1;
    }
    return self;
}

//1到6之间有效
- (void)setAnimationInterval:(NSTimeInterval)newValue{
    if (1 > newValue) {
        _animaitonInterval = 1;
    }else if (6 < newValue){
        _animaitonInterval = 6;
    }else{
        _animaitonInterval  = newValue;
    }
}

- (void)startAnimating{
    if (_displayLink) {
        return;
    }
    if (self.animationDuration > 0 && self.animationImages && self.animationImages.count>0) {
        _frameCounter  = 0;
        _repeatCounter = 0 ;
        _timeElapsed = 0;
        if (!_displayLink) {
            _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(changAnimationImage)];
            _displayLink.frameInterval  = _animaitonInterval;
        }
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop]
                           forMode:NSDefaultRunLoopMode];
    }
}


- (void)stopAnimating{
    if (_displayLink) {
        [_displayLink invalidate];
        _displayLink = nil;
    }
}

- (void)changAnimationImage{
//    self.image = [self.animationImages objectAtIndex:0];
    self.image = [self.animationImages objectAtIndex:_frameCounter ++];
    
    _timeElapsed += _displayLink.duration;
    if ((_timeElapsed >= self.animationDuration ||
        _frameCounter >= self.animationImages.count) &&
        (0 < self.animationRepeatCount &&
         _repeatCounter <= self.animationRepeatCount)) {
            _repeatCounter ++;
            _frameCounter = 0;
    }
    if(_repeatCounter >= self.animationRepeatCount){
        [self stopAnimating];
    }
}


@end
