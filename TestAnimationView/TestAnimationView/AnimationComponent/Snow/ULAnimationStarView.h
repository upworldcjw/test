//
//  ShipView.h
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/20.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import <UIKit/UIKit.h>

//[网络]	
@interface ULAnimationStarView : UIView
@property (nonatomic,assign) CGPoint beginPoint;

- (instancetype)initWithImageName:(NSString *)imageName finished:(dispatch_block_t)finished;

- (void)animation;
@end
