//
//  ULAnimationDelegate.h
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/21.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SPECIALSCALE ([UIScreen mainScreen].bounds.size.width == 320 && [UIScreen mainScreen].bounds.size.height == 480)
#define SMALLWIDTHSCALE ([UIScreen mainScreen].bounds.size.width == 320)

@protocol ULAnimationDelegate <NSObject>
- (void)ulAnimation:(id)animationObj playFinished:(BOOL)finished;
@end
