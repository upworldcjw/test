//
//  BaseView.m
//  TestChain
//
//  Created by jianwei.chen on 15/8/24.
//  Copyright (c) 2015年 jianwei.chen. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        label = [UILabel new];
        [self addSubview:label];
        [label setFrame:self.bounds];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = NSStringFromClass([self class]);
    }
    return self;
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"%@ %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
    return [super pointInside:point withEvent:event];
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"%@ %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
    return [super hitTest:point withEvent:event];
}
@end
