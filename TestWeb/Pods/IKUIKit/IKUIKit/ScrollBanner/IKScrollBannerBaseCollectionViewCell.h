//
//  IKScrollBannerBaseCollectionViewCell.h
//  inke
//
//  Created by elijah dou on 2016/10/25.
//  Copyright © 2016年 MeeLive. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface IKScrollBannerBaseCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) UIImageView *imageView;
@property (nonatomic, weak) UIImageView *titleIcon;
@property (copy, nonatomic) NSString *title;

@property (nonatomic, weak) UIView *maskView;

@property (nonatomic, strong) UIColor *titleLabelTextColor;
@property (nonatomic, strong) UIFont *titleLabelTextFont;
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;
@property (nonatomic, assign) CGFloat titleLabelHeight;

@property (nonatomic, assign) BOOL hasConfigured;

/** 只展示文字轮播 */
@property (nonatomic, assign) BOOL onlyDisplayText;

@end
