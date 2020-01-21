//
//  IKTLPersonalContentView.m
//  inke
//
//  Created by JianweiChen on 2018/5/30.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import "IKTLPersonalContentView.h"
#import "IKPersonalFeedReusableView.h"
#import "IKTLPersonalCollectionCell.h"
#import "PublicHeader.h"

static NSString *const kPersonalTL = @"IKTimeLineCollectionCell";
static NSString *const kPersonalTLCell = @"kPersonalTLCell";
static NSString *const kPersonalHead = @"IKPersonalFeedReusableView";
static NSString *const kPersonalHeadFoot = @"UICollectionReusableView";

@interface IKTLPersonalContentView ()<
IKTLPersonalTopBarViewDelegte,
IKTLPersonalInfoViewDelegate,
UIGestureRecognizerDelegate
>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, assign) BOOL panActive;
@property (nonatomic, assign) CGFloat padHeight;

@end

@implementation IKTLPersonalContentView

- (void)dealloc{
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat height = 213;
        self.userInfoView = [[IKTLPersonalCommonInfoView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, height)];
        self.userInfoView.delegate = self;
        self.topBarView = [[IKTLPersonalTopBarView alloc] initWithFrame:CGRectMake(0, height, frame.size.width, [IKTLPersonalTopBarView properHeight])];
        [self insertSubview:self.topBarView belowSubview:self.userInfoView];
        
        self.topBarView.backgroundColor = [UIColor whiteColor];
        self.topBarView.cellModel = IKTLPersonalTopBarViewCell;
        self.topBarView.style = IKTLPersonTopBarStyleChangModel;
        self.topBarView.delegate = self;
        
        [self loadCollectionView];
        [self registerCell];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        pan.delegate = self;
        [self addGestureRecognizer:pan];
        self.pan = pan;
    }
    return self;
}

- (void)panAction:(UIPanGestureRecognizer *)pan {
    if (pan == self.pan) {
        if (!self.panActive) {
            self.collectionView.panGestureRecognizer.enabled = YES;
            return;
        }
        CGPoint point = [pan translationInView:self];
        switch (pan.state) {
            case UIGestureRecognizerStateChanged:
                 self.collectionView.panGestureRecognizer.enabled = NO;
                break;
            case UIGestureRecognizerStateCancelled:
            case UIGestureRecognizerStateEnded:
                self.collectionView.panGestureRecognizer.enabled = YES;
                self.panActive = NO;
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
    self.topBarView.userInfo = userInfo;
}

- (void)registerCell {
    [self.collectionView registerClass:[IKPersonalFeedReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kPersonalHead];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kPersonalHeadFoot];
    [self.collectionView registerClass:[IKTLPersonalCollectionCell class] forCellWithReuseIdentifier:kPersonalTLCell];
}

- (void)loadCollectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout =
        [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds
                                             collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        [self addSubview:_collectionView];
    }
}

- (NSArray *)tlPersonalDataArray{
    return [self.dataSource dataSourceForContentView:self];
}

- (void)loadEmptyView{
//    self.collectionView.emptyDataSetSource = self;
//    self.collectionView.emptyDataSetSource = self;
}

- (void)reload{
    if ([self tlPersonalDataArray].count >= 1) {
        [self.collectionView reloadData];
//        [self.collectionView setNeedsLayout];
//        [self.collectionView layoutIfNeeded];
        //下面代码是修复contentSize太小，顶部收缩动画有问题
        CGFloat topHeight = self.userInfoView.properHeight + self.collectionView.bounds.size.height;
        CGFloat contentHeight = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
        if (contentHeight - self.padHeight < topHeight) {
            self.padHeight = topHeight - (contentHeight - self.padHeight);
        }else{
            self.padHeight = 0;
        }
        [self.collectionView reloadData];
    }else{
        self.padHeight = 0;
        [self.collectionView reloadData];
    }
}

- (void)reloadItems {
    [self stopPlayingCell];
    [self reload];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.collectionView.isDragging || self.collectionView.decelerating || self.collectionView.tracking) {
            return;
        }
//        NSLog(@"cjw cjw reloadItems");
        [self findVisibleVideoCell];
        [self preLoadVideo];
    });
}

- (void)stopPlayingCell{

}

#pragma mark - IKTLPersonalTopBarViewDelegte
- (void)personalTopBarViewClik:(IKTLPersonalTopBarView *)topBar{
    if (self.topBarView.cellModel == IKTLPersonalTopBarViewList) {
        self.topBarView.cellModel = IKTLPersonalTopBarViewCell;
    }else{
        self.topBarView.cellModel = IKTLPersonalTopBarViewList;
    }
    [self reload];
}

#pragma mark -  IKTLPersonalInfoViewDelegate

- (void)personalInfoView:(UIView *)infoView needChangeHeight:(CGFloat)height{
    self.userInfoView.height = height;
    self.topBarView.originY = height;
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
        IKTLPersonalCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPersonalTLCell forIndexPath:indexPath];
        [cell setTimeLineFrame:self.tlPersonalDataArray[indexPath.row]];
        if ((indexPath.row + 1) % 3 == 0) {
            cell.leftLineView.hidden = YES;
        }else{
            cell.leftLineView.hidden = NO;
        }
        return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate contentView:self didSelected:indexPath.row];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [IKTLPersonalCollectionCell properSize];
}

#pragma - mark UICollectionViewDataSource

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CGFloat height = self.userInfoView.properHeight + [IKTLPersonalTopBarView properHeight];
        if (self.headerView == nil) {
            self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
            [self.headerView addSubview:self.userInfoView];
            [self.headerView addSubview:self.topBarView];
        }else{
            self.headerView.frame = CGRectMake(0, 0, kScreenWidth, height);
        }
        IKPersonalFeedReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kPersonalHead forIndexPath:indexPath];
        [headerView addSubview:self.headerView];
        return headerView;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView *padView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kPersonalHeadFoot forIndexPath:indexPath];
        padView.backgroundColor = [UIColor clearColor];
        return padView;
    }
    return nil;
}

-  (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGFloat height = self.userInfoView.properHeight + [IKTLPersonalTopBarView properHeight];
    return CGSizeMake(kScreenWidth, height);
}

-  (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGFloat height = self.padHeight;
    return CGSizeMake(kScreenWidth, height);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

- (void)adjustHeader{
    if (![self beyondThreshold]) {
        if ([self rate] < 0.5) {
            [self.collectionView setContentOffset:CGPointZero animated:YES];
        }else{
            [self.collectionView setContentOffset:CGPointMake(0, self.userInfoView.height) animated:YES];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        if (self.topBarView.cellModel == IKTLPersonalTopBarViewList) {
            [self findVisibleVideoCell];
        }
        [self preLoadVideo];
//        NSLog(@"cjw cjw scrollViewDidEndDragging");
        [self adjustHeader];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.topBarView.cellModel == IKTLPersonalTopBarViewList) {
        [self findVisibleVideoCell];
    }
    [self preLoadVideo];
//    NSLog(@"cjw cjw scrollViewDidEndDecelerating");
    [self adjustHeader];
}

- (void)preLoadVideo{
    if (self.topBarView.cellModel == IKTLPersonalTopBarViewList) {
        if ([self.delegate respondsToSelector:@selector(contentViewEndScroll:)]) {
             [self.delegate contentViewEndScroll:self];
        }
        return;
    }
}

- (void)findVisibleVideoCell{
    if (self.topBarView.cellModel == IKTLPersonalTopBarViewCell) {
        return;
    }
}

- (void)view:(UIView *)view fromRect:(CGRect)rect toRect:(CGRect)toRect rate:(CGFloat)rate{
    CGFloat desX = (toRect.origin.x - rect.origin.x)*rate + rect.origin.x;
    CGFloat desY = (toRect.origin.y - rect.origin.y)*rate + rect.origin.y;
    CGFloat desHeight = (toRect.size.height - rect.size.height) * rate + rect.size.height;
    CGFloat desWidth = (toRect.size.width - rect.size.width) * rate + rect.size.width;
    
    NSString *key = [NSString stringWithFormat:@"%p",view];
    CGFloat duration = 0.01;
    CGPoint fromPoint = view.layer.presentationLayer.position;
//    NSLog(@"cjw cjw point %@",NSStringFromCGPoint(fromPoint));
    
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:fromPoint];
    animation.toValue =  [NSValue valueWithCGPoint:CGPointMake(desX+desWidth/2.0, desY+desHeight/2.0)];
    animation.duration  = duration;
    animation.autoreverses = NO;
    animation.fillMode =kCAFillModeForwards;
    animation.removedOnCompletion = NO;

    NSNumber *currentScaleX = [view.layer.presentationLayer valueForKeyPath: @"transform.scale.x"];
//    NSLog(@"cjw cjw scaleX %@",currentScaleX);
    CABasicAnimation *scaleAnimationX =  [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleAnimationX.fromValue = currentScaleX;
    scaleAnimationX.toValue =  [NSNumber numberWithFloat: desWidth/rect.size.width];
    scaleAnimationX.duration  = duration;
    scaleAnimationX.autoreverses = NO;
    scaleAnimationX.fillMode =kCAFillModeForwards;
    scaleAnimationX.removedOnCompletion = NO;
    
    NSNumber *currentScaleY = [view.layer.presentationLayer valueForKeyPath: @"transform.scale.y"];
//    NSLog(@"cjw cjw scaleY %@",currentScaleY);
    CABasicAnimation *scaleAnimationY =  [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleAnimationY.fromValue = currentScaleY;
    scaleAnimationY.toValue =  [NSNumber numberWithFloat: desHeight/rect.size.height];
    scaleAnimationY.duration  = duration;
    scaleAnimationY.autoreverses = NO;
    scaleAnimationY.fillMode =kCAFillModeForwards;
    scaleAnimationY.removedOnCompletion = NO;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    [animationGroup setAnimations:@[animation,scaleAnimationX,scaleAnimationY]];
    animationGroup.duration = duration;
    animationGroup.autoreverses = NO;
    animationGroup.fillMode =kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    [view.layer addAnimation:animationGroup forKey:key];
}

- (BOOL)beyondThreshold{
    return self.collectionView.contentOffset.y >= self.userInfoView.height;
}

- (CGFloat)rate{
    CGFloat rate = MIN(1.0, self.collectionView.contentOffset.y / self.userInfoView.height);
    return MAX(0, rate);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self beyondThreshold]) {//提取出来
        [self insertSubview:self.topBarView aboveSubview:self.collectionView];
        CGRect frame = self.topBarView.frame;
        frame.origin = CGPointZero;
        self.topBarView.frame = frame;
        self.topBarView.style = IKTLPersonTopBarStyleUserInfo;
    }else if(scrollView.contentOffset.y < self.userInfoView.height){//显示到headerView上
        CGRect frame = self.topBarView.frame;
        frame.origin = CGPointMake(0, self.userInfoView.height);
        self.topBarView.frame = frame;
        [self.headerView insertSubview:self.topBarView belowSubview:self.userInfoView];
        self.topBarView.style = IKTLPersonTopBarStyleChangModel;
    }
    if (scrollView.contentOffset.y <= 0) {
        self.panActive = YES;
        scrollView.contentOffset = CGPointZero;
    }else{
        self.panActive = NO;
    }
    if (scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y <= self.userInfoView.height) {
//        NSArray *animationViews = @[self.userInfoView.imgView]
//        NSLog(@"cjw cjw scrollViewDidScroll %f",scrollView.contentOffset.y);
        CGFloat rate = MIN(1.0, scrollView.contentOffset.y / self.userInfoView.height);
        NSMutableArray *fromArr = [NSMutableArray array];
        NSMutableArray *toArr = [NSMutableArray array];
        if (self.userInfoView.imgView && self.topBarView.imgView) {
            [fromArr addObject:self.userInfoView.imgView];
            [toArr addObject:self.topBarView.imgView];
        }
        if (self.userInfoView.nameLabel && self.topBarView.nameLabel) {
            [fromArr addObject:self.userInfoView.nameLabel];
            [toArr addObject:self.topBarView.nameLabel];
        }
        if (self.userInfoView.genderImgView && self.topBarView.genderImgView) {
            [fromArr addObject:self.userInfoView.genderImgView];
            [toArr addObject:self.topBarView.genderImgView];
        }
        if (self.userInfoView.livingView && self.topBarView.livingView) {
            [fromArr addObject:self.userInfoView.livingView];
            [toArr addObject:self.topBarView.livingView];
        }
        if(YES){
            [fromArr addObject:self.userInfoView.followBtn];
            [toArr addObject:self.topBarView.followBtn];
        
            CGRect oldFollowRect = [self.userInfoView convertRect:self.userInfoView.followBtn.frame toView:self.collectionView];
            CGRect toFollowRect  = [self.topBarView convertRect:self.topBarView.followBtn.frame toView:self.collectionView] ;
            CGFloat offsetX = toFollowRect.origin.x - oldFollowRect.origin.x;
            CGRect shareRect  = [self.userInfoView convertRect:self.userInfoView.shareBtn.frame toView:self.collectionView];
            
            CGRect shareToRect = shareRect;
            shareToRect.origin.x += offsetX;
            shareToRect.origin.y = toFollowRect.origin.y;
            [self view:self.userInfoView.shareBtn fromRect:shareRect toRect:shareToRect rate:rate];
            
            CGRect moreRect  = [self.userInfoView convertRect:self.userInfoView.moreBtn.frame toView:self.collectionView];
            
            CGRect moreToRect = moreRect;
            moreToRect.origin.x += offsetX;
            moreToRect.origin.y = toFollowRect.origin.y;
            [self view:self.userInfoView.moreBtn fromRect:moreRect toRect:moreToRect rate:rate];
        }
        
        for (NSInteger i = 0; i < [fromArr count]; i++) {
            UIView *fromView = fromArr[i];
            UIView *toView = toArr[i];
            CGRect rect  = [self.userInfoView convertRect:fromView.frame toView:self.collectionView];
            CGRect toRect  = [self.topBarView convertRect:toView.frame toView:self.collectionView];
//            NSLog(@"rect = %@",NSStringFromCGRect(fromView.frame));
//            NSLog(@"from %@  to %@",NSStringFromCGRect(rect),NSStringFromCGRect(toRect));
            [self view:fromView fromRect:rect toRect:toRect rate:rate];
        }
        [self.topBarView setModelViewAlpha:1-rate];
        [self.userInfoView setContentAlpha:1-rate];
    }else{
        [self.topBarView setModelViewAlpha:1];
        [self.userInfoView setContentAlpha:1];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
