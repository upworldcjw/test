//
//  BGPhotoPreviewCell.h
//  TestLayout
//
//  Created by JianweiChen on 2018/10/28.
//  Copyright © 2018 inke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BGPhotoPreviewCell : UICollectionViewCell

@property (nonatomic , strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) CellModel *model;
@property (nonatomic, assign) BOOL animation;

- (void)setText:(NSString *)text;

- (void)doAnimation;

@end

NS_ASSUME_NONNULL_END
