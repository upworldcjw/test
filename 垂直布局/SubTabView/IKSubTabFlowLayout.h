//
//  WaterfallFlowLayout.h
//  inke
//
//  Created by JianweiChen on 2018/11/16.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

    // 类的前置声明
@class IKSubTabFlowLayout;

@protocol SubTabFlowLayoutDelegate <NSObject>
    // 动态获取 item 宽度
- (CGFloat)subTabFlowLayout:(IKSubTabFlowLayout *)layout widthForItemAtIndexPath:(NSIndexPath *) indexPath;

- (void)subTabFlowLayout:(IKSubTabFlowLayout *)layout needMaxWidth:(CGFloat)width;

@end

@interface IKSubTabFlowLayout : UICollectionViewLayout

@property (nonatomic,assign) id <SubTabFlowLayoutDelegate> delegate;

@property (nonatomic) NSInteger numberOfColumns;
@property (nonatomic) CGFloat minimumLineSpacing;
@property (nonatomic) CGFloat minimumInteritemSpacing;
@property (nonatomic) UIEdgeInsets sectionInset;

@end

NS_ASSUME_NONNULL_END
