//
//  IKTLPersonalFeedViewController.h
//  inke
//
//  Created by JianweiChen on 2018/5/30.
//  Copyright © 2018 MeeLive. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "IKUserInfo.h"
#import "IKTimeLineItem.h"

//这些枚举值和埋点对应，请不要随意修改
typedef NS_ENUM(NSInteger, kIKTLPersonalFeedFromType) {
    kIKTLPersonalFeedFromUnknown                = 0,
    kIKTLPersonalFeedFromHallTimeLine           = 1,             //大厅动态
    kIKTLPersonalFeedFromNearTimeLine           = 2,             //同城动态
    kIKTLPersonalFeedFromPersonalPage           = 3,             //个人主页
    kIKTLPersonalFeedFromPersonalDetailPortrait = 4,             //详情页
    kIKTLPersonalFeedFromPersonalDetailDrag     = 5,
};

@protocol IKPersonalFeedPushControllerDelegate <NSObject>

- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPush;

@end

@interface IKTLPersonalFeedViewController : UIViewController<UINavigationControllerDelegate>
@property (nonatomic,strong, readonly) UserInfo *userInfo;
@property (nonatomic,strong) IKTimeLineItem *timeLineFrame;
@property (nonatomic, assign) kIKTLPersonalFeedFromType from;
@property (nonatomic, strong) UIImage *screenImage;
@property (nonatomic, assign) void (^dimissBlock)(void);
@property (nonatomic, weak) id<IKPersonalFeedPushControllerDelegate> delegate;
@property (nonatomic, assign, readonly) CGFloat bgAlpha;

+ (IKTLPersonalFeedViewController *)showPersonFeedWithTimeLineFrame:(id)frame
                                                             from:(UIViewController *)vc
                                                             type:(kIKTLPersonalFeedFromType)type;

- (void)updatePercent:(CGFloat)percent;

@end
