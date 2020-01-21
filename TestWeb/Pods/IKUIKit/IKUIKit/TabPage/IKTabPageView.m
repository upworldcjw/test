//
//  IKTabPageView.m
//  inke
//
//  Created by Chenxiaocheng on 15/7/21.
//  Copyright (c) 2015年 inke. All rights reserved.
//

#import "IKTabPageView.h"
#import "IKScrollView.h"
#import <IKFoundation/IKFoundation.h>
#import "IKLog.h"

@interface IKTabPageView ()<UIScrollViewDelegate> {
    IKScrollView *_scroll;
    UIView *_tabTitleView;
    
    CGFloat _width;
    CGFloat _tabHeight;
    NSArray *_views;
    NSArray *_titles;
    
    NSInteger _tabCount;
    NSInteger _lastSelectIndex;
    CGFloat _lastOffsetX;
    NSUInteger _beginIndex;
    BOOL _isDragging;
}

@end

@implementation IKTabPageView

- (id)initWithPageViews:(NSArray *)views frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _width = frame.size.width;
        _tabCount = views.count;
        _views = views;
        _lastSelectIndex = -1;
        _tabColor = [UIColor lightGrayColor];
        _tabSelectedColor = [UIColor greenColor];
    }
    
    [self _setup];
    
    return self;
}

- (id)initWithPageViews:(NSArray *)views titles:(NSArray *)titles tabHeight:(CGFloat)height frame:(CGRect)frame;
{
    if (titles.count != views.count && height > 0) {
        @throw [NSException
                exceptionWithName:NSInvalidArgumentException
                reason:[NSString
                        stringWithFormat:@"titles(%d) is not views(%d)",
                        (int)titles.count,
                        (int)views.count]
                userInfo:nil];
    }
    
    self = [super initWithFrame:frame];
    
    if (self) {
        _width = frame.size.width;
        _tabHeight = height;
        _tabCount = views.count;
        _titles = titles;
        _views = views;
        _lastSelectIndex = -1;
        _tabColor = [UIColor lightGrayColor];
        _tabSelectedColor = [UIColor greenColor];
    }
    
    [self _setup];
    
    return self;
}

- (NSUInteger)selectedIndex
{
    return _lastSelectIndex;
}

- (void)setTabColor:(UIColor *)tabColor
{
    _tabColor = tabColor;
    [self _setSelected:_lastSelectIndex];
}

- (void)setTabSelectedColor:(UIColor *)tabSelectedColor
{
    _tabSelectedColor = tabSelectedColor;
    [self _setSelected:_lastSelectIndex];
}

- (void)setSelectedTabIndex:(NSInteger)selectedIndex
{
    [self setSelectedTabIndex:selectedIndex animated:YES];
}

- (void)setSelectedTabIndex:(NSInteger)selectedIndex animated:(BOOL)animated
{
    _isDragging = NO;
    [self updateScrollingState];
    if (_lastSelectIndex == selectedIndex) {
        return;
    }
    
    [_scroll setContentOffset:CGPointMake(_width * selectedIndex, 0)
                     animated:animated];
    [self _setSelected:selectedIndex];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _width = frame.size.width;
    [_scroll setFrame:frame];
    [_scroll setContentOffset:CGPointMake(_width * _lastSelectIndex, 0)
                     animated:NO];
}

- (void)_setup
{
    CGRect frame = self.bounds;
    
    // 当tabHeight大于0的时候才有tab项
    if (_tabHeight > 0) {
        _tabTitleView = [[UIView alloc]
                         initWithFrame:CGRectMake(0, 0, frame.size.width, _tabHeight)];
        
        NSInteger singleWidth = frame.size.width / _tabCount;
        
        for (NSInteger i = 0; i < _tabCount; i++) {
            UIButton *tabButton =
            [[UIButton alloc] initWithFrame:CGRectMake(i * singleWidth, 0, singleWidth, _tabHeight)];
            tabButton.tag = i;
            [tabButton setTitle:[_titles objectAtIndex:i] forState:UIControlStateNormal];
            [tabButton addTarget:self action:@selector(tabClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            [_tabTitleView addSubview:tabButton];
        }
        
        [self addSubview:_tabTitleView];
    }
    
    frame.size.height -= _tabHeight;
    _scroll = [IKScrollView initWithPageNumber:_tabCount views:_views frame:frame];
    _scroll.scrollsToTop = NO;
    
    frame.origin.y += _tabHeight;
    [_scroll setFrame:frame];
    _scroll.delegate = self;
    
    [self addSubview:_scroll];
    [self _setSelected:_lastSelectIndex];
}

- (void)tabClicked:(id)sender
{
    IKLog(@"tabClicked %@", sender);
    
    NSInteger tag = ((UIButton *)sender).tag;
    
    if (_lastSelectIndex == tag) {
        return;
    }
    
    [_scroll setContentOffset:CGPointMake(_width * tag, 0) animated:YES];
    
    
    self.pageType = IKTabPageTypeClick;
    [self _setSelected:tag];
}

- (void)_setSelected:(NSInteger)selectedIndex
{
    _lastSelectIndex = selectedIndex;
    
    for (UIButton *subButton in [_tabTitleView subviews]) {
        if (subButton.tag == selectedIndex) {
            [subButton setBackgroundColor:_tabSelectedColor];
        } else {
            [subButton setBackgroundColor:_tabColor];
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabPageView:didChangeTabToIndex:)]) {
        [self.delegate tabPageView:self didChangeTabToIndex:_lastSelectIndex];
    }
}

- (void)updateScrollingState
{
    if ([self.delegate respondsToSelector:@selector(tabPageView:isScrolling:)]) {
        [self.delegate tabPageView:self isScrolling:_isDragging];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat nowOffsetX = scrollView.contentOffset.x;
    if ([self.delegate respondsToSelector:@selector(tabPageView:isRightDirection:offsetX:)] && _isDragging) {
        BOOL isRightDirection = nowOffsetX > _lastOffsetX;
        [self.delegate tabPageView:self isRightDirection:isRightDirection offsetX:nowOffsetX];
    }
    _lastOffsetX = nowOffsetX;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    IKLog(@"scrollViewDidEndScrollingAnimation");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    IKLog(@"scrollViewDidEndDragging");
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    IKLog(@"scrollViewWillEndDragging %f", scrollView.contentOffset.x);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    IKLog(@"scrollViewDidEndDecelerating %f  %f", scrollView.contentOffset.x, scrollView.contentOffset.x / _width);
    
    NSInteger selectedIndex = (int)scrollView.contentOffset.x / (int)_width;
    
    if (_lastSelectIndex == selectedIndex) {
        return;
    }
    
    self.pageType = IKTabPageTypeScroll;
    [self _setSelected:selectedIndex];
    _isDragging = NO;
    [self updateScrollingState];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    IKLog(@"scrollViewWillBeginDragging %f", scrollView.contentOffset.x);
    //    _beginningOffsetX = scrollView.contentOffset.x;
    //    _beginIndex = (int)scrollView.contentOffset.x / (int)_width;
    _isDragging = YES;
    [self updateScrollingState];
    _beginIndex = ceil(scrollView.contentOffset.x / _width);
}

@end
