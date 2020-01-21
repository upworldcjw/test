//
//  IKUserPhoneBindTipView.m
//  IKUIKit
//
//  Created by 孙西纯 on 2017/6/1.
//  Copyright © 2017年 inke. All rights reserved.
//

#import "IKUserPhoneBindTipView.h"
#import "Masonry.h"
#import "IKThemeDefine.h"
#import "UIButton+IKUtility.h"

@interface IKUserPhoneBindTipView ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *actionButton;

@property (nonatomic, copy) ToastBlock clickBlock;
@property (nonatomic, copy) ToastBlock closeBlock;

@end

@implementation IKUserPhoneBindTipView

+ (CGFloat)height
{
    return 45;
}

+ (IKUserPhoneBindTipView *)toastWithString:(NSString *)string
                           clickBlock:(ToastBlock)clickBlock
                           closeBlock:(ToastBlock)closeBlock
{
    return [self toastWithIcon:nil string:string clickBlock:clickBlock closeBlock:closeBlock];
}


+ (IKUserPhoneBindTipView *)toastWithIcon:(UIImage *)icon
                             string:(NSString *)string
                         clickBlock:(ToastBlock)clickBlock
                         closeBlock:(ToastBlock)closeBlock
{
    IKUserPhoneBindTipView *inlayToastView = [[IKUserPhoneBindTipView alloc]init];
    if (icon != nil) {
        inlayToastView.iconImageView.image = icon;
    }
    inlayToastView.textLabel.text = string;
    inlayToastView.clickBlock = clickBlock;
    inlayToastView.closeBlock = closeBlock;
    return inlayToastView;
}

+ (IKUserPhoneBindTipView *)toastWithLeftIcon:(UIImage *)icon1 leftTitle:(NSString *)string1 rightIcon:(UIImage *)icon2 rightTitle:(NSString *)string2 clickBlock:(ToastBlock)clickBlock rightButtonClick:(ToastBlock)rightBlock
{
    IKUserPhoneBindTipView *inlayToastView = [[IKUserPhoneBindTipView alloc]init];
    if (icon1) {
        inlayToastView.iconImageView.image = icon1;
    }
    inlayToastView.textLabel.text = string1;
    if (icon2) {
        [inlayToastView.closeButton setImage:icon2 forState:UIControlStateNormal];
        [inlayToastView.closeButton setTitle:string2 forState:UIControlStateNormal];
        [inlayToastView.closeButton layoutIfNeeded];
        [inlayToastView.closeButton setImageAtRightSide:5];
    }
    inlayToastView.clickBlock = clickBlock;
    inlayToastView.closeBlock = rightBlock;
    
    return inlayToastView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [IKUserPhoneBindTipView height]);
        self.frame = frame;
        self.backgroundColor = [UIColor colorWithRed:1 green:254.0/255 blue:244.0/255 alpha:1];
        [self loadUI];
    }
    return self;
}

- (void)loadUI
{
    _iconImageView = [[UIImageView alloc]init];
    [self addSubview:_iconImageView];
    _iconImageView.tintColor = mIKColor_3;
    _iconImageView.image = [UIImage imageNamed:@"icon_taost_tel"];
    _iconImageView.contentMode = UIViewContentModeCenter;
    
    _textLabel = [[UILabel alloc]init];
    [self addSubview:_textLabel];
    _textLabel.textColor = mIKColor_3;
    _textLabel.font = [UIFont systemFontOfSize:15];
    _textLabel.textAlignment = NSTextAlignmentLeft;
    
    _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_actionButton];
    [_actionButton addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_closeButton];
    [_closeButton setImage:[UIImage imageNamed:@"icon_taost_close"] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    _closeButton.imageView.tintColor = mIKColor_3;
    _closeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_closeButton setTitleColor:mIKColor_3 forState:UIControlStateNormal];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.leading.top.bottom.equalTo(self);
        make.width.equalTo(@(41));
    }];
    
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.leading.equalTo(self.iconImageView.mas_trailing);
        make.centerY.equalTo(self.mas_centerY);
        make.trailing.equalTo(self.mas_trailing).with.offset(-50);
    }];
    
    [_actionButton mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.bottom.leading.equalTo(self);
        make.trailing.equalTo(self.mas_trailing).with.offset(50);
    }];
    
    [_closeButton mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.bottom.trailing.equalTo(self);
        make.width.equalTo(@(50));
    }];
}

- (void)closeAction
{
    if (self.closeBlock)
    {
        self.closeBlock();
    }
}

- (void)clickAction
{
    if (self.clickBlock)
    {
        self.clickBlock();
    }
}


@end
