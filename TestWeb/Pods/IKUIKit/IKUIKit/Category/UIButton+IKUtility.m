//
//  UIButton+IKUtility.m
//  IKUIKit
//
//  Created by yahengzheng on 17/5/13.
//  Copyright © 2017年 inke. All rights reserved.
//

#import "UIButton+IKUtility.h"
#import "UIImage+UIColor.h"
#import <objc/runtime.h>

@implementation UIButton (IKUtility)


-(void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    UIImage *backgroundImage = [UIImage imageWithColor:backgroundColor size:CGSizeMake(1, 1)];
    
    [self setBackgroundImage:[backgroundImage stretchableImageWithLeftCapWidth:backgroundImage.size.width/2 topCapHeight:backgroundImage.size.height/2] forState:state];
}

/// 带点击回调 block 的初始化方法
+ (instancetype)ik_buttonWithBlock:(ClickBlock)clickBlock forControlEvents:(UIControlEvents)controlEvents
{
    UIButton *button = [[UIButton alloc] init];
    button.clickBlock = clickBlock;
    
    [button addTarget:button action:@selector(implementBlock) forControlEvents:controlEvents];
    return button;
}

- (void)implementBlock
{
    
    if (self.clickBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.clickBlock();
        });
    }
}

- (void)setBlock:(ClickBlock)clickBlock forControlEvents:(UIControlEvents)controlEvents
{
    self.clickBlock = nil;
    self.clickBlock = clickBlock;
    [self addTarget:self action:@selector(implementBlock) forControlEvents:controlEvents];
}

#pragma mark -

///设置图片距离左上角的位置，文字距离左上角的位置
- (void)setImageOrigin:(CGPoint)point1 titleOrigin:(CGPoint)point2 {
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    
    [self setImageEdgeInsets:UIEdgeInsetsMake(point1.y, point1.x, 0, 0)];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(point2.y, point2.x, 0, 0)];
}

///设置图片靠右，文字靠左
- (void)setImageAtRightSide:(CGFloat)margin{
    CGSize fullSize = self.bounds.size;
    CGSize imageSize = self.imageView.image.size;
    CGSize titleSize = self.titleLabel.bounds.size;
    
    CGFloat titleY = (fullSize.height - titleSize.height) * 0.5;
    CGFloat titleX = (fullSize.width - imageSize.width - titleSize.width - margin) * 0.5 - imageSize.width;
    
    CGFloat imageY = (fullSize.height - imageSize.height) * 0.5;
    CGFloat imageX = titleX + imageSize.width + titleSize.width + margin;
    
    [self setImageOrigin:CGPointMake(imageX, imageY) titleOrigin:CGPointMake(titleX, titleY)];
}

///设置图片靠上，文字靠下
- (void)setImageAtUpSide:(CGFloat)margin{
    CGSize fullSize = self.bounds.size;
    CGSize imageSize = self.imageView.image.size;
    CGSize titleSize = self.titleLabel.bounds.size;
    
    CGFloat imageX = (fullSize.width - imageSize.width) * 0.5;
    CGFloat imageY = (fullSize.height - imageSize.height - titleSize.height - margin) * 0.5;
    
    CGFloat titleX = ((fullSize.width - titleSize.width) * 0.5 - imageSize.width);
    CGFloat titleY = imageY + imageSize.height + margin;
    
    [self setImageOrigin:CGPointMake(imageX, imageY) titleOrigin:CGPointMake(titleX, titleY)];
}

///设置图片靠下，文字靠上
- (void)setImageAtDownSide:(CGFloat)margin{
    CGSize fullSize = self.bounds.size;
    CGSize imageSize = self.imageView.image.size;
    CGSize titleSize = self.titleLabel.bounds.size;
    
    CGFloat titleX = ((fullSize.width - titleSize.width) * 0.5 - imageSize.width);
    CGFloat titleY = (fullSize.height - imageSize.height - titleSize.height - margin) * 0.5;
    
    CGFloat imageX = (fullSize.width - imageSize.width) * 0.5;
    CGFloat imageY = titleY + titleSize.height + margin;
    
    [self setImageOrigin:CGPointMake(imageX, imageY) titleOrigin:CGPointMake(titleX, titleY)];
}


#pragma mark - 运行时添加 block

- (ClickBlock)clickBlock {
    return objc_getAssociatedObject(self, @"XYButtonClickBlock");
}

- (void)setClickBlock:(ClickBlock)clickBlock {
    
    objc_setAssociatedObject(self,@"XYButtonClickBlock", clickBlock,OBJC_ASSOCIATION_COPY);
}

- (void)scaleAnimate {
    CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc] init];
    animation.values = @[@1.0, @0.95, @0.9, @0.85, @0.8, @0.85, @0.9, @0.95, @1.0, @1.05, @1.1, @1.05, @1.0];
    animation.duration = 0.3;
    animation.calculationMode = kCAAnimationCubic;
    
    [self.layer addAnimation:animation forKey:@"transform.scale"];
}

@end
