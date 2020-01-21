//
//  IKTLPersonalCollectionCell.h
//  inke
//
//  Created by JianweiChen on 2018/6/1.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IKTLPersonalSimpleCollectionCell : UICollectionViewCell

+ (CGSize)properSize;

+ (CGFloat)margin;

- (void)setTimeLineFrame:(id)frame;

@end
