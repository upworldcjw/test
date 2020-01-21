//
//  IKTLPersonFollowBtn.h
//  inke
//
//  Created by JianweiChen on 2018/6/1.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IKTLPersonFollowBtn : UIButton

+ (instancetype)personalFollowBtnWithFrame:(CGRect)frame;

- (void)refreshFollowBtn:(BOOL)follow;

@end


@interface IKTLPersonActionBtn : UIButton

+ (instancetype)personalActonButtonWithSize:(CGSize)size;

- (void)setImage:(UIImage *)img title:(NSString *)title;


@end
