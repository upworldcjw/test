//
//  IKTLPersonalContentView.m
//  inke
//
//  Created by JianweiChen on 2018/5/30.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import "IKTLPersonalSimpleContentView.h"
#import "IKTLPersonalSimpleCollectionCell.h"
#import "PublicHeader.h"

static NSString *const kPersonalTLCell = @"IKTLPersonalSimpleCollectionCell";

@interface IKTLPersonalSimpleContentView ()<
IKTLPersonalInfoViewDelegate,
UIGestureRecognizerDelegate
>

@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, assign) BOOL panActive;

@end

@implementation IKTLPersonalSimpleContentView

- (void)dealloc{
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat height = 213;
        [self.layer addSublayer:self.gradientLayer];
        self.userInfoView = [[IKTLPersonalSimpleInfoView alloc] initWithFrame:CGRectMake(0, kScreenHeight - height, frame.size.width, height)];
        self.userInfoView.delegate = self;
        [self addSubview:self.userInfoView];
       
        [self loadCollectionView];
        [self registerCell];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        pan.delegate = self;
        [self addGestureRecognizer:pan];
        self.pan = pan;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
        [tap requireGestureRecognizerToFail:pan];
        tap.delegate = self;
        self.tap = tap;
        self.panActive = YES;
    }
    return self;
}

- (CAGradientLayer *)gradientLayer{
    if (_gradientLayer == nil) {
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)IKHexColor(0x000000,0.0).CGColor,
                                 (__bridge id)IKHexColor(0x000000,0.4).CGColor,
                                 (__bridge id)IKHexColor(0x000000,0.6).CGColor];
        gradientLayer.locations = @[@0.0,@0.5, @1];
        gradientLayer.startPoint = CGPointMake(0.5, 0);
        gradientLayer.endPoint = CGPointMake(0.5, 1);
        _gradientLayer = gradientLayer;
    }
    return _gradientLayer;
}


- (BOOL)tapAtTop{
    CGPoint point = [self.tap locationInView:self.tap.view];
    if (point.y <= self.userInfoView.top) {
        return YES;
    }
    return NO;
}

- (void)tapAction:(UITapGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if ([self tapAtTop]) {
            if (self.dismissBlock) {
                self.dismissBlock();
            }
        }
    }
}

- (void)panAction:(UIPanGestureRecognizer *)pan {
    if (pan == self.pan) {
//        NSLog(@"cjw cjw %ld %f",(long)pan.state,self.collectionView.contentOffset.y);
        if(pan.state == UIGestureRecognizerStateBegan){
            CGPoint point = [pan locationInView:self];
            if (CGRectContainsPoint(self.collectionView.frame, point)) {
                if (self.collectionView.contentOffset.y > 0) {
                    self.panActive = NO;
                    return;
                }else if (self.collectionView.contentOffset.y == 0){
                    CGPoint velocity = [pan velocityInView:self];
                    if (velocity.y < 0) {
                        self.panActive = NO;
                        return;
                    }
                }
            }
        }
        
        if (!self.panActive) {
            if (pan.state == UIGestureRecognizerStateCancelled ||
                pan.state == UIGestureRecognizerStateEnded) {
                self.panActive = YES;
            }
            return;
        }
        CGPoint point = [pan translationInView:self.collectionView];
        switch (pan.state) {
            case UIGestureRecognizerStateChanged:
                 self.collectionView.panGestureRecognizer.enabled = NO;
                break;
            case UIGestureRecognizerStateCancelled:
            case UIGestureRecognizerStateEnded:
                self.collectionView.panGestureRecognizer.enabled = YES;
                break;
            default:
                break;
        }
        if (self.contentDragBlock) {
            self.contentDragBlock(pan.state, point.y);
        }
        [pan setTranslation:CGPointZero inView:self];
    }
}

- (void)setUserInfo:(UserInfo *)userInfo{
    _userInfo = userInfo;
    self.userInfoView.userInfo = userInfo;
}

- (void)registerCell {
    [self.collectionView registerClass:[IKTLPersonalSimpleCollectionCell class] forCellWithReuseIdentifier:kPersonalTLCell];
}

- (void)loadCollectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout =
        [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)
                                             collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        [self addSubview:_collectionView];
    }
}

- (NSArray *)tlPersonalDataArray{
    return [self.dataSource dataSourceForContentView:self];
}

- (void)reload{
    if ([self tlPersonalDataArray].count >= 1) {
        self.userInfoView.bottomLineView.hidden = NO;
        self.collectionView.hidden = NO;
        [self.collectionView reloadData];
//        [self.collectionView setNeedsLayout];
//        [self.collectionView layoutIfNeeded];
        //下面代码是修复contentSize太小，顶部收缩动画有问题
        CGFloat contentHeight = MIN(self.collectionView.collectionViewLayout.collectionViewContentSize.height, 3*[IKTLPersonalSimpleCollectionCell properSize].height + 2*6);
        CGFloat topHeight = self.userInfoView.properHeight + contentHeight;
        if(topHeight > kScreenHeight){
            contentHeight = contentHeight - (topHeight - kScreenHeight);
        }
        self.userInfoView.originY = kScreenHeight - topHeight;
        self.collectionView.originY = kScreenHeight - contentHeight;
        self.collectionView.height = contentHeight;
        self.gradientLayer.frame = CGRectMake(0, kScreenHeight - topHeight, kScreenWidth, topHeight);
        
        [self.collectionView reloadData];
    }else{
        self.userInfoView.bottomLineView.hidden = YES;
        self.collectionView.hidden = YES;
        self.userInfoView.originY = kScreenHeight - self.userInfoView.properHeight;
        self.gradientLayer.frame = CGRectMake(0, kScreenHeight - self.userInfoView.properHeight , kScreenWidth, self.userInfoView.properHeight);
        [self.collectionView reloadData];
    }
}

- (void)reloadItems {
    [self reload];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.collectionView.isDragging || self.collectionView.decelerating || self.collectionView.tracking) {
            return;
        }
        [self preLoadVideo];
    });
}

#pragma mark -  IKTLPersonalInfoViewDelegate

- (void)personalInfoView:(UIView *)infoView needChangeHeight:(CGFloat)height{
    self.userInfoView.height = height;
    self.collectionView.originY = height;
    [self reload];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tlPersonalDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        IKTLPersonalSimpleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPersonalTLCell forIndexPath:indexPath];
        [cell setTimeLineFrame:self.tlPersonalDataArray[indexPath.row]];
        return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate contentView:self didSelected:indexPath.row];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    IKTimeLineItemFrame *frame = self.tlPersonalDataArray[indexPath.row];
    return [IKTLPersonalSimpleCollectionCell properSize];
}

#pragma - mark UICollectionViewDataSource

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {

}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return  [IKTLPersonalSimpleCollectionCell margin];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return [IKTLPersonalSimpleCollectionCell margin];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(6, 6, 0, 6);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self preLoadVideo];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self preLoadVideo];
}

- (void)preLoadVideo{

}

- (BOOL)beyondThreshold{
    return self.collectionView.contentOffset.y >= self.userInfoView.height;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"cjw cjw %f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y <= 0) {
        scrollView.contentOffset = CGPointZero;
    }else{
        
    }
}

#pragma mark - UIGestureRecognizerDelegate
//如果返回手势识别的话，就不识别此手势
- (BOOL)isInteractiveGestureAble{
    UIPanGestureRecognizer *pan = [self pan];
    CGPoint point = [pan translationInView:pan.view];
    if (point.x > 0 && fabs(point.x)/fabs(point.y) >= 1) {
        return YES;
    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer == self.pan) {
        if ([otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
            if (otherGestureRecognizer == self.collectionView.panGestureRecognizer) {
                return YES;
            }
            return [self isInteractiveGestureAble];
        }
    }
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if(gestureRecognizer == self.pan){
        return ![self isInteractiveGestureAble];
    }else if(gestureRecognizer == self.tap){
        if (![self tapAtTop]) {//点击非顶部区域，屏蔽tap
            return NO;
        }
    }
    return YES;
}

//#pragma mark - EmptyDataDelegate

//- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
//    return [UIImage imageNamed:@"default_feed_empty"];
//}
//
//- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
//    NSString *text = @"";
//    if([IKBMModelFactory sharedInstance].user.me.uid == self.userInfo.uid){
//        text = @"快去发布动态吧";
//    }else{
//        text = @"对方还未发布动态";
//    }
//    NSDictionary *attributes = @{
//                                 NSFontAttributeName: [UIFont systemFontOfSize:15 weight:UIFontWeightLight],
//                                 NSForegroundColorAttributeName: ColorWithKey(ThemeKey27)
//
//                                 };
//
//    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//}
//
//- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
//    return YES;
//}
//
//- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
//    return self.userInfoView.height/2.0;
//}


@end
