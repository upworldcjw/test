//
//  SwitchButton.m
//
//
//  Created by 孙西纯 on 15/11/5.
//
//

#import "IKSwitchButton.h"
#import "IKThemeDefine.h"

@interface IKSwitchButton ()

@property(nonatomic, copy)   IKSwitchActionBlock actionBlock;
@property(nonatomic, strong) UILabel             *label;
@property(nonatomic, strong) UIColor             *onColor;

@end

@implementation IKSwitchButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _label = [[UILabel alloc] init];
        [_label setTextAlignment:NSTextAlignmentCenter];
        [_label setBackgroundColor:mIKColor_1];
        _label.font = [UIFont boldSystemFontOfSize:10];
        _label.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_label];
        
        [self _setState:NO];
        [self _setCornradio:frame.size.height/2];
        [self setOnColor:[UIColor purpleColor]];
        [self addTarget:self action:@selector(_action:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)setTitle:(NSString*)title
{
    _label.text = title;
}
- (void)setActionBlock:(IKSwitchActionBlock)block
{
    _actionBlock = block;
}

- (void)setOnStateColor:(UIColor*)color
{
    _onColor = color;
}

- (void)setOn:(BOOL)on {
    _on = on;
    [self _setState:on];
    if(_actionBlock) _actionBlock(_on);
}

#pragma mark 私有方法

- (void)_setState:(BOOL)on
{
    CGFloat contentOffset = 2;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    if (on) {
        _label.frame = CGRectMake(width - contentOffset - (height - contentOffset * 2), contentOffset, height - contentOffset * 2, height - contentOffset * 2);
        [_label setTextColor:_onColor];
        _label.backgroundColor = [UIColor whiteColor];
        [self setBackgroundColor:_onColor];
    } else {
        _label.frame = CGRectMake(contentOffset, contentOffset, height - contentOffset * 2, height - contentOffset * 2);
        [_label setTextColor:[UIColor colorWithRed:0.796 green:0.827 blue:0.843 alpha:1.000]];
        _label.backgroundColor = [UIColor whiteColor];
        [self setBackgroundColor:[UIColor colorWithRed:0.796 green:0.827 blue:0.843 alpha:1.000]];
    }
}

- (void)_setCornradio:(CGFloat)cornradio {
    self.layer.cornerRadius = cornradio;
    _label.layer.cornerRadius = _label.frame.size.height/2;
    self.layer.masksToBounds = YES;
    _label.layer.masksToBounds = YES;
}

- (void)_action:(UIGestureRecognizer*)sender {
    _on = !_on;
    
    if (_actionBlock) {
        _actionBlock(_on);
    }
    
    
    [UIView animateWithDuration:0.1 animations:^{
        [self _setState:_on];
    }];
}

- (void)dealloc {
    _actionBlock = nil;
}
@end
