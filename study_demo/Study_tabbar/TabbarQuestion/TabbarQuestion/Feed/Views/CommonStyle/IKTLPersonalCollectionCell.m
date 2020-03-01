//
//  IKTLPersonalCollectionCell.m
//  inke
//
//  Created by JianweiChen on 2018/6/1.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import "IKTLPersonalCollectionCell.h"
#import "PublicHeader.h"
#import "IKTimeLineItem.h"

@interface IKTLPersonalCollectionCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIImageView *tagView;
@property (nonatomic, strong) UIImageView *scanImgView;
@property (nonatomic, strong) UILabel *scanNumLabel;
@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation IKTLPersonalCollectionCell

+ (CGSize)properSize{
    return CGSizeMake(kScreenWidth/3.0, kScreenWidth/3.0 + [self leftLineMargin]);
}

+ (CGFloat)leftLineMargin{
    return 1/kScale * 4;
}

+ (CGFloat)properWidth{
    return kScreenWidth/3;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imgView = [UIImageView new];
        self.imgView.backgroundColor = [UIColor clearColor];
        self.imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.imgView];

        CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
        gradientLayer.colors = @[(__bridge id)[IKHexColor(0x000000,1) colorWithAlphaComponent:0.6].CGColor,
                                        (__bridge id)[IKHexColor(0x000000,1) colorWithAlphaComponent:0].CGColor];
        gradientLayer.startPoint = CGPointMake(0, 1);
        gradientLayer.endPoint = CGPointMake(0, 0);
        gradientLayer.frame = CGRectMake(0, kScreenWidth/3.0 - 27 , kScreenWidth/3.0, 27);
        [self.imgView.layer addSublayer:gradientLayer];
        
        
        self.tagView = [UIImageView new];
        [self.contentView addSubview:self.tagView];
        
        self.scanImgView = [UIImageView new];
        [self.contentView addSubview:self.scanImgView];
        
        self.scanNumLabel = [UILabel new];
        self.scanNumLabel.font = [UIFont systemFontOfSize:12];
        self.scanNumLabel.textColor = IKHexColor(0xffffff, 1);
        [self.contentView addSubview:self.scanNumLabel];
        
        self.leftLineView = [UIView new];
        [self.contentView addSubview:self.leftLineView];
        self.leftLineView.backgroundColor = IKHexColor(0xffffff, 1);
        
        self.bottomLineView = [UIView new];
        [self.contentView addSubview:self.bottomLineView];
        self.bottomLineView.backgroundColor = IKHexColor(0xffffff, 1);
        
        [self configLayout];
    }
    return self;
}

- (void)configLayout{
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(kScreenWidth/3.0));
        make.top.left.equalTo(self);
    }];
    
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-3);
        make.top.equalTo(self.contentView).offset(3);
    }];
    
    [self.scanImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(6);
        make.bottom.equalTo(self.contentView).offset(-6);
    }];
    
    [self.scanNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scanImgView.mas_right).offset(3);
        make.centerY.equalTo(self.scanImgView.mas_centerY);
    }];
    
    [self.leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.width.equalTo(@([self.class leftLineMargin]));
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.height.equalTo(@([self.class leftLineMargin]));
    }];
}

- (void)setTimeLineFrame:(IKTimeLineItem *)frame{
    IKTimeLineItem *item = frame;
    CGFloat width = [self.class properWidth];
    CGSize cutSize = CGSizeMake(width * kScale, width *kScale);
    
    NSString *url = @"";
    if ([item isVideoType]) {//视频模式
        IKTimeLineVideoItem *videoItem = [item.content.videoArray firstObject];
        url = videoItem.videoCover;
        [self.tagView setImage:[UIImage imageNamed:@"iktl_personal_video"]];
    }else{//图片模式
        NSArray *allPics = item.content.picturesArray;
        IKTimeLinePicItem *picItem = [allPics firstObject];
        url = picItem.picUrl;
        if (allPics.count > 1) {
            [self.tagView setImage:[UIImage imageNamed:@"iktl_personal_mult_img"]];
        }else{
             [self.tagView setImage:[UIImage new]];
        }
    }
//    [[IKUrlManager sharedInstance] scaleImageUrl:url size:cutSize];
//    NSString *urlStr = [[MEImageStorage shareInstance] getCenterResizeImageUrl:url size:cutSize];
//    [self.imgView feed_setImageWithURL:[NSURL URLWithString:urlStr] feedId:frame.status.feedID placeholderImage:[IKDefaultImage photoImage] completed:nil];
    
//    if ([IKBMModelFactory sharedInstance].user.me.uid == item.feedUser.uid) {
    [self.scanImgView setImage:[UIImage imageNamed:@"iktl_personal_favor"]];
    if (item.likeNum < 10000) {
         self.scanNumLabel.text = @(item.likeNum).description;//点赞数量
    }else{
         self.scanNumLabel.text = [NSString stringWithFormat:@"%.1fW",item.likeNum/10000.0];//点赞数量
    }
}

@end
