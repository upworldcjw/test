//
//  UIButton+Common.h
//  pengpeng
//
//  Created by feng on 14/11/7.
//  Copyright (c) 2014年 AsiaInnovations. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "JSBadgeView.h"
@interface UIButton (Common)
/**
 *	@brief	设置按钮的三种状态下的背景图
 *
 */
- (void)setBackgroudImage:(NSString *)normal
             hightlighted:(NSString *)highlight
                 selected:(NSString *)select;

/**
 *	@brief	设置按钮的四种状态下的图
 *
 */
- (void)setBackgroudImage:(NSString *)normal
             hightlighted:(NSString *)highlight
                 selected:(NSString *)select
                 disabled:(NSString *)disable;


- (void)setBackgroudCapImage:(NSString *)normal
                hightlighted:(NSString *)highlight
                    selected:(NSString *)select
                    disabled:(NSString *)disable
                  imageInset:(UIEdgeInsets)edgeInsets;

/**
 *	@brief	设置按钮的两种状态下的图
 *
 */
- (void)setBackgroudImage:(NSString *)normal
             hightlighted:(NSString *)highlight;

/**
 *	@brief	设置按钮的四种状态下的图,需要拉伸
 *
 */
- (void)setBackgroudCapImage:(NSString *)normal
                hightlighted:(NSString *)highlight
                    selected:(NSString *)select;

/**
 *	@brief	设置按钮的四种状态下的图，需要拉伸
 *
 */
- (void)setBackgroudCapImage:(NSString *)normal
                hightlighted:(NSString *)highlight
                    selected:(NSString *)select
                    disabled:(NSString *)disable;

/**
 *	@brief	设置按钮的两种状态下的图，需要拉伸
 *
 */
- (void)setBackgroudCapImage:(NSString *)normal
                hightlighted:(NSString *)highlight;

/**
 *	@brief	设置按钮的两种状态下的图
 *
 */
- (void)setImage:(NSString *)normal
    hightlighted:(NSString *)highlight;

/**
 *	@brief	设置按钮的三种状态下的图
 *
 */
- (void)setImage:(NSString *)normal
    hightlighted:(NSString *)highlight
        selected:(NSString *)select;

/**
 *	@brief	设置按钮的四种状态下的图
 *
 */
- (void)setImage:(NSString *)normal
    hightlighted:(NSString *)highlight
        selected:(NSString *)select
        disabled:(NSString *)disable;

/**
 *	@brief	设置按钮的三种状态下的标题及颜色
 *
 */
- (void)setTitle:(NSString *)title
     normalColor:(UIColor *)normal
hightlightedColor:(UIColor *)highlight
   selectedColor:(UIColor *)select;

/**
 *	@brief	设置按钮的四种状态下的标题及颜色
 *
 */
- (void)setTitle:(NSString *)title
     normalColor:(UIColor *)normal
hightlightedColor:(UIColor *)highlight
   selectedColor:(UIColor *)select
   disabledColor:(UIColor *)disable;

/**
 *	@brief	设置按钮的两种状态下的标题及颜色
 *
 */
- (void)setTitle:(NSString *)title
     normalColor:(UIColor *)normal
hightlightedColor:(UIColor *)highlight;

/**
 *	@brief	设置按钮的一种状态下的标题及颜色
 *
 */
- (void)setTitle:(NSString *)title
     normalColor:(UIColor *)normal;
/**
 *	@brief	按钮添加点击事件
 *
 */
- (void)addClickEventWithTarget:(id)target selector:(SEL)selector;


/**
 *	@brief 按钮是否可用，默认带有0.3的透明度
 *
 */
- (void)setAvailable:(BOOL)b;

@end
