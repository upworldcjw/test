//
//  IKTLPersonalInfoView.m
//  inke
//
//  Created by JianweiChen on 2018/5/30.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import "IKTLPersonalCommonInfoView.h"
#import "IKUserInfo.h"
#import "PublicHeader.h"


@interface IKTLPersonalCommonInfoView ()

@property (nonatomic, strong) UILabel *followLabel;     //关注数目
@property (nonatomic, strong) UILabel *locationLocation;//定位信息
@property (nonatomic, strong) UILabel *desLabel;        //描述
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, assign) NSInteger fansNum;
@property (nonatomic, assign) NSInteger followNum;

@end

@implementation IKTLPersonalCommonInfoView

- (CGFloat)properHeight{
    return self.bounds.size.height;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.nameLabel = [UILabel new];
        self.nameLabel.font = [UIFont boldSystemFontOfSize:18];
        self.nameLabel.textColor = IKHexColor(0x333333, 1);
        [self addSubview:self.nameLabel];
        
        self.genderImgView = [UIImageView new];
        [self addSubview:self.genderImgView];
        
        self.livingView = [[IKTLPersonalLivingView alloc] initWithFrame:CGRectMake(0, 0, 54, 21)];
        [self addSubview:self.livingView];

        self.followLabel = [UILabel new];
        self.followLabel.font = [UIFont systemFontOfSize:14];
        self.followLabel.textColor = IKHexColor(0x666666, 1);
        [self addSubview:self.followLabel];
        
        self.locationLocation = [UILabel new];
        self.locationLocation.font = [UIFont systemFontOfSize:14];
        self.locationLocation.textColor = IKHexColor(0x999999, 1);
        [self addSubview:self.locationLocation];
        
        self.desLabel = [UILabel new];
        self.desLabel.font = [UIFont systemFontOfSize:14];
        self.desLabel.textColor = IKHexColor(0x999999, 1);
        self.desLabel.numberOfLines = 0;
        [self addSubview:self.desLabel];
        
        self.publishBtn = [IKTLPersonActionBtn personalActonButtonWithSize:CGSizeMake(80, 30)];
        [self.publishBtn addTarget:self action:@selector(publishBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.publishBtn];
        [self.publishBtn setImage:[UIImage imageNamed:@"iktl_personal_publish"] title:@"发布"];
        self.publishBtn.hidden = YES;
        
        self.shareBtn = [IKTLPersonActionBtn personalActonButtonWithSize:CGSizeMake(80, 30)];
        [self.shareBtn addTarget:self action:@selector(shareBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.shareBtn];
        [self.shareBtn setImage:[UIImage imageNamed:@"iktl_personal_share"] title:@"分享"];
        
        self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.moreBtn addTarget:self action:@selector(moreBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.moreBtn];
        [self.moreBtn setImage:[UIImage imageNamed:@"ik_metab_arrow"] forState:UIControlStateNormal];

        self.imgView = [UIImageView new];
        [self.imgView setContentMode:UIViewContentModeScaleAspectFit];
        [self.imgView setImage:[UIImage imageNamed:@"ik_metab_default_head"]];
        //        self.imgView.layer.borderWidth = 0.5;
        self.imgView.layer.masksToBounds = YES;
        self.imgView.layer.cornerRadius = 80*kRate/2.0;
        self.imgView.layer.borderColor = [IKHexColor(0x000000,1) colorWithAlphaComponent:0.1].CGColor;
        self.imgView.layer.borderWidth = 0.5;
        
        [self addSubview:self.imgView];
        
        self.followBtn = [IKTLPersonFollowBtn personalFollowBtnWithFrame:CGRectMake(0, 0, 80, 30)];
        [self addSubview:self.followBtn];
        [self.followBtn addTarget:self action:@selector(followTouch:) forControlEvents:UIControlEventTouchUpInside];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPersonalInfo:)];
        [self addGestureRecognizer:tapGesture];
        
        self.bottomLineView = [UIView new];
        self.bottomLineView.backgroundColor = IKHexColor(0xececec, 1);
        [self addSubview:self.bottomLineView];
        
        [self sendSubviewToBack:self.bottomLineView];
        [self sendSubviewToBack:self.desLabel];
        [self sendSubviewToBack:self.locationLocation];
        [self sendSubviewToBack:self.followLabel];
        
        [self configLayout];
        [self setIsFollowed:YES];
        
        self.belikedNum = -1;
        self.fansNum = -1;
        self.followNum = -1;
    }
    return self;
}


- (void)setIsFollowed:(BOOL)isFollowed{
    [super setIsFollowed:isFollowed];
    [self.followBtn refreshFollowBtn:isFollowed];
}

- (void)configLayout{
    CGFloat leftMargin = 12;
    CGFloat topMargin = 30;
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(80 * kRate));
        make.left.equalTo(@(leftMargin));
        make.top.equalTo(@(topMargin));
    }];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-(leftMargin));
        make.centerY.equalTo(self.imgView.mas_centerY);
        make.width.height.equalTo(@(18));
    }];
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.moreBtn.mas_left).offset(-16);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
        make.centerY.equalTo(self.moreBtn.mas_centerY);
    }];
    [self.followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shareBtn.mas_left).offset(-16);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
        make.centerY.equalTo(self.moreBtn.mas_centerY);
    }];
    
    [self.publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shareBtn.mas_left).offset(-16);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
        make.centerY.equalTo(self.moreBtn.mas_centerY);
    }];
    
    CGFloat genderLeft = kScreenWidth - 54 - leftMargin - 2 - 13 - 2;
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_bottom).offset(16);
        make.left.equalTo(@(leftMargin));
        make.width.lessThanOrEqualTo(@(genderLeft - leftMargin));
    }];
    [self.genderImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(2);
        make.centerY.equalTo(self.nameLabel);
    }];
    [self.livingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.genderImgView.mas_right).offset(10);
        make.centerY.equalTo(self.nameLabel);
        make.width.equalTo(@54);
        make.height.equalTo(@21);
    }];
    
    [self.followLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.left.equalTo(@(leftMargin));
    }];
    [self.locationLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.followLabel.mas_bottom).offset(5);
        make.left.equalTo(@(leftMargin));
    }];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.locationLocation.mas_bottom).offset(5);
        make.left.equalTo(@(leftMargin));
        make.width.mas_lessThanOrEqualTo(@(kScreenWidth - 2*leftMargin));
    }];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.desLabel.mas_bottom).offset(12);
        make.left.equalTo(@0);
        make.right.equalTo(@(0));
        make.height.equalTo(@(0.5));
    }];
}

- (void)setUserInfo:(UserInfo *)userInfo{
    [super setUserInfo:userInfo];
    CGFloat height = [self refreshView];
    if (self.height != height) {
        [self.delegate personalInfoView:self needChangeHeight:height];
    }
    if (NO) {//我自己的主页
        self.publishBtn.hidden = NO;
        self.followBtn.hidden = YES;
    }else{
        self.publishBtn.hidden = YES;
        self.followBtn.hidden = NO;
    }
    self.desLabel.text = userInfo.desc;
}


- (void)setIsLiving:(BOOL)isLiving{
    [super setIsLiving:isLiving];
}

- (CGFloat)refreshView{
//    NSString *imageUrl = [[IKUrlManager sharedInstance] fullImageUrl:self.userInfo.portrait];
//    CGSize size = CGSizeMake(kRate * 80 * kScale, kRate * 80 * kScale);
//    NSString *resizeUrl = [[MEImageStorage shareInstance] getResizeImageUrl:imageUrl size:size];
//    [self.imgView sd_setImageWithURL:[NSURL URLWithString:resizeUrl]
//                            placeholderImage:kImage(@"ik_metab_default_head")
//                                     options:SDWebImageHighPriority
//                                    progress:nil
//                                   completed:nil];
    self.nameLabel.text = @"nick";
    UIImage *image = [UIImage imageNamed:@"iktl_girl_icon"];
    if(self.userInfo.gender == BOY){
        image = [UIImage imageNamed:@"iktl_boy_icon"];
    }
    self.genderImgView.image = image;
    self.followLabel.text = [self followLabelText];
    self.locationLocation.text = [self locationLabelText];
    self.desLabel.text = self.userInfo.desc;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGFloat height = CGRectGetMaxY(self.bottomLineView.frame);
    if (self.userInfo.desc.length != 0) {
        height = CGRectGetMaxY(self.bottomLineView.frame);
    }
    return height;
}

- (NSString *)followLabelText{
    return @" 获赞关注粉丝";//填充高度用
}

- (NSString *)locationLabelText{
    return @" location";//填充高度用
}

- (void)setContentAlpha:(CGFloat)alpha{
    self.followLabel.alpha = alpha;
    self.locationLocation.alpha = alpha;
    self.desLabel.alpha = alpha;
    self.bottomLineView.alpha = alpha;
}

#pragma mark -Aciton

- (void)followTouch:(id)sender{
    if (self.followBlock) {
        self.followBlock();
    }
}

- (void)publishBtnTouch:(id)sender{
    if (self.goToPublish) {
        self.goToPublish();
    }
}

- (void)shareBtnTouch:(id)sender{
    if (self.shreBlock) {
        self.shreBlock();
    }
}

- (void)moreBtnTouch:(id)sender{
    if (self.goToPersonBlock) {
        self.goToPersonBlock();
    }
}

- (void)tapPersonalInfo:(UITapGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if (self.goToPersonBlock) {
            self.goToPersonBlock();
        }
    }
}

@end
