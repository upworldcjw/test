//
//  ShipView.h
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/20.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,StarFallType){
    StarFalBig,
    StarFalMiddle,
    StarFalSmall,
};

//[网络]	
@interface ULAnimationStarFallView : UIView
@property (nonatomic,assign) CGPoint beginPoint;

- (instancetype)initWithFallType:(StarFallType)type finished:(dispatch_block_t)finished;

- (void)animation;
@end
