//
//  DDImageView.h
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/21.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDImageView : UIImageView{
    NSInteger _frameCounter;
    NSInteger _repeatCounter;
    NSTimeInterval _timeElapsed;
    CADisplayLink *_displayLink;
    NSTimeInterval _animaitonInterval;
}

- (void)setAnimationInterval:(NSTimeInterval)newValue;
@end
