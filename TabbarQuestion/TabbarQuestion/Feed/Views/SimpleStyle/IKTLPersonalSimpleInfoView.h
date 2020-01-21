//
//  IKTLPersonalInfoView.h
//  inke
//
//  Created by JianweiChen on 2018/5/30.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKTLPersonalLivingView.h"
#import "IKTLPersonalProtocol.h"
#import "IKTLPersonalInfoView.h"
#import "IKTLPersonSimpleFollowBtn.h"

@interface IKTLPersonalSimpleInfoView : IKTLPersonalInfoView

@property (nonatomic, strong) UIImageView *imgView; //图片
@property (nonatomic, strong) UILabel *nameLabel;   //姓名
@property (nonatomic, strong) UIImageView *genderImgView;//性别

@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIButton *publishBtn;
@property (nonatomic, strong) UIView *bottomLineView;

- (CGFloat)properHeight;

@end
