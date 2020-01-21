//
//  IKSubTabCollectionViewCell.m
//  inke
//
//  Created by Vincent on 2018/5/4.
//  Copyright © 2018年 MeeLive. All rights reserved.
//

#import "IKSubTabCollectionViewCell.h"
#import "IKTLTopicGradientView.h"

static NSInteger kheight = 30;
@interface IKSubTabCollectionViewCell ()

@property (nonatomic,strong) IKTLTopicGradientView *gradientView;
@property (nonatomic,strong) UILabel *tabTitleLab;

@end

@implementation IKSubTabCollectionViewCell

+ (CGFloat)widthForText:(NSString *)text{
    return [text ik_sizeWithFont:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(CGFLOAT_MAX, 40)].width + 16*2;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self.contentView addSubview:self.gradientView];
    [self.contentView addSubview:self.tabTitleLab];
    [self.gradientView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self.tabTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}

- (void)setSubTabCellWithModel:(IKSubDynamicTabModel *)subTabModel {
    self.tabTitleLab.text = subTabModel.title;
}

- (void)setColorBegin:(UIColor *)colorBegin colorEnd:(UIColor *)endColor{
    self.gradientView.startColor = colorBegin;
    self.gradientView.endColor = endColor;
    [self.gradientView setNeedsDisplay];
}

- (IKTLTopicGradientView *)gradientView{
    if (!_gradientView) {
        _gradientView = [[IKTLTopicGradientView alloc] initWithStyle:IKTLGradientLeft2RightStyle];
        _gradientView.layer.cornerRadius = kheight/2.0;
        _gradientView.layer.masksToBounds = YES;
        _gradientView.startColor = [kColorWith16RGB(0x06d1f5) colorWithAlphaComponent:1];
        _gradientView.endColor = [kColorWith16RGB(0x1ceacb) colorWithAlphaComponent:1];
    }
    return _gradientView;
}

- (UILabel *)tabTitleLab {
    if (!_tabTitleLab) {
        _tabTitleLab = [[UILabel alloc] init];
        _tabTitleLab.font = kBoldFontWithSize(14);
        _tabTitleLab.textColor = k16RGBColor(0xFFFFFF);
        _tabTitleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _tabTitleLab;
}

@end
