//
//  IKScrollBannerBaseCollectionViewCell.m
//  inke
//
//  Created by elijah dou on 2016/10/25.
//  Copyright © 2016年 MeeLive. All rights reserved.
//

#import "IKScrollBannerBaseCollectionViewCell.h"

@implementation IKScrollBannerBaseCollectionViewCell
{
    __weak UILabel *_titleLabel;
    __weak UIView *_titleContainerView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
        [self setupTitleLabel];
    }
    
    return self;
}

- (void)setTitleLabelBackgroundColor:(UIColor *)titleLabelBackgroundColor
{
    _titleLabelBackgroundColor = titleLabelBackgroundColor;
    _titleContainerView.backgroundColor = titleLabelBackgroundColor;
}

- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor
{
    _titleLabelTextColor = titleLabelTextColor;
    _titleLabel.textColor = titleLabelTextColor;
}

- (void)setTitleLabelTextFont:(UIFont *)titleLabelTextFont
{
    _titleLabelTextFont = titleLabelTextFont;
    _titleLabel.font = titleLabelTextFont;
}

- (void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView = imageView;
    [self.contentView addSubview:imageView];
}

- (void)setupTitleLabel
{
    UIView *containerView = [[UIView alloc] init];
    containerView.hidden = YES;
    _titleContainerView = containerView;
    
    UIImageView *titleIcon = [[UIImageView alloc] init];
    _titleIcon = titleIcon;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
//    _titleLabel.hidden = YES;
    
    [_titleContainerView addSubview:_titleIcon];
    [_titleContainerView addSubview:_titleLabel];
    [self.contentView addSubview:_titleContainerView];
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    _titleLabel.text = [NSString stringWithFormat:@"%@", (title?:@"")];
    if (_titleContainerView.hidden) {
        _titleContainerView.hidden = NO;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.onlyDisplayText) {
        _titleContainerView.frame = self.bounds;
        [self layoutTitleContainerView];
    } else {
        _imageView.frame = self.bounds;
        _maskView.frame = self.bounds;
        CGFloat titleLabelW = CGRectGetWidth(self.bounds);
        CGFloat titleLabelH = _titleLabelHeight;
        CGFloat titleLabelX = 0;
        CGFloat titleLabelY = CGRectGetHeight(self.bounds) - titleLabelH;
        _titleContainerView.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
        [self layoutTitleContainerView];
    }
}

- (void)layoutTitleContainerView
{
#define mMarginX 15.f
    CGRect frame = _titleContainerView.bounds;
    CGSize iconSize = _titleIcon.intrinsicContentSize;
    CGRect titleLabelFrame = CGRectMake(mMarginX, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
    if (CGSizeEqualToSize(iconSize, CGSizeZero)) {
        _titleLabel.frame = titleLabelFrame;
    } else {
        CGRect titleIconFrame = CGRectMake(mMarginX, CGRectGetHeight(frame) - iconSize.height - 9, iconSize.width, iconSize.height);
        CGFloat titleLabelX = mMarginX + 7 + iconSize.width;
        titleLabelFrame = CGRectMake(titleLabelX, -5.5, CGRectGetWidth(frame) - titleLabelX, CGRectGetHeight(titleLabelFrame));
        
        _titleIcon.frame = titleIconFrame;
        _titleLabel.frame = titleLabelFrame;
        
    }
}

@end
