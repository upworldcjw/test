//
//  IKUserInfo.h
//  InkeCoreDataStructure
//
//  Created by fanzhang on 2016/12/1.
//  Copyright © 2016年 meelive. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IKBeautyUidModel, IKPrivilege,IKUserInfoPrePassModel;

typedef enum : NSUInteger
{
    GIRL,
    BOY,
} GenderType;

//公共直播间的等级
#define kTalentRoomRankVeri 92

@interface UserInfo : NSObject <NSCopying, NSCoding>

@property (nonatomic, assign) NSUInteger   uid;
@property (nonatomic, copy  ) NSString     *nickName;
@property (nonatomic, copy  ) NSString     *portrait;
@property (nonatomic, assign) GenderType    gender;
@property (nonatomic, copy  ) NSString     *verified_reason;
@property (assign, nonatomic) NSInteger    level;               // 用户等级
@property (nonatomic, copy  ) NSString     *location;
@property (nonatomic, copy  ) NSString     *desc;
@property (nonatomic, assign) NSInteger    rank_veri;           // 2.0认证等级
@property (nonatomic, assign) BOOL         gmutex;              // 是否修改过性别

@property (nonatomic, assign) NSInteger    inke_verify;         //是否是映客直播号，1:是/2:不是
@property (nonatomic, copy  ) NSString     *birth;
@property (nonatomic, copy  ) NSString     *emotion;
@property (nonatomic, copy  ) NSString     *hometown;
@property (nonatomic, copy  ) NSString     *profession;
@property (nonatomic, strong) NSDictionary *liveRank;
@property (nonatomic, copy  ) NSString     *nativePlace;
@property (nonatomic, assign) BOOL         isSimple;            // 是否精简的用户信息
@property (nonatomic, copy) NSString       *cardToken;          //首页埋点cmsToken

@end


