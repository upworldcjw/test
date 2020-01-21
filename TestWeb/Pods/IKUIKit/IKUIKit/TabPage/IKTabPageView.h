//
//  IKTabPageView.h
//  inke
//
//  Created by Chenxiaocheng on 15/7/21.
//  Copyright (c) 2015年 inke. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum:NSUInteger{
    IKTabPageTypeClick = 0,
    IKTabPageTypeScroll,
}IKTabPageType;

@class IKTabPageView;

@protocol TabPageViewDelegate<NSObject>

@optional

- (void)tabPageView:(IKTabPageView *)view didChangeTabToIndex:(NSInteger)selectedIndex;
- (void)tabPageView:(IKTabPageView *)view isRightDirection:(BOOL)isRightDirection offsetX:(CGFloat)offsetX;
- (void)tabPageView:(IKTabPageView *)view isScrolling:(BOOL)isScrolling;

@end

@interface IKTabPageView : UIView

@property(nonatomic, readonly, assign) NSUInteger selectedIndex;
@property(nonatomic, strong) UIColor *tabColor;
@property(nonatomic, strong) UIColor *tabSelectedColor;
//埋点
@property(nonatomic, assign) IKTabPageType pageType;

@property(nonatomic, weak) id<TabPageViewDelegate> delegate;

- (id)initWithPageViews:(NSArray *)views frame:(CGRect)frame;

- (id)initWithPageViews:(NSArray *)views titles:(NSArray *)titles tabHeight:(CGFloat)height frame:(CGRect)frame;

- (void)setSelectedTabIndex:(NSInteger)selectedIndex;
- (void)setSelectedTabIndex:(NSInteger)selectedIndex animated:(BOOL)animated;

@end
