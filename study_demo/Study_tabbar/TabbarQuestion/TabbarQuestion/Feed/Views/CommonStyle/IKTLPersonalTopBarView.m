//
//  IKTLPersonalTopBarView.m
//  inke
//
//  Created by JianweiChen on 2018/5/30.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import "IKTLPersonalTopBarView.h"
#import "IKTLPersonalLivingView.h"
#import "IKTLPersonFollowBtn.h"
#import "PublicHeader.h"

@interface IKTLPersonalTopBarViewStyleA : UIView
@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UIButton *cellModelBtn;
@property (nonatomic, strong) UIButton *listModelBtn;
@property (nonatomic, strong) UIView   *lineView;
@property (nonatomic, weak) id<IKTLPersonalTopBarViewDelegte> delegate;
@end

@implementation IKTLPersonalTopBarViewStyleA

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = [UILabel new];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        self.titleLabel.textColor = IKHexColor(0x333333, 1);
        self.titleLabel.text = @"动态";
        [self addSubview:self.titleLabel];
        
        self.cellModelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cellModelBtn addTarget:self action:@selector(cellModelTouch:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cellModelBtn];
        [self.cellModelBtn setImage:[UIImage imageNamed:@"iktl_personal_viewMode_list"] forState:UIControlStateNormal];
        [self.cellModelBtn setImage:[UIImage imageNamed:@"iktl_personal_viewMode_list_selected"] forState:UIControlStateSelected];
//        self.cellModelBtn.hitTestEdgeInsets = UIEdgeInsetsMake(-10, -12, -10, -16);
        
        self.lineView = [UIView new];
        self.lineView.backgroundColor = IKHexColor(0xcccccc, 1);
        [self addSubview:self.lineView];
        
        self.listModelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.listModelBtn addTarget:self action:@selector(listModelTouch:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.listModelBtn];
//        self.listModelBtn.hitTestEdgeInsets = UIEdgeInsetsMake(-10, -12, -10, -16);
        
        [self.listModelBtn setImage:[UIImage imageNamed:@"iktl_personal_viewMode"] forState:UIControlStateNormal];
        [self.listModelBtn setImage:[UIImage imageNamed:@"iktl_personal_viewMode_selected"] forState:UIControlStateSelected];
        [self configLayout];
    }
    return self;
}

- (void)configLayout{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.centerY.equalTo(self);
    }];
    
    [self.listModelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-12));
        make.centerY.equalTo(self);
        make.width.height.equalTo(@18);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.listModelBtn.mas_left).offset(-16);
        make.centerY.equalTo(self);
        make.height.equalTo(@18);
        make.width.equalTo(@0.5);
    }];
    
    [self.cellModelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lineView.mas_left).offset(-16);;
        make.centerY.equalTo(self);
        make.width.height.equalTo(@18);
    }];
}

- (void)setCellModel:(IKTLPersonListModel)cellModel{
    if (cellModel == IKTLPersonalTopBarViewCell) {
        if (self.cellModelBtn.selected) {
            return;
        }
        self.cellModelBtn.selected = YES;
        self.listModelBtn.selected = NO;
    }else{//list
        if (self.listModelBtn.selected) {
            return;
        }
        self.cellModelBtn.selected = NO;
        self.listModelBtn.selected = YES;
    }
}
#pragma mark - Action
- (void)cellModelTouch:(UIButton *)sender{
    if (sender.selected) {
        return;
    }
    [self.delegate personalTopBarViewClik:self.superview];
}

- (void)listModelTouch:(UIButton *)sender{
    if (sender.selected) {
        return;
    }
    [self.delegate personalTopBarViewClik:self.superview];
}

@end

@interface IKTLPersonalTopBarViewStyleB : UIView
@property (nonatomic, strong) UIImageView *imgView; //图片
@property (nonatomic, strong) UILabel *nameLabel;   //姓名
@property (nonatomic, strong) UIImageView *genderImgView;//性别
@property (nonatomic, strong) IKTLPersonFollowBtn *followBtn;
@property (nonatomic, strong) IKTLPersonalLivingView *livingView;
@property (nonatomic, copy) void (^tapFollowBtn)(void);
@end

@implementation IKTLPersonalTopBarViewStyleB

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imgView = [UIImageView new];
        [self.imgView setContentMode:UIViewContentModeScaleAspectFit];
        [self.imgView setImage:[UIImage imageNamed:@"ik_metab_default_head"]];
        //        self.imgView.layer.borderWidth = 0.5;
        self.imgView.layer.masksToBounds = YES;
        self.imgView.layer.cornerRadius = 72/4.0;
        [self addSubview:self.imgView];
        
        self.nameLabel = [UILabel new];
        self.nameLabel.font = [UIFont boldSystemFontOfSize:14];
        self.nameLabel.textColor = IKHexColor(0x333333, 1);
        [self addSubview:self.nameLabel];
        
        self.genderImgView = [UIImageView new];
        [self addSubview:self.genderImgView];
        
        self.livingView = [[IKTLPersonalLivingView alloc] initWithFrame:CGRectMake(0, 0, 54, 21)];
        [self addSubview:self.livingView];
    
        self.followBtn = [IKTLPersonFollowBtn personalFollowBtnWithFrame:CGRectMake(0, 0, 80, 30)];
        [self addSubview:self.followBtn];
        [self.followBtn addTarget:self action:@selector(followTouch:) forControlEvents:UIControlEventTouchUpInside];
        [self.followBtn refreshFollowBtn:NO];
        [self configLayout];
    }
    return self;
}

- (void)configLayout{
    CGFloat leftMargin = 12;
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(72/2.0));
        make.left.equalTo(@(leftMargin));
        make.centerY.equalTo(self);
    }];
    CGFloat maxWidth = kScreenWidth - leftMargin - 30 - 12 - 12 - 3 - 54 - 3 - 80 - leftMargin ;
    maxWidth -= 3;//开播和关注之间的间距
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset(12);
        make.centerY.equalTo(self);
        make.width.lessThanOrEqualTo(@(maxWidth));
    }];
    [self.genderImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(3);
        make.centerY.equalTo(self);
    }];
    
    [self.livingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.genderImgView.mas_right).offset(3);
        make.centerY.equalTo(self);
        make.width.equalTo(@54);
        make.height.equalTo(@21);
    }];
    
    [self.followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-leftMargin);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
        make.centerY.equalTo(self);
    }];
}

- (void)setUserInfo:(UserInfo *)userInfo{
//    NSString *imageUrl = [[IKUrlManager sharedInstance] fullImageUrl:userInfo.portrait];
//    CGSize size = CGSizeMake(30 * kScale, 30 * kScale);
//    NSString *resizeUrl = [[MEImageStorage shareInstance] getResizeImageUrl:imageUrl size:size];
//    [self.imgView sd_setImageWithURL:[NSURL URLWithString:resizeUrl]
//                    placeholderImage:kImage(@"ik_metab_default_head")
//                             options:SDWebImageHighPriority
//                            progress:nil
//                           completed:nil];
//    self.nameLabel.text = [userInfo nickNameForShow];
    self.nameLabel.text = @"test";
    UIImage *image = [UIImage imageNamed:@"iktl_girl_icon"];
    if(userInfo.gender == BOY){
        image = [UIImage imageNamed:@"iktl_boy_icon"];
    }
    self.genderImgView.image = image;
//    if ([IKBMModelFactory sharedInstance].user.me.uid == userInfo.uid) {
//        self.followBtn.hidden = YES;
//    }else{
//        self.followBtn.hidden = NO;
//    }
}

#pragma mark -Action
- (void)followTouch:(UIButton *)sender{
    if (self.tapFollowBtn) {
        self.tapFollowBtn();
    }
}

@end

@interface IKTLPersonalTopBarView ()

@property (nonatomic, strong) UIView   *topLineView;
@property (nonatomic, strong) IKTLPersonalTopBarViewStyleA *styleAView;
@property (nonatomic, strong) IKTLPersonalTopBarViewStyleB *styleBView;


@end

@implementation IKTLPersonalTopBarView

+ (CGFloat)properHeight{
    return 49;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.topLineView = [UIView new];
//        self.topLineView.backgroundColor = IKHexColor(0xffffff, 0.9);
//        [self addSubview:self.topLineView];
        
        self.bottomLineView = [UIView new];
        self.bottomLineView.backgroundColor = IKHexColor(0xececec, 1);
        [self addSubview:self.bottomLineView];
        
        self.styleAView = [[IKTLPersonalTopBarViewStyleA alloc] initWithFrame:self.bounds];
        [self addSubview:self.styleAView];
        
        self.styleBView = [[IKTLPersonalTopBarViewStyleB alloc] initWithFrame:self.bounds];
        [self addSubview:self.styleBView];
        
        weakify(self);
        [self.styleBView setTapFollowBtn:^{
            strongify(self);
            if (self.followBlock) {
                self.followBlock();
            }
        }];
        
        [self.styleBView.livingView setGoToLiving:^{
            strongify(self);
            if (self.goToLiving) {
                self.goToLiving();
            }
        }];
        [self configLayout];
    }
    return self;
}

- (UIImageView *)imgView{
    return self.styleBView.imgView;
}
- (UILabel *)nameLabel{
    return self.styleBView.nameLabel;
}
- (UIImageView *)genderImgView{
    return self.styleBView.genderImgView;
}
- (IKTLPersonFollowBtn *)followBtn{
    return self.styleBView.followBtn;
}
- (IKTLPersonalLivingView *)livingView{
    return self.styleBView.livingView;
}

- (void)setDelegate:(id<IKTLPersonalTopBarViewDelegte>)delegate{
    _delegate = delegate;
    self.styleAView.delegate = self.delegate;
}

- (void)setIsLiving:(BOOL)isLiving{
    _isLiving = isLiving;
}

- (void)setIsFollowed:(BOOL)isFollowed{
    _isFollowed = isFollowed;
    [self.styleBView.followBtn refreshFollowBtn:isFollowed];
}


- (void)configLayout{
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.right.equalTo(self);
        make.height.equalTo(@0.5);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.right.equalTo(self);
        make.height.equalTo(@0.5);
    }];
}

- (void)setCellModel:(IKTLPersonListModel)cellModel{
    _cellModel = cellModel;
    [self.styleAView setCellModel:cellModel];
}

- (void)setUserInfo:(UserInfo *)userInfo{
    _userInfo = userInfo;
    [self.styleBView setUserInfo:userInfo];
}

- (void)setStyle:(IKTLPersonListModel)style{
    _style = style;
    if (style == IKTLPersonTopBarStyleChangModel) {
        self.styleAView.hidden = NO;
        self.styleBView.hidden = YES;
    }else{
        self.styleAView.hidden = YES;
        self.styleBView.hidden = NO;
    }
}


- (void)setModelViewAlpha:(CGFloat)alpha{
    self.styleAView.alpha = alpha;
}
@end
