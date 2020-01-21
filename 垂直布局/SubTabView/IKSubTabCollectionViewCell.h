//
//  IKSubTabCollectionViewCell.h
//  inke
//
//  Created by Vincent on 2018/5/4.
//  Copyright © 2018年 MeeLive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKSubDynamicTabModel.h"

@interface IKSubTabCollectionViewCell : UICollectionViewCell

+ (CGFloat)widthForText:(NSString *)text;

- (void)setSubTabCellWithModel:(IKSubDynamicTabModel *)subTabModel;

- (void)setColorBegin:(UIColor *)colorBegin colorEnd:(UIColor *)endColor;

@end
