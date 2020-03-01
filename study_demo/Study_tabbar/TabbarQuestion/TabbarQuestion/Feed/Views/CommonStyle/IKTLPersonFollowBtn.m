//
//  IKTLPersonFollowBtn.m
//  inke
//
//  Created by JianweiChen on 2018/6/1.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import "IKTLPersonFollowBtn.h"
#import "PublicHeader.h"

@interface IKTLPersonFollowBtn ()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation IKTLPersonFollowBtn

+ (instancetype)personalFollowBtnWithFrame:(CGRect)frame{
    IKTLPersonFollowBtn *btn = [self buttonWithType:UIButtonTypeCustom];
    [btn setFrame:frame];
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    btn.layer.cornerRadius = frame.size.height/2.0;
    btn.layer.borderWidth = 0.5;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = IKHexColor(0xfffffff, 1);
    btn.layer.borderColor = IKHexColor(0xccccccc, 1).CGColor;
    [btn.layer insertSublayer:btn.gradientLayer atIndex:0];
    [btn.gradientLayer setFrame:btn.bounds];
    return btn;
}

- (void)refreshFollowBtn:(BOOL)follow{
    if(follow){
        self.gradientLayer.hidden = YES;
        self.layer.borderColor = IKHexColor(0xccccccc, 1).CGColor;
        [self setImage:[UIImage imageNamed:@"ik_personal_follow"] forState:UIControlStateNormal];
        [self setTitle:@"已关注" forState:UIControlStateNormal];
        [self setTitleColor:IKHexColor(0xaaaaaa, 1) forState:UIControlStateNormal];
        [self.layer insertSublayer:self.gradientLayer atIndex:0];
    }else{
//        self.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.gradientLayer.hidden = NO;
        [self setImage:[UIImage imageNamed:@"ik_personal_not_follow"] forState:UIControlStateNormal];
        [self setTitle:@"关注" forState:UIControlStateNormal];
        [self setTitleColor:IKHexColor(0xffffff, 1) forState:UIControlStateNormal];
        [self.layer insertSublayer:self.gradientLayer atIndex:0];
    }
}

- (CAGradientLayer *)gradientLayer{
    if (_gradientLayer == nil) {
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)IKHexColor(0x11e4d3,1).CGColor,
                                 (__bridge id)IKHexColor(0x01c3cf,1).CGColor];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
//        [followButton.layer addSublayer:gradientLayer];
        gradientLayer.frame = CGRectMake(0, 0, 45, 30);
        _gradientLayer = gradientLayer;
    }
    return _gradientLayer;
}

@end

@implementation IKTLPersonActionBtn

+ (instancetype)personalActonButtonWithSize:(CGSize)size{
    IKTLPersonActionBtn *btn = [self buttonWithType:UIButtonTypeCustom];
    CGRect rect = CGRectZero;
    rect.size = size;
    [btn setFrame:rect];
    
    [btn setTitleColor:IKHexColor(0x333333, 1) forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    btn.layer.cornerRadius = size.height/2.0;
    btn.layer.borderWidth = 0.5;
    btn.backgroundColor = IKHexColor(0xfffffff, 1);
    btn.layer.borderColor = IKHexColor(0xccccccc, 1).CGColor;
    return btn;
}

- (void)setImage:(UIImage *)img title:(NSString *)title{
    [self setImage:img forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateNormal];
}
@end
