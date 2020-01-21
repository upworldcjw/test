//
//  IKPopView.h
//  IKUIKit
//
//  Created by Chenxiaocheng on 17/2/10.
//  Copyright © 2017年 inke. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IKPopViewDelegate;

@interface IKPopView : UIView

@property(nonatomic, weak) id<IKPopViewDelegate> delegate;

@property (nonatomic, assign) BOOL isPoping;

- (instancetype)initWithCutomView:(UIView *)customView;

- (void)presentInNewWindowWithBackgroundBlackAlpha:(CGFloat)alpha animated:(BOOL)animated;
- (void)presentPointingInView:(UIView *)containerView animated:(BOOL)animated;

- (void)dismissAnimated:(BOOL)animated;

@end


@protocol IKPopViewDelegate <NSObject>

- (void)popViewWasDismissedByUser:(IKPopView *)popView;

@end
