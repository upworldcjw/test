//
//  IKTLPersonalMaskView.m
//  inke
//
//  Created by JianweiChen on 2018/5/30.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import "IKTLPersonalMaskView.h"
#import "PublicHeader.h"
#import <Masonry/Masonry.h>
@interface IKTLPersonalMaskView ()

@property (nonatomic, strong) UIImageView *imgView;

@end


@implementation IKTLPersonalMaskView

+ (CGFloat)properHeight{
    return 64 + (gIsIphoneX() ? 44 : 0);
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imgView = [UIImageView new];
        [self.imgView setContentMode:UIViewContentModeScaleAspectFit];
        [self.imgView setImage:[UIImage imageNamed:@"iktl_personal_arrow"]];
        [self addSubview:self.imgView];
        
        [self configLayout];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTouch:)];
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}

- (void)configLayout{
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

- (void)tapTouch:(UITapGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if (self.tapBlock) {
            self.tapBlock();
        }
    }
}

@end
