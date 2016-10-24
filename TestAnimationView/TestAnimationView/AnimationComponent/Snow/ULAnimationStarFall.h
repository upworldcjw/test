//
//  ULAnimationStarFall.h
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/21.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ULAnimationDelegate.h"

@import UIKit;

@interface ULAnimationStarFall : NSObject
@property (nonatomic,weak) id<ULAnimationDelegate> delegate;

- (instancetype)initWithView:(UIView *)view;

- (void)makeStarFall;
@end
