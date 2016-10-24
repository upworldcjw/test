//
//  ULAvatarView.h
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/28.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ULAvatarView : UIView
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel     *nameLabel;
- (instancetype)initWithImgSize:(CGSize)imgSize andName:(NSString *)name;
@end
