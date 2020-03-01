//
//  IKTLTimeLineCollectionLayout.h
//  inke
//
//  Created by JianweiChen on 2018/10/28.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//@interface IKTLTimeLineCollectionLayoutDataSourceInfo : NSObject
//
//@property (nonatomic, assign) CGRect befromFrame;
//@property (nonatomic, assign) CGRect afterFrame;
//
//@end
//
//@class IKTLTimeLineCollectionLayout;
//@protocol IKTLTimeLineCollectionLayoutDataSource <NSObject>
//
//- (IKTLTimeLineCollectionLayoutDataSourceInfo *)timeLineCollectionLayout:(IKTLTimeLineCollectionLayout *)layout indexPath:(NSIndexPath *)indexPath;
//
//@end

@interface IKTLTimeLineCollectionLayout : UICollectionViewFlowLayout

//@property (nonatomic, weak) id<IKTLTimeLineCollectionLayoutDataSource> animationDelegate;

- (void)handleReloadItem:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
