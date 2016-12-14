//
//  ULGuardSlideShadowAnimationView.m
//  UpLive
//
//  Created by jianwei on 11/3/16.
//  Copyright © 2016 AsiaInnovations. All rights reserved.
//

#import "ULGuardSlideShadowAnimationView.h"
#import "ULGuardAnchorAvatarView.h"
#import "ULGuardAnchorBlendView.h"

#define kMethodTwo

@interface ULGuardSlideShadowAnimationView()

@property (nonatomic, strong) ULGuardAnchorAvatarView *avatarView;
@property (nonatomic, strong) CAGradientLayer *topLineLayer;
@property (nonatomic, strong) CAGradientLayer *bottomLineLayer;

@property (nonatomic, strong) UILabel         *labelView;

@property (nonatomic, strong) UIView          *contentView;
@property (nonatomic, strong) UIImageView     *trailImgView;
@property (nonatomic, strong) UIImageView     *maskView;

@property (nonatomic, strong) UIImageView     *cacheOriginalImgView;


@property (nonatomic, strong) CAGradientLayer          *bgLabelLayer;

#ifdef kMethodTwo
@property (nonatomic, strong) ULGuardAnchorBlendView   *blendView;
@property (nonatomic, strong) UIView          *allMaskImgView;
#endif

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *trailMsg;

@end

#define kFontSize UL_Font_Size_15

//#define kShowBgColor
@implementation ULGuardSlideShadowAnimationView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.bgLabelLayer = [CAGradientLayer layer];
        [self.layer addSublayer:self.bgLabelLayer];
        self.bgLabelLayer.anchorPoint = CGPointMake(0, 0);
        
        self.bgLabelLayer.locations = @[@0,@1];
        self.bgLabelLayer.colors = @[
                                     (id)[UIColor darkGrayColor].CGColor,
                                     (id)[[UIColor darkGrayColor] colorWithAlphaComponent:0].CGColor,
                                     ];
        self.bgLabelLayer.startPoint = CGPointMake(0,.5);
        self.bgLabelLayer.endPoint = CGPointMake(1,.5);
//        self.bgLabelLayer.hidden = YES;
        
#ifdef kMethodTwo
        //层次
        self.allMaskImgView = [UIView new];
        self.allMaskImgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.allMaskImgView];
        //层次二
        self.contentView  = [UIView new];
        [self addSubview:self.contentView];
        //层次三
        self.cacheOriginalImgView = [UIImageView new];
        self.blendView = [ULGuardAnchorBlendView new];
        [self addSubview:self.blendView];
#else
        self.cacheOriginalImgView = [UIImageView new];
        [self addSubview:self.cacheOriginalImgView];
        self.contentView  = [UIView new];
        [self addSubview:self.contentView];
#endif
    
#ifdef kShowBgColor
        self.contentView.backgroundColor = [UIColor blueColor];
#endif
        self.topLineLayer = [CAGradientLayer layer];
        [self.contentView.layer addSublayer:self.topLineLayer];
        self.topLineLayer.anchorPoint = CGPointMake(0, 0.5);
        
        self.bottomLineLayer = [CAGradientLayer layer];
        [self.contentView.layer addSublayer:self.bottomLineLayer];
        self.bottomLineLayer.anchorPoint = CGPointMake(0, 0.5);
        
        self.avatarView = [[ULGuardAnchorAvatarView alloc] initWithImageName:@"chat_guard_animation_avatarBg"];
        [self.contentView addSubview:self.avatarView];
        
        self.trailImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_guard_animation_star"]];
        [self.contentView addSubview:self.trailImgView];
        
        self.labelView = [UILabel new];
        self.labelView.font = kFontSize;
        [self.contentView addSubview:self.labelView];
        
#ifdef kShowBgColor
        self.labelView.backgroundColor = [UIColor redColor];
#endif
        self.maskView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_guard_animation_light"]];
    }
    return self;
}

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setAvatar:(NSString *)avtarurl andName:(NSString *)name{
//    [self.avatarView setav];
    self.name = name;
    self.trailMsg = @"晋升为主播";
    [self fitSize];
}

- (void)setUpContent{
    //TODO:contentView.maskView
    NSMutableAttributedString *mutAttStr = [[NSMutableAttributedString alloc] initWithString:[self.name stringByAppendingString:self.trailMsg]];
    [mutAttStr setAttributes:@{NSForegroundColorAttributeName:[UIColor yellowColor]} range:NSMakeRange(0, self.name.length)];
    self.labelView.textColor = [UIColor whiteColor];
    self.labelView.attributedText = mutAttStr;
}

- (void)fitSize{
    
    CGSize nameSize = [self.name sizeForFont:kFontSize withMaxWidth:CGFLOAT_MAX];
    CGSize trailSize = [self.trailMsg sizeForFont:kFontSize withMaxWidth:CGFLOAT_MAX];
    CGSize trailImgSize = [self.trailImgView frame].size;
    
    CGSize avatarSize = self.avatarView.frame.size;
    avatarSize = CGSizeMake(102/2.0, 71/2.0);
    
    CGFloat width = avatarSize.width + nameSize.width + trailSize.width + trailImgSize.width;
    CGFloat height = avatarSize.height;
    [self setFrame:CGRectMake(0, 0, width, height)];
    [self.contentView setFrame:self.bounds];
    [self.cacheOriginalImgView setFrame:self.bounds];
#ifdef kMethodTwo
    [self.allMaskImgView setFrame:self.bounds];
    [self.blendView setFrame:self.bounds];
#endif
    [self.avatarView setFrame:CGRectMake(0, 0, avatarSize.width, avatarSize.height)];
    CGFloat topLineWidth = avatarSize.width/2.0 + nameSize.width + trailSize.width;
    [self.topLineLayer setFrame:CGRectMake(avatarSize.width/2.0, 10, topLineWidth, 1)];
    [self.bottomLineLayer setFrame:CGRectMake(avatarSize.width/2.0, avatarSize.height-1, topLineWidth, 1)];
    
    [self setLayer:self.topLineLayer nameWidth:avatarSize.width/2.0 + nameSize.width];
    [self setLayer:self.bottomLineLayer nameWidth:avatarSize.width/2.0 + nameSize.width];
    
    self.labelView.frame = CGRectMake(avatarSize.width, self.topLineLayer.position.y, nameSize.width + trailSize.width, self.bottomLineLayer.position.y - self.topLineLayer.position.y);
    
    self.bgLabelLayer.bounds = CGRectMake(0, 0, topLineWidth, self.labelView.frame.size.height);
    self.bgLabelLayer.position = self.topLineLayer.position;
    
    self.trailImgView.nb_x = self.labelView.nb_right;
    self.trailImgView.nb_centerY = self.labelView.nb_centerY;
    
    [self setUpContent];

    self.cacheOriginalImgView.image = [self.contentView exportToImage];
#ifdef kMethodTwo

    self.cacheOriginalImgView.alpha = 1;
    self.allMaskImgView.maskView = self.cacheOriginalImgView;
    //镂空view
    self.allMaskImgView.maskView = [self cacheOriginalImgView];
    
    [self.blendView refreshWithOriginaImg:self.cacheOriginalImgView.image
                                  maskImg:[self.allMaskImgView exportToImage]];
    
//    self.contentView.hidden = YES;
    self.allMaskImgView.hidden = YES;
    self.cacheOriginalImgView.hidden = YES;
    
    self.blendView.maskView = self.maskView;
    self.maskView.frame = CGRectMake(-self.maskView.nb_width, 0, self.maskView.nb_width, self.blendView.nb_height);
    Up_WeakSelf_wsf;
    [UIView animateWithDuration:3 animations:^{
        [wsf.maskView setFrame:CGRectMake(wsf.contentView.nb_right, 0, wsf.maskView.nb_width, wsf.maskView.nb_height)];
    } completion:^(BOOL finished) {
        wsf.blendView.maskView = nil;
        [wsf.blendView removeFromSuperview];
    }];
#else
    self.cacheOriginalImgView.alpha = .5;
    self.contentView.maskView = self.maskView;
    self.maskView.frame = CGRectMake(0, 0, self.maskView.nb_width, self.maskView.nb_height);
    [UIView animateWithDuration:3 animations:^{
        [self.maskView setFrame:CGRectMake(self.contentView.nb_right, 0, self.maskView.nb_width, self.maskView.nb_height)];
    } completion:^(BOOL finished) {
        self.contentView.maskView = nil;
        [self.contentView removeFromSuperview];
    }];
    
#endif

}



- (void)setLayer:(CAGradientLayer *)layer
       nameWidth:(CGFloat)nameWidth{
    if (NO) {
        CGFloat middelValue = nameWidth/ layer.bounds.size.width;
        NSArray *startLocations = @[@0,@(middelValue),@1];
        layer.locations = startLocations;
        layer.colors = @[
                         (id)[UIColor yellowColor].CGColor,
                         (id)[UIColor yellowColor].CGColor,
                         (id)[[UIColor yellowColor] colorWithAlphaComponent:0.3].CGColor,
                         ];
    }else{
        layer.locations = @[@0,@1];
        layer.colors = @[
                         (id)[UIColor yellowColor].CGColor,
                         (id)[[UIColor yellowColor] colorWithAlphaComponent:0].CGColor,
                         ];
    }
    layer.startPoint = CGPointMake(0,.5);
    layer.endPoint = CGPointMake(1,.5);
}


@end
