//
//  IKScrollView.m
//  inke
//
//  Created by Chenxiaocheng on 15/7/21.
//  Copyright (c) 2015年 inke. All rights reserved.
//

#import "IKScrollView.h"

@interface IKScrollView () {
}

@property(nonatomic, strong) NSArray *views;

@end

@implementation IKScrollView

- (id)init
{
    self = [super init];
    
    if (self) {
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    
    return self;
}

+ (id)initWithPageNumber:(NSInteger)number views:(NSArray *)views frame:(CGRect)frame
{
    IKScrollView *scroll = [[IKScrollView alloc] init];
    scroll.views = views;
    
    [scroll setFrame:frame];
    [scroll setContentSize:CGSizeMake(frame.size.width * number, frame.size.height)];
    
    for (NSInteger i = 0; i < number; i++) {
        UIView *subView = (UIView *)[views objectAtIndex:i];
        [subView setFrame:CGRectMake(i * frame.size.width, frame.origin.y, frame.size.width, frame.size.height)];
        [scroll addSubview:subView];
    }
    
    scroll.bounces = NO;
    return scroll;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setContentSize:CGSizeMake(frame.size.width * _views.count, frame.size.height)];
    NSInteger index = 0;
    for (UIView *view in _views) {
        [view setFrame:CGRectMake(index * frame.size.width, 0, frame.size.width, frame.size.height)];
        index++;
    }
}

@end
