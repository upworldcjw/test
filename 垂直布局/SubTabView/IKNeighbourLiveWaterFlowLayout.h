//
//  IKNeighbourLiveWaterFlowLayout.h
//  inke
//
//  Created by parker lovely on 2018/11/12.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IKNeighbourLiveWaterFlowLayout;

@protocol IKWaterflowLayoutDelegate <NSObject>
@required
- (CGFloat)waterflowLayout:(IKNeighbourLiveWaterFlowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInWaterflowLayout:(IKNeighbourLiveWaterFlowLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(IKNeighbourLiveWaterFlowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(IKNeighbourLiveWaterFlowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(IKNeighbourLiveWaterFlowLayout *)waterflowLayout;
@end

@interface IKNeighbourLiveWaterFlowLayout : UICollectionViewLayout
/** 代理 */
@property (nonatomic, weak) id<IKWaterflowLayoutDelegate> delegate;
@end
