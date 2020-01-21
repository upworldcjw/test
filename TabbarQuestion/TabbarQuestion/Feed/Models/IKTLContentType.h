//
//  IKTLContentType.h
//  inke
//
//  Created by JianweiChen on 13/04/2018.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import <Foundation/Foundation.h>
//内容元素
typedef NS_ENUM(NSInteger, IKTLContentElementType){
    IKTLContentElementTypeText  = 0,
    IKTLContentElementTypePic   = 1,
    IKTLContentElementTypeVideo = 2,
};

//组合内容
typedef NS_OPTIONS(NSInteger,IKTLContentType){
    IKTLContentTypeNone = 0,
    IKTLContentTypeText = 1 << 0,
    IKTLContentTypePic = 1 << 1,
    IKTLContentTypeVideo = 1 << 2,
};

typedef NS_ENUM(NSInteger,IKTLCommentSettingStatus) {
    IKTLCommentSettingStatusUnknown = -1,
    IKTLCommentSettingStatusAll,
    IKTLCommentSettingStatusOnlyFollowing,
    IKTLCommentSettingStatusNoneable,
};

typedef NS_ENUM(NSInteger,IKTLDetaiFromType){
    kIKTLDetaiFromTypeUnknown,
    kIKTLDetaiFromTypePersonalFeed,
};

@protocol IKTLContentTypeProtocol <NSObject>

@property (nonatomic, assign) IKTLContentType type;

@property (nonatomic, assign) IKTLContentElementType elementType;

//是否是支持类型
- (BOOL)isSupportType;
//是否是视频
- (BOOL)isVideoType;
//是否是音频
- (BOOL)isPicType;

//是否是纯文字
- (BOOL)isTextType;

@end


@interface IKTLContentTypeModel : NSObject <IKTLContentTypeProtocol>

//类方法
+ (BOOL)isSupportType:(IKTLContentType)type;

//是否是视频
+ (BOOL)isVideoType:(IKTLContentType)type;

//是否是音频
+ (BOOL)isPicType:(IKTLContentType)type;

//是否是纯文字
+ (BOOL)isTextType:(IKTLContentType)type;


//是否是支持类型
- (BOOL)isSupportType;

- (BOOL)isVideoType;

- (BOOL)isPicType;

- (BOOL)isTextType;

//是否是多媒体资源
- (BOOL)isMediaResource;
@end

