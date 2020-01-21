//
//  IKScrollBanner.h
//  inke
//
//  Created by elijah dou on 2016/10/24.
//  Copyright © 2016年 MeeLive. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IKScrollBannerModel;

typedef NS_ENUM(NSUInteger, IKScrollBannerViewPageControlAliment) {
    IKScrollBannerPageControlAlimentRight,
    IKScrollBannerPageControlAlimentCenter,
    IKScrollBannerPageControlAlimentLeft, // 不可用
};

typedef NS_ENUM(NSUInteger, IKScrollBannerViewPageControlStyle) {
    IKScrollBannerViewPageControlStyleClassic,        // 系统自带经典样式
    IKScrollBannerViewPageControlStyleNone            // 不显示pagecontrol
};

typedef void(^IKScrollBannerSelectBlock)(NSInteger idx);
typedef void(^IKScrollBannerScrollBlock)(NSInteger idx);



@class IKScrollBannerView;

@protocol IKScrollBannerViewDelegate <NSObject>
@optional

/** 点击图片回调 */
- (void)scrollBannerView:(IKScrollBannerView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;

/** 图片滚动回调 */
- (void)scrollBannerView:(IKScrollBannerView *)cycleScrollView didScrollToIndex:(NSInteger)index;

@end



@interface IKScrollBannerView : UIView

@property (nonatomic, strong) NSArray <IKScrollBannerModel *> *bannerModels; // banner models
@property (nonatomic, assign) NSTimeInterval autoScrollTimeInterval; // 滚动的时间间隔

/** 是否无限循环,默认Yes */
@property (nonatomic,assign) BOOL infiniteLoop;

/** 是否自动滚动,默认Yes */
@property (nonatomic,assign) BOOL autoScroll;

/** 图片滚动方向，默认为水平滚动 */
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

@property (nonatomic, weak) id<IKScrollBannerViewDelegate> delegate;

/** block方式监听点击 */
@property (nonatomic, strong) IKScrollBannerSelectBlock selectBlk;

/** block方式监听滚动 */
@property (nonatomic, strong) IKScrollBannerScrollBlock scrollBlk;


/*********  自定义样式接口  ***********/
@property (nonatomic, copy) UIImage *placeholderImage; // 默认的占位图

/** 轮播图片的ContentMode，默认为 UIViewContentModeScaleToFill */
@property (nonatomic, assign) UIViewContentMode bannerImageViewContentMode;

/** 是否显示分页控件 */
@property (nonatomic, assign) BOOL showPageControl;

/** 是否在只有一张图时隐藏pagecontrol，默认为YES */
@property(nonatomic) BOOL hidesForSinglePage;

/** 只展示文字轮播 */
@property (nonatomic, assign) BOOL onlyDisplayText;

/** pagecontrol 样式，默认为动画样式 */
@property (nonatomic, assign) IKScrollBannerViewPageControlStyle pageControlStyle;

/** 分页控件位置 */
@property (nonatomic, assign) IKScrollBannerViewPageControlAliment pageControlAliment; //

/** 分页控件小圆标大小 */
@property (nonatomic, assign) CGSize pageControlDotSize;

/** 分页控件小圆标间距 */
@property (nonatomic, assign) CGFloat pageControlDotInterspace;

/** 当前分页控件小圆标颜色 */
@property (nonatomic, strong) UIColor *currentPageDotColor;

/** 其他分页控件小圆标颜色 */
@property (nonatomic, strong) UIColor *pageDotColor;

/** 当前分页控件小圆标图片 */
@property (nonatomic, strong) UIImage *currentPageDotImage;

/** 其他分页控件小圆标图片 */
@property (nonatomic, strong) UIImage *pageDotImage;

/** 轮播文字label字体颜色 */
@property (nonatomic, strong) UIColor *titleLabelTextColor;

/** 轮播文字label字体大小 */
@property (nonatomic, strong) UIFont  *titleLabelTextFont;

/** 轮播文字label背景颜色 */
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;

/** 轮播文字label高度 */
@property (nonatomic, assign) CGFloat titleLabelHeight;



- (void)adjustWhenViewWillAppear; //

@end




@interface IKScrollBannerModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titleIconName;
@property (nonatomic, copy) NSString *coverURL;
@property (nonatomic, copy) NSString *webp_cover_img;
@property (nonatomic, copy) NSString *link;

@end

