//
//  UIButton+IKUtility.h
//  IKUIKit
//
//  Created by yahengzheng on 17/5/13.
//  Copyright © 2017年 inke. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)();// 点击按钮触发的block

@interface UIButton (IKUtility)

// 点击按钮触发的block
@property (nonatomic, copy) ClickBlock clickBlock;

/**
 * 设置纯色button背景。
 */
-(void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;


/// 带点击回调 block 的初始化方法
+ (instancetype)ik_buttonWithBlock:(ClickBlock)clickBlock forControlEvents:(UIControlEvents)controlEvents;

- (void)setBlock:(ClickBlock)clickBlock forControlEvents:(UIControlEvents)controlEvents;


///设置图片距离左上角的位置，文字距离左上角的位置
- (void)setImageOrigin:(CGPoint)point1 titleOrigin:(CGPoint)point2;

//margin 间隙
///设置图片靠右，文字靠左
- (void)setImageAtRightSide:(CGFloat)margin;

///设置图片靠上，文字靠下
- (void)setImageAtUpSide:(CGFloat)margin;

///设置图片靠下，文字靠上
- (void)setImageAtDownSide:(CGFloat)margin;

- (void)scaleAnimate;

@end
