//
//  ULAvatarView.m
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/28.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import "ULAvatarView.h"
//
//@property (nonatomic,strong) UIImageView *imgView;
//@property (nonatomic,strong) UILabel     *nameLabel;

@implementation ULAvatarView

- (void)dealloc{
    NSLog(@"ULAvatarView dealloc");
}

- (instancetype)initWithImgSize:(CGSize)imgSize andName:(NSString *)name{
    if (self = [super initWithFrame:CGRectZero]) {
        CGRect rect = CGRectZero;
        rect.size = imgSize;
        
        self.imgView = [[UIImageView alloc] initWithFrame:rect];
        [self.imgView setImage:[UIImage imageNamed:@"red"]];
        [self addSubview:self.imgView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        self.nameLabel.textColor =  [UIColor whiteColor];
        self.nameLabel.font = [UIFont systemFontOfSize:16];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:name attributes:@{NSStrokeWidthAttributeName:@(-1),NSStrokeColorAttributeName:[UIColor darkTextColor],NSForegroundColorAttributeName:[UIColor whiteColor]}];
//        self.nameLabel.text = str;
        self.nameLabel.attributedText = str;
        [self addSubview:self.nameLabel];
        
        [self.nameLabel sizeToFit];
        CGRect frame = self.nameLabel.frame;
        
        CGFloat margin = 5;
        frame.origin.x = self.imgView.frame.size.width + margin;
        self.nameLabel.frame = frame;
        CGPoint center = self.nameLabel.center;
        center.y = self.imgView.frame.size.height/2.0;
        self.nameLabel.center = center;
        
        frame = CGRectMake(0, 0, self.nameLabel.frame.origin.x + self.nameLabel.frame.size.width, self.imgView.frame.size.height);
        self.frame = frame;
        
//        [self setBackgroundColor:[UIColor redColor]];
    }
    return  self;
}

@end
