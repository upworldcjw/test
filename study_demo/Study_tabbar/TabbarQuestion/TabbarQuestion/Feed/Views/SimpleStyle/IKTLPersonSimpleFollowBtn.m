//
//  IKTLPersonFollowBtn.m
//  inke
//
//  Created by JianweiChen on 2018/6/1.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import "IKTLPersonSimpleFollowBtn.h"
#import "PublicHeader.h"

@interface IKTLPersonSimpleFollowBtn ()

@end


@implementation IKTLPersonSimpleFollowBtn

+ (instancetype)personalFollowBtnWithFrame:(CGRect)frame{
    IKTLPersonSimpleFollowBtn *btn = [self buttonWithType:UIButtonTypeCustom];
    [btn setFrame:frame];
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    btn.layer.cornerRadius = frame.size.height/2.0;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = IKHexColor(0xfffffff, 0.3);
    return btn;
}


- (void)refreshFollowBtn:(BOOL)follow{
    if (follow) {
        self.hidden = YES;
//        [self setTitle:@"已关注" forState:UIControlStateNormal];
//        [self setTitleColor:IKHexColor(0xffffff, 1) forState:UIControlStateNormal];
    }else{
        self.hidden = NO;
        [self setTitle:@"关注" forState:UIControlStateNormal];
        [self setTitleColor:IKHexColor(0xffffff, 1) forState:UIControlStateNormal];
    }
}

@end
