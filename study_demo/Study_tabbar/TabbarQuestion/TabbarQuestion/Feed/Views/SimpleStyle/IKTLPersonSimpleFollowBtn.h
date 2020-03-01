//
//  IKTLPersonFollowBtn.h
//  inke
//
//  Created by JianweiChen on 2018/6/1.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IKTLPersonSimpleFollowBtn : UIButton

+ (instancetype)personalFollowBtnWithFrame:(CGRect)frame;

- (void)refreshFollowBtn:(BOOL)follow;

@end

