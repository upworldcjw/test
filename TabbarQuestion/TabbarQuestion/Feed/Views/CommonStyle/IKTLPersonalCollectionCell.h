//
//  IKTLPersonalCollectionCell.h
//  inke
//
//  Created by JianweiChen on 2018/6/1.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKTimeLineItem.h"

@interface IKTLPersonalCollectionCell : UICollectionViewCell
@property (nonatomic, strong) UIView *leftLineView;

+ (CGSize)properSize;

- (void)setTimeLineFrame:(IKTimeLineItem *)frame;

@end
