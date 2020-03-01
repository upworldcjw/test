//
//  BGPhotoPreviewCell.m
//  TestLayout
//
//  Created by JianweiChen on 2018/10/28.
//  Copyright © 2018 inke. All rights reserved.
//

#import "BGPhotoPreviewCell.h"

@implementation BGPhotoPreviewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        NSLog(@"BGPhotoPreviewCell %@",NSStringFromCGRect(frame));
        
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:imgView];
        imgView.clipsToBounds = YES;
        self.imgView = imgView;
        
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.text = @"10";
        [self.contentView addSubview:label];
        label.backgroundColor = [UIColor redColor];
        self.label = label;
        
        [self shrinkLayout];
//        [self.contentView setClipsToBounds:YES];
    }
    return self;
}

- (void)setModel:(CellModel *)model{
    _model = model;
    [_imgView setImage:[UIImage imageNamed:model.imgName]];
    
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            if (model.expand) {
//                [self shrinkLayout];
//                [UIView animateWithDuration:0.3 animations:^{
//                    [self expandLayout];
//                }completion:^(BOOL finished) {
//                    NSLog(@"%d",finished);
//                }];
//            }else{
//                [self expandLayout];
//                [UIView animateWithDuration:0.3 animations:^{
//                    [self shrinkLayout];
//                }completion:^(BOOL finished) {
//                    NSLog(@"%d",finished);
//                }];
//            }
//        });
}

- (void)doAnimation {
    if (self.animation) {
        return;
    }
    self.animation = YES;
//    [self.label.layer removeAllAnimations];
    [self innerAnimation];
}

- (void)innerAnimation {
    CFAbsoluteTime beginTime = CACurrentMediaTime();
    [UIView animateWithDuration:0.6 animations:^{
        self.label.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        NSLog(@"cjw cjw %f",CACurrentMediaTime() - beginTime);
        [UIView animateWithDuration:0.6 animations:^{
            self.label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [self innerAnimation];
        }];
    }];
}
- (void)expandLayout{
    [self.imgView setFrame:CGRectMake(0, 0, 120, 120)];
//    [self.label setFrame:CGRectMake(0, 120, 60, 20)];
}

- (void)shrinkLayout{
    [self.imgView setFrame:CGRectMake(0, 0, 60, 60)];
    [self.label setFrame:CGRectMake(0, 60, 60, 20)];
}

- (void)setText:(NSString *)text{
    self.label.text = text;
}

- (void)prepareForReuse{
    [super prepareForReuse];
    NSLog(@"cjw prepareForReuse %p",self);
}

//- (void)setNeedsLayout{
//    [super setNeedsLayout];
//    [self layoutIfNeeded];
//}
//
//- (void)updateConstraints{
//    [self layoutIfNeeded];
//    [super updateConstraints];
//}

@end
