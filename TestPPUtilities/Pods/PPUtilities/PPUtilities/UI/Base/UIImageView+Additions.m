//
//  UIImageView+Additions.m
//  pengpeng
//
//  Created by Leonine on 13-10-17.
//  Copyright (c) 2013年 AsiaInnovations. All rights reserved.
//

#import "UIImageView+Additions.h"

@implementation UIImageView(AnimationImgs)
-(void)setImageNameArr:(NSArray *)imgArr{
    NSMutableArray *imgs = [NSMutableArray array];
    for (int i = 0; i < imgArr.count; i++) {
        UIImage *image = [UIImage imageNamed:[imgArr objectAtIndex:i]];
        [imgs addObject:image];
    }
    self.animationImages = imgs;
    self.animationDuration = 2;
}
@end

