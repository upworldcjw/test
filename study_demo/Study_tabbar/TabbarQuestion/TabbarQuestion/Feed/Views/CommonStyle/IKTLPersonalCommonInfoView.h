//
//  IKTLPersonalInfoView.h
//  inke
//
//  Created by JianweiChen on 2018/5/30.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKTLPersonalLivingView.h"
#import "IKTLPersonFollowBtn.h"
#import "IKTLPersonalProtocol.h"
#import "IKTLPersonalInfoView.h"

@interface IKTLPersonalCommonInfoView : IKTLPersonalInfoView

@property (nonatomic, strong) UIImageView *imgView; //图片
@property (nonatomic, strong) UILabel *nameLabel;   //姓名
@property (nonatomic, strong) UIImageView *genderImgView;//性别
@property (nonatomic, strong) IKTLPersonalLivingView *livingView;
@property (nonatomic, strong) IKTLPersonActionBtn *shareBtn;
@property (nonatomic, strong) IKTLPersonActionBtn *publishBtn;
@property (nonatomic, strong) IKTLPersonFollowBtn *followBtn;
@property (nonatomic, strong) UIButton *moreBtn;

- (void)setContentAlpha:(CGFloat)alpha;

- (CGFloat)properHeight;

@end
