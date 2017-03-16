//
//  AnimationView.h
//  TestAanimationView
//
//  Created by JianweiChenJianwei on 2017/3/15.
//  Copyright © 2017年 UL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionLayoutDataItem.h"

@interface JWAnimationView : UIView

@property (nonatomic, strong) CollectionLayoutDataItem *item;

//设置选中的index
@property (nonatomic, assign) NSInteger selectedIndex;

//下划线的宽度
@property (nonatomic, assign) NSInteger itemWidth;

@property (nonatomic, assign) NSInteger markAngelIndex;//三角所在区域
//三角形的角度
@property (nonatomic, assign) CGFloat   angle;

- (instancetype)initWithLayoutItem:(CollectionLayoutDataItem *)item;

//所有属性赋值之后，需要重新刷新布局
- (void)prepareAnimation;

//从一个index 移动到另一个index移动的百分比
- (void)fromIndex:(NSInteger)index toIndex:(NSInteger)toIndex progress:(CGFloat)progress;

//从一个index 移动到另一个index 需要多久时间
//由于动画运动需要一定时间duration，从一个tab移动到另一个tab期间，
//如果修改了selectedIndex，或者调用了fromIndex:toIndex:progress:
//则动画立即无效
- (void)fromIndex:(NSInteger)index toIndex:(NSInteger)toIndex duration:(CGFloat)duration;

//显示进度（0-1）
- (void)setProgress:(CGFloat)progress;


@end
