//
//  IKTLPersonalTopBarView.h
//  inke
//
//  Created by JianweiChen on 2018/5/30.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKUserInfo.h"
#import "IKTLPersonFollowBtn.h"
#import "IKTLPersonalLivingView.h"

typedef NS_ENUM(NSInteger,IKTLPersonListModel) {
    IKTLPersonalTopBarViewList,
    IKTLPersonalTopBarViewCell,
};

typedef NS_ENUM(NSInteger,IKTLPersonTopBarStyle) {
    IKTLPersonTopBarStyleChangModel,
    IKTLPersonTopBarStyleUserInfo,
};

@class IKTLPersonalTopBarView;
@protocol IKTLPersonalTopBarViewDelegte <NSObject>

- (void)personalTopBarViewClik:(IKTLPersonalTopBarView *)topBar;

@end

@interface IKTLPersonalTopBarView : UIView
@property (nonatomic, copy) void (^goToLiving)(void);
@property (nonatomic, copy) void (^followBlock)(void);

@property (nonatomic, strong) UIView   *bottomLineView;
@property (nonatomic, assign) IKTLPersonListModel cellModel;
@property (nonatomic, assign) IKTLPersonListModel style;
@property (nonatomic, weak) id<IKTLPersonalTopBarViewDelegte> delegate;
@property (nonatomic, strong) UserInfo *userInfo;
@property (nonatomic, assign) BOOL isFollowed;
@property (nonatomic, assign) BOOL isLiving;

+ (CGFloat)properHeight;

- (UIImageView *)imgView;
- (UILabel *)nameLabel;
- (UIImageView *)genderImgView;
- (IKTLPersonFollowBtn *)followBtn;
- (IKTLPersonalLivingView *)livingView;
- (void)setModelViewAlpha:(CGFloat)alpha;

@end
