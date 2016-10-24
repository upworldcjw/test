//
//  JGProgressHUDPengPengIndicatorView.m
//  pengpeng
//
//  Created by ios_feng on 15/12/24.
//  Copyright © 2015年 AsiaInnovations. All rights reserved.
//

#import "JGProgressHUDPengPengIndicatorView.h"

@implementation JGProgressHUDPengPengIndicatorView

- (instancetype)initWithContentView:(UIView *__unused)contentView {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"图层_%zd", 1]]];
    NSMutableArray *animationImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=52; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"图层_%zd", i]];
        [animationImages addObject:image];
    }
    [imageView setAnimationImages:animationImages];
    [imageView setAnimationDuration:1.3];
    [imageView startAnimating];
    self = [super initWithContentView:imageView];
    
    return self;
}

- (instancetype)init {
    return [self initWithContentView:0];
}


@end
