//
//  IKTLPersonalFeedViewController.m
//  inke
//
//  Created by JianweiChen on 2018/5/30.
//  Copyright © 2018 MeeLive. All rights reserved.
//


#import "IKTLPersonalFeedViewController.h"
#import "IKTLPersonalTopBarView.h"
#import "IKTLPersonalMaskView.h"
#import "IKTLPersonalCommonInfoView.h"
#import "IKTLPersonalContentView.h"
#import "IKPsersonalFeedInteractiveTransition.h"
#import "IKPersonalFeedAnimatedTransition.h"
#import "IKTLPersonalSimpleContentView.h"
#import "IKTimeLineItem.h"
#import "PublicHeader.h"

@interface IKTLPersonalFeedViewController ()
<
IKTLPersonalContentViewDataSource,
IKTLPersonalContentViewDelegate
>
@property (nonatomic,strong) NSMutableArray *tlPersonalDataArray;
@property (nonatomic,assign) NSUInteger loadOffset;
@property (nonatomic,assign) BOOL hasMoreData;
@property (nonatomic, strong) IKTLPersonalContentView *contentView;
@property (nonatomic, strong) IKTLPersonalSimpleContentView *simpleContentView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) IKTLPersonalMaskView *maskView;
@property (nonatomic, strong) UIImageView *backImgView;
@property (nonatomic, strong) UIView      *bgView;

@property (nonatomic, strong) IKPsersonalFeedInteractiveTransition *interactiveTransitionPop;
@property (nonatomic, assign) UINavigationControllerOperation operation;
@property (nonatomic, assign) CGFloat bgAlpha;

@end

@implementation IKTLPersonalFeedViewController

+ (IKTLPersonalFeedViewController *)personFeedVCForUid:(NSInteger)uid from:(UIViewController *)vc{
    NSArray *vcs = vc.navigationController.viewControllers;
    for (IKTLPersonalFeedViewController *feedVC in vcs.reverseObjectEnumerator) {
        if ([feedVC isKindOfClass:[IKTLPersonalFeedViewController class]]) {
            if(feedVC.userInfo.uid == uid){
                return feedVC;
            }
        }
    }
    return nil;
}

+ (UIImage *)snapshotScreen:(UIViewController *)vc{
    // 判断是否为retina屏, 即retina屏绘图时有放大因子
//    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]){
//        UIGraphicsBeginImageContextWithOptions(vc.view.window.bounds.size, NO, [UIScreen mainScreen].scale);
//    } else {
//        UIGraphicsBeginImageContext(vc.view.window.bounds.size);
//    }
//    [vc.view.window.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    // 保存到相册
    
    UIView *contentView = vc.view.window;
    CGSize size = contentView.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGRect rect = contentView.bounds;
    //  自iOS7开始，UIView类提供了一个方法-drawViewHierarchyInRect:afterScreenUpdates: 它允许你截取一个UIView或者其子类中的内容，并且以位图的形式（bitmap）保存到UIImage中
    [contentView drawViewHierarchyInRect:rect afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (IKTLPersonalFeedViewController *)showPersonFeedWithTimeLineFrame:(IKTimeLineItem *)frame
                                                             from:(UIViewController *)vc
                                                             type:(kIKTLPersonalFeedFromType)type{
    UIImage *screenImage = [self snapshotScreen:vc];
    IKTLPersonalFeedViewController *feedVC = [self personFeedVCForUid:frame.feedUser.uid from:vc];
    if (feedVC) {
        [vc.navigationController popToViewController:feedVC animated:YES];
        return feedVC;
    }
    feedVC = [[IKTLPersonalFeedViewController alloc] init];
    feedVC.timeLineFrame = frame;
//    feedVC.fromVC = vc;
    feedVC.from = type;
    if (vc.navigationController.viewControllers.count >= 1) {//多于一个
        IKTLPersonalFeedViewController *personnalVC = [vc.navigationController.viewControllers firstObject];
        if ([personnalVC isKindOfClass:[IKTLPersonalFeedViewController class]]) {
            [vc.navigationController pushViewController:feedVC animated:YES];
            return feedVC;
        }
    }
    feedVC.screenImage = screenImage;
    feedVC.hidesBottomBarWhenPushed = YES;
    if(type == kIKTLPersonalFeedFromPersonalDetailDrag){
        
    }else{
        [vc.navigationController pushViewController:feedVC animated:NO];
    }
    return feedVC;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)simpleStyle{
    return self.from == kIKTLPersonalFeedFromPersonalDetailDrag || self.from == kIKTLPersonalFeedFromPersonalDetailPortrait;
}


- (void)setUpViews{
    BOOL animation = YES;
    self.bgAlpha = 0.6;
    if([self simpleStyle]){
        self.bgAlpha = 0.8;
        animation = YES;
    }
    self.view.backgroundColor = [UIColor clearColor];
    //模拟另一个控制器
    self.backImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:self.backImgView];
    [self.backImgView setImage:self.screenImage];
    //发送的背景色
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:self.bgView];
    if (animation) {
        self.bgView.backgroundColor = [IKHexColor(0x000000, 1) colorWithAlphaComponent:0.0];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.bgView.backgroundColor = [IKHexColor(0x000000, 1) colorWithAlphaComponent:self.bgAlpha];
        } completion:nil];
    }else{
        self.bgView.backgroundColor = [IKHexColor(0x000000, 1) colorWithAlphaComponent:self.bgAlpha];
    }
    if (self.from == kIKTLPersonalFeedFromPersonalDetailDrag) {
        self.backImgView.hidden = YES;
        self.bgView.hidden = YES;
    }

    self.containerView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.containerView];
    [self.containerView setFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.containerView.originY = kScreenHeight;//影藏到底部
    
    if([self simpleStyle]){
        [self setUpSimpleStyleViews];
    }else{
        [self setUpCommonStyleViews];
    }
}

- (void)setUpSimpleStyleViews{
    CGFloat offsetY = 0;
    self.simpleContentView = [[IKTLPersonalSimpleContentView alloc] initWithFrame:CGRectMake(0, offsetY, kScreenWidth, kScreenHeight - offsetY)];
    self.simpleContentView.backgroundColor = [UIColor clearColor];
    self.simpleContentView.delegate = self;
    self.simpleContentView.dataSource = self;
    [self.containerView addSubview:self.simpleContentView];
    self.simpleContentView.userInfo = self.userInfo;
    //正在直播，收到的赞
//    self.simpleContentView.userInfoView.isLiving = isLiving;
//    self.simpleContentView.userInfoView.belikedNum = self.timeLineFrame.belikedNum;
//    //关注对接
//    self.simpleContentView.userInfoView.isFollowed = self.timeLineFrame.isFollow;
    [self bindSimpleEvent];
}

- (void)bindSimpleEvent{
    [self bindUserInfoEvent];
    weakify(self);
    [self.simpleContentView setDismissBlock:^{
        strongify(self);
        [self dismiss];
    }];
    [self.simpleContentView setContentDragBlock:^(UIGestureRecognizerState state, CGFloat offsetY) {
        strongify(self);
        [self handleDrageState:state offsetY:offsetY];
    }];
}


- (void)setUpCommonStyleViews{
    self.maskView = [[IKTLPersonalMaskView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [IKTLPersonalMaskView properHeight])];
    weakify(self);
    [self.maskView setTapBlock:^{
        strongify(self);
        [self dismiss];
    }];
    [self.containerView addSubview:self.maskView];
    
    CGFloat offsetY = CGRectGetMaxY(self.maskView.frame);
    self.contentView = [[IKTLPersonalContentView alloc] initWithFrame:CGRectMake(0, offsetY, kScreenWidth, kScreenHeight - offsetY)];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerTopRight|UIRectCornerTopLeft cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    
    self.contentView.layer.mask = shapeLayer;
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.delegate = self;
    self.contentView.dataSource = self;
    [self.containerView addSubview:self.contentView];
    self.contentView.userInfo = self.userInfo;
//    //正在直播，收到的赞
//    BOOL isLiving = (self.timeLineFrame.roomInfo == nil) ? NO:YES;
//    self.contentView.topBarView.isLiving = isLiving;
//    self.contentView.userInfoView.isLiving = isLiving;
//    self.contentView.userInfoView.belikedNum = self.timeLineFrame.belikedNum;
//
//    //关注对接
//    self.contentView.userInfoView.isFollowed = self.timeLineFrame.isFollow;
//    self.contentView.topBarView.isFollowed = self.timeLineFrame.isFollow;
    
    [self bindEvent];
}

- (IKTLPersonalInfoView *)userInfoView{
    if(self.contentView){
        return self.contentView.userInfoView;
    }
    return self.simpleContentView.userInfoView;
}

- (void)bindUserInfoEvent{
}

- (void)bindEvent{
    weakify(self);
    [self bindUserInfoEvent];
}

- (void)handleDrageState:(UIGestureRecognizerState)state offsetY:(CGFloat)y{
//    NSLog(@"cjw cjw %ld",state);
    switch (state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:{
            CGRect frame = self.containerView.frame;
            frame.origin.y += y;
            if(frame.origin.y <= 0){
                frame.origin.y = 0;
            }else if(frame.origin.y >= kScreenHeight){
                frame.origin.y = kScreenHeight;
            }
            self.containerView.frame = frame;
            self.bgView.alpha = 1 * (1 - frame.origin.y/kScreenHeight);
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            CGFloat offsetY = self.containerView.frame.origin.y;
            if (offsetY > 60) {
                [self dismiss];
                
            }else{
                [self excuteShowAnimation];
            }
        }
            break;
        default:
            break;
    }
}

- (void)setScreenImage:(UIImage *)screenImage{
    _screenImage = screenImage;
}

- (void)setTimeLineFrame:(IKTimeLineItem *)timeLineItem{
    _timeLineFrame = timeLineItem;
    self.userInfoView.belikedNum = timeLineItem.belikedNum;
}

- (UserInfo *)userInfo{
    return self.timeLineFrame.feedUser;
}

#pragma mark - 关注
- (void)followAction{
    BOOL beFollowed = !self.timeLineFrame.isFollow;
    if (beFollowed) {
        [self doFollowAction:YES];
        return;
    }
    NSString *msg = [NSString stringWithFormat:@"你确定不再关注%@吗？",(self.userInfo.gender == GIRL)? @"她":@"他"];
    //取消关注
    weakify(self)
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        strongify(self);
        [self doFollowAction:NO];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:saveAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)doFollowAction:(BOOL)beFollowed{
 
}

- (void)gotoHomepage{
    if(self.from == kIKTLPersonalFeedFromPersonalPage){
        [self excuteDismissAnimationcompletion:^(BOOL finished) {
            [self.navigationController popViewControllerAnimated:NO];
        }];
    }else{
        [self excuteDismissAnimationcompletion:^(BOOL finished) {
            [self removeSelfAfterPush];
        }];
    }
}


- (void)loadData{
    self.tlPersonalDataArray = [NSMutableArray array];
    weakify(self);
    [self refreshNewData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
    [self registerNotification];
    [self loadGifRefresh];
    [self loadData];
    //初始化手势过渡的代理
    _interactiveTransitionPop = [IKPsersonalFeedInteractiveTransition interactiveTransitionWithTransitionType:IKInteractiveTransitionTypePop GestureDirection:IKInteractiveTransitionGestureDirectionRight];
    
    //给当前控制器的视图添加手势
    IKInteractivePanGesture *gesture = [[IKInteractivePanGesture alloc] initWithGestureDirection:IKInteractiveTransitionGestureDirectionRight];
    [gesture addPanGestureAtView:self.view];
    _interactiveTransitionPop.gesture = gesture;
    
    weakify(self);
    [_interactiveTransitionPop setPopConifg:^{
        strongify(self);
        self.navigationController.delegate = self;
//        self.delegate = self;
        self.backImgView.hidden = YES;
        self.bgView.hidden = YES;
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [_interactiveTransitionPop setInterationEndBlock:^(BOOL completion,CGFloat percent) {
        strongify(self);
        self.navigationController.delegate = nil;
        self.backImgView.hidden = NO;
        self.bgView.hidden = NO;
//        self.delegate = nil;
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (UICollectionView *)collectionView{
    if (self.simpleContentView) {
        return self.simpleContentView.collectionView;
    }
    return self.contentView.collectionView;
}

- (void)reloadItems{
    [self.contentView reloadItems];
    if (self.simpleContentView) {
        [self.simpleContentView reloadItems];
    }
}

- (void)clickSendButton:(NSString *)text comentItem:(IKTimeLineItem *)item {
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"个人动态";
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
//    self.navigationController.navigationBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self reloadItems];
    
    if(self.containerView.height == kScreenHeight){
        [self excuteShowAnimation];
    }
}

- (BOOL)isRootViewController{
    NSArray *subVCs = self.navigationController.viewControllers;
    for (UIViewController *vc in subVCs) {
        if ([vc isKindOfClass:[IKTLPersonalFeedViewController class]]) {
            if (vc == self) {
                return YES;
            }else{
                return NO;
            }
        }
    }
    return NO;
}

- (void)dismiss{
    weakify(self);
    [self excuteDismissAnimationcompletion:^(BOOL finished) {
        strongify(self);
        [self.navigationController popViewControllerAnimated:NO];
    }];
}

//隐形消失
- (void)excuteDismissAnimation{
    [self excuteDismissAnimationcompletion:nil];
}

- (CGFloat)visiableReginRelateScreenHeight{
    CGRect frame = self.containerView.frame;
    if(frame.origin.y <= 0){
        frame.origin.y = 0;
    }else if(frame.origin.y >= kScreenHeight){
        frame.origin.y = kScreenHeight;
    }
    return 1 - frame.origin.y/kScreenHeight;
}

- (void)excuteDismissAnimationcompletion:(void (^)(BOOL finished))completion{
    if (self.containerView.originY == kScreenHeight) {
        completion(YES);
        return;
    }
    
    CGFloat precent = [self visiableReginRelateScreenHeight];
    weakify(self);
    [UIView animateWithDuration:0.3 * precent animations:^{
        strongify(self);
        self.containerView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, self.view.height);
        self.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}

- (void)excuteShowAnimation{
    if (self.containerView.originY == 0) {
        return;
    }
    CGFloat precent = [self visiableReginRelateScreenHeight];
    [UIView animateWithDuration:0.3 * (1 - precent) animations:^{
        self.containerView.frame = CGRectMake(0, 0, kScreenWidth, self.view.height);
        self.bgView.alpha = 1;
    }];
}


- (void)updatePercent:(CGFloat)percent{
//    NSLog(@"cjw cjw %f",percent);在这里改变view 属性看不到效果
}

- (void)interactivePushEnd{
    self.backImgView.hidden = NO;
    self.bgView.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.contentView stopPlayingCell];
}

- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleBackgroundPlay) name:UIApplicationWillResignActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)applicationDidBecomeActive{
    [self reloadItems];
}

- (void)handleBackgroundPlay{
    [self.contentView stopPlayingCell];
}

- (void)refreshNewData {
    self.loadOffset = 0;
    [self requestTLData];
}

- (void)refreshFromLoadMore {
    [self requestTLData];
}

- (void)requestTLData{
    weakify(self);
    
//    [self.serviceHelper requestPersonalTLFeedListWithOffset:self.loadOffset uid:self.userInfo.uid completion:^(IKErrorCode errCode, NSArray *timeLineArray, NSUInteger offset, BOOL hasMore) {
//        strongify(self);
//        [self.loadingView hideAnimated:YES];
//
//        [self.collectionView.mj_header endRefreshing];
//        if (errCode == IKSUCCESS) {
//            if (self.loadOffset == 0) {//下拉刷新
//                if (timeLineArray.count > 0) {
//                    [self.tlPersonalDataArray removeAllObjects];
//                }else{
//                    [self.contentView loadEmptyView];
//                }
//            }
//            self.collectionView.mj_footer.hidden = !hasMore;
//            [self dealWithTLDataWithSource:timeLineArray offset:offset hasMore:hasMore];
//        } else {
//            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
//            if (kIsEmptyArray(self.tlPersonalDataArray)) {
//                self.collectionView.mj_footer.hidden = YES;
//            }
//        }
//    }];
}

- (void)dealWithTLDataWithSource:(NSArray *)sourceArray offset:(NSUInteger)offset hasMore:(BOOL)hasMore {
    if (offset) {
        self.loadOffset = offset;
    }
    [self.tlPersonalDataArray addObjectsFromArray:sourceArray];
    [self.contentView reloadItems];
    if (self.simpleContentView) {
        [self.simpleContentView reloadItems];
    }
    [self updateData4Detail:self.tlPersonalDataArray];

}
- (void)updateData4Detail:(NSMutableArray *)dataArr{
}


#pragma  mark - IKTLPersonalContentViewDataSource

- (NSArray<IKTimeLineItem *> *)dataSourceForContentView:(UIView *)contentView{
    return self.tlPersonalDataArray;
}

#pragma  mark - IKTLPersonalContentViewDelegate

- (void)contentView:(UIView *)contentView didSelected:(NSInteger)index{
}

- (void)contentViewEndScroll:(UIView *)contentView{

}

- (void)removeSelfAfterPush{
    NSArray *subVCs = self.navigationController.viewControllers;
    if (subVCs.count >= 2) {
//        if ([subVCs.lastObject isKindOfClass:[IKTimeLineDetailViewController class]]) {//IKTimeLineDetailViewController
            if ([subVCs[subVCs.count - 2] isKindOfClass:[IKTLPersonalFeedViewController class]]) {
                NSMutableArray *mutArr = [subVCs mutableCopy];
                [mutArr removeObjectAtIndex:subVCs.count - 2];
                [self.navigationController setViewControllers:mutArr animated:NO];
            }
//        }
    }
}


- (void)selectedItem:(IKTimeLineItem *)itemFrame  openComment:(BOOL)open keyBoradShow:(BOOL)show{
}
#pragma mark - IKFamousRefreshHeaderDataSource

- (void)loadGifRefresh {
    [self loadGifRefreshHeader];
}

- (void)loadGifRefreshHeader{

}



- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
//    NSLog(@"cjw cjw _operation =  %ld",operation);
    _operation = operation;
    //分pop和push两种情况分别返回动画过渡代理相应不同的动画操作
    IKPersonalFeedAnimatedTransition *animation = [IKPersonalFeedAnimatedTransition transitionWithType:operation == UINavigationControllerOperationPush ? XWPageCoverTransitionTypePush : XWPageCoverTransitionTypePop];
    weakify(self);
    [animation setAnimatedTransitionEnd:^(BOOL completion) {
        strongify(self);
        if (operation == UINavigationControllerOperationPush) {
            [self interactivePushEnd];
        }
    }];
    return animation;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
//    NSLog(@"cjw cjw _operation =  %ld",(long)_operation);
    if (_operation == UINavigationControllerOperationPush) {
        IKPsersonalFeedInteractiveTransition *interactiveTransitionPush = [self.delegate interactiveTransitionForPush];
        return interactiveTransitionPush.interation ? interactiveTransitionPush : nil;
    }else{
        return _interactiveTransitionPop.interation ? _interactiveTransitionPop : nil;
    }
}


@end
