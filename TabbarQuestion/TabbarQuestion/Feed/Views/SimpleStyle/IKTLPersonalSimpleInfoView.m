//
//  IKTLPersonalInfoView.m
//  inke
//
//  Created by JianweiChen on 2018/5/30.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import "IKTLPersonalSimpleInfoView.h"
#import "IKUserInfo.h"
#import "PublicHeader.h"
#import <Masonry/Masonry.h>

@interface IKTLPersonalSimpleInfoView ()

@property (nonatomic, strong) UILabel *followLabel;     //关注数目
@property (nonatomic, strong) UILabel *locationLocation;//定位信息
@property (nonatomic, strong) UILabel *desLabel;        //描述
@property (nonatomic, assign) NSInteger fansNum;
@property (nonatomic, assign) NSInteger followNum;
@property (nonatomic, strong) IKTLPersonSimpleFollowBtn *followBtn;

@end

@implementation IKTLPersonalSimpleInfoView

- (CGFloat)properHeight{
    return self.height;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.nameLabel = [UILabel new];
        self.nameLabel.font = [UIFont boldSystemFontOfSize:16];
        self.nameLabel.textColor = IKHexColor(0xffffff, 1);
        [self addSubview:self.nameLabel];
        
        self.genderImgView = [UIImageView new];
        [self addSubview:self.genderImgView];
        
        self.followLabel = [UILabel new];
        self.followLabel.font = [UIFont systemFontOfSize:14];
        self.followLabel.textColor = IKHexColor(0xcccccc, 1);
        [self addSubview:self.followLabel];
        
        self.locationLocation = [UILabel new];
        self.locationLocation.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
        self.locationLocation.textColor = IKHexColor(0xffffff, 0.8);
        [self addSubview:self.locationLocation];
        
        self.desLabel = [UILabel new];
        self.desLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
        self.desLabel.textColor = IKHexColor(0xffffff, 0.8);
        self.desLabel.numberOfLines = 0;
        [self addSubview:self.desLabel];
        
        self.publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.publishBtn addTarget:self action:@selector(publishBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.publishBtn];
        [self.publishBtn setImage:[UIImage imageNamed:@"tl_personal_publish"] forState:UIControlStateNormal];
        self.publishBtn.hidden = YES;
        
        self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.shareBtn addTarget:self action:@selector(shareBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.shareBtn];
        [self.shareBtn setImage:[UIImage imageNamed:@"tl_share_detail"] forState:UIControlStateNormal];
        
        self.imgView = [UIImageView new];
        [self.imgView setContentMode:UIViewContentModeScaleAspectFit];
        [self.imgView setImage:[UIImage imageNamed:@"ik_metab_default_head"]];
        //        self.imgView.layer.borderWidth = 0.5;
        self.imgView.layer.masksToBounds = YES;
        self.imgView.layer.cornerRadius = 54/2.0;
        self.imgView.layer.borderColor = IKHexColor(0xffffff,1).CGColor;
        self.imgView.layer.borderWidth = 1;
        
        [self addSubview:self.imgView];
        
        self.followBtn = [IKTLPersonSimpleFollowBtn personalFollowBtnWithFrame:CGRectMake(0, 0, 49, 30)];
        [self addSubview:self.followBtn];
        [self.followBtn addTarget:self action:@selector(followTouch:) forControlEvents:UIControlEventTouchUpInside];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPersonalInfo:)];
        [self addGestureRecognizer:tapGesture];
        
        self.bottomLineView = [UIView new];
        self.bottomLineView.backgroundColor = IKHexColor(0xffffff, 0.1);
        self.bottomLineView.hidden = YES;
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
    CGFloat topMargin = 0;
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(54));
        make.left.equalTo(@(leftMargin));
        make.top.equalTo(@(topMargin));
    }];
    [self.nameLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_top).offset(6);
        make.left.equalTo(self.imgView.mas_right).offset(6);
        make.right.lessThanOrEqualTo(self.followBtn.mas_left).offset(-5 - 15);//15性别宽度
    }];
    [self.genderImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(2);
        make.centerY.equalTo(self.nameLabel);
    }];

    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-(leftMargin));
        make.centerY.equalTo(self.imgView.mas_centerY);
        make.height.width.equalTo(@(30));
    }];
    
    [self.followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shareBtn.mas_left).offset(-16);
        make.width.equalTo(@49);
        make.height.equalTo(@30);
        make.centerY.equalTo(self.imgView.mas_centerY);
    }];
    
    [self.publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shareBtn.mas_left).offset(-16);
        make.centerY.equalTo(self.imgView.mas_centerY);
    }];
    
    [self.followLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(6);
        make.left.equalTo(self.imgView.mas_right).offset(6);
    }];
    
    [self.locationLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_bottom).offset(12);
        make.left.equalTo(@(leftMargin));
    }];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.locationLocation.mas_bottom).offset(8);
        make.left.equalTo(@(leftMargin));
        make.width.mas_lessThanOrEqualTo(@(kScreenWidth - 2*leftMargin));
    }];
    ;
}

- (void)setUserInfo:(UserInfo *)userInfo{
    [super setUserInfo:userInfo];
    //考虑有签名和没有签名的情
    if ([userInfo.desc length] > 0) {
        [self.bottomLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.desLabel.mas_bottom).offset(12);
            make.left.equalTo(@0);
            make.right.equalTo(@(0));
            make.height.equalTo(@(0.5));
        }];
    }else{
        [self.bottomLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.locationLocation.mas_bottom).offset(12);
            make.left.equalTo(@0);
            make.right.equalTo(@(0));
            make.height.equalTo(@(0.5));
        }];
    }
    
//    if ([IKBMModelFactory sharedInstance].user.me.uid == self.userInfo.uid) {//我自己的主页
//        self.publishBtn.hidden = NO;
//        self.followBtn.hidden = YES;
//    }else{
//        self.publishBtn.hidden = YES;
//        self.followBtn.hidden = self.isFollowed;
//    }
    
    CGFloat height = [self refreshView];
    if (self.height != height) {
        [self.delegate personalInfoView:self needChangeHeight:height];
    }
}

- (CGFloat)refreshView{
//    NSString *imageUrl = [[IKUrlManager sharedInstance] fullImageUrl:self.userInfo.portrait];
//    CGSize size = CGSizeMake(kRate * 80 * kScale, kRate * 80 * kScale);
//    NSString *resizeUrl = [[MEImageStorage shareInstance] getResizeImageUrl:imageUrl size:size];
//    [self.imgView sd_setImageWithURL:[NSURL URLWithString:resizeUrl]
//                    placeholderImage:kImage(@"ik_metab_default_head")
//                             options:SDWebImageHighPriority
//                            progress:nil
//                           completed:nil];
//    self.nameLabel.text = [self.userInfo nickNameForShow];
    self.nameLabel.text = @"test";
    UIImage *image = [UIImage imageNamed:@"iktl_girl_icon"];
    if(self.userInfo.gender == BOY){
        image = [UIImage imageNamed:@"iktl_boy_icon"];
    }
    self.genderImgView.image = image;
    self.followLabel.attributedText = [self followLabelText];
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

- (NSAttributedString *)followLabelText{
    NSString *resultStr = @"";
    {
        NSMutableArray *mutArr = [NSMutableArray array];
        if (self.belikedNum >= 0) {
            [mutArr addObject:[@(self.belikedNum).description stringByAppendingString:@" 获赞"]];
        }
        if(self.followNum >= 0){
            [mutArr addObject:[@(self.followNum).description stringByAppendingString:@" 关注"]];
        }
        if (self.fansNum >= 0) {
            [mutArr addObject:[@(self.fansNum).description stringByAppendingString:@" 粉丝"]];
        }
        if (mutArr.count > 0) {
            resultStr = [mutArr componentsJoinedByString:@" · "];
        }
    }
    
    NSMutableAttributedString *mutAtt = [[NSMutableAttributedString alloc] initWithString:resultStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:IKHexColor(0xffffff,1)}];
    NSDictionary *dic = @{NSFontAttributeName:[UIFont fontWithName:@"DINAlternate-Bold" size:12],NSForegroundColorAttributeName:IKHexColor(0xffffff,0.8)};
    NSRange range = [resultStr rangeOfString:@" 获赞"];
    if (range.location != NSNotFound) {
        [mutAtt setAttributes:dic range:range];
    }
    range = [resultStr rangeOfString:@" 关注"];
    if (range.location != NSNotFound) {
        [mutAtt setAttributes:dic range:range];
    }
    range = [resultStr rangeOfString:@" 粉丝"];
    if (range.location != NSNotFound) {
        [mutAtt setAttributes:dic range:range];
    }
    return mutAtt;//填充高度用
}

- (NSString *)locationLabelText{
    return @"location";//填充高度用
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
