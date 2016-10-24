//
//  UIButton+block.h
//  pengpeng
//
//  Created by 朴明德 on 14-5-29.
//  Copyright (c) 2014年 AsiaInnovations. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kUIButtonBlockTouchUpInside @"TouchInside"
@interface UIButton (block)

@property(nonnull,nonatomic,strong) NSMutableDictionary *actions;
- (void)setAction:(NSString*)action withBlock:(void(^)())block;
- (void)setParam:(NSMutableDictionary *)params;
- (NSMutableDictionary*)param;

@end
