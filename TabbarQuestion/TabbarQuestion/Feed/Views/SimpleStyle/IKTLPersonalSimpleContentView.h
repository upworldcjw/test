//
//  IKTLPersonalContentView.h
//  inke
//
//  Created by JianweiChen on 2018/5/30.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKTLPersonalTopBarView.h"
#import "IKTLPersonalCommonInfoView.h"
#import "IKTLPersonalSimpleInfoView.h"
#import "IKTLPersonalProtocol.h"

@interface IKTLPersonalSimpleContentView : UIView <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UserInfo *userInfo;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) IKTLPersonalSimpleInfoView *userInfoView;
@property (nonatomic, weak) id<IKTLPersonalContentViewDataSource> dataSource;
@property (nonatomic, weak) id<IKTLPersonalContentViewDelegate> delegate;
@property (nonatomic, copy) void (^contentDragBlock)(UIGestureRecognizerState state,CGFloat offsetY);
@property (nonatomic, copy) void (^dismissBlock)(void);

- (void)reloadItems;

@end
