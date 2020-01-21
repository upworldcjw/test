//
//  IKTLPersonalInfoView.h
//  inke
//
//  Created by JianweiChen on 2018/5/30.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKTLPersonalProtocol.h"
#import "IKUserInfo.h"
@interface IKTLPersonalInfoView : UIView

@property (nonatomic, weak) id<IKTLPersonalInfoViewDelegate> delegate;
@property (nonatomic, strong) UserInfo *userInfo;
@property (nonatomic, copy) void (^followBlock)(void);
@property (nonatomic, copy) void (^shreBlock)(void);
@property (nonatomic, copy) void (^goToPersonBlock)(void);
@property (nonatomic, copy) void (^goToPublish)(void);
@property (nonatomic, copy) void (^goToLiving)(void);
@property (nonatomic, assign) NSInteger belikedNum;
@property (nonatomic, assign) BOOL isFollowed;
@property (nonatomic, assign) BOOL isLiving;

@end
