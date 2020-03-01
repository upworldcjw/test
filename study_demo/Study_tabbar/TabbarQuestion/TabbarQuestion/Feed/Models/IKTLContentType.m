//
//  IKTLContentType.m
//  inke
//
//  Created by JianweiChen on 13/04/2018.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import "IKTLContentType.h"
//同时 视频 && 音频，不支持
NSInteger const kUnSupportType = (IKTLContentTypePic|IKTLContentTypeVideo);
NSInteger const kMaxValue = (IKTLContentTypePic|IKTLContentTypeVideo|IKTLContentTypeText);

@implementation IKTLContentTypeModel
@synthesize type;
@synthesize elementType;
//类方法
+ (BOOL)isSupportType:(IKTLContentType)type{
    BOOL result = (!(type > kMaxValue) &&      //如未来只是音频 1<< 3
            ((type & kUnSupportType) != kUnSupportType) &&
            type != 0                   //0表示什么都不支持
            );
    if (!result) {
        NSLog(@"not SupportType");
    }
    return result;
}

//是否是视频
+ (BOOL)isVideoType:(IKTLContentType)type{
//    NSAssert([self isSupportType:type], @"must filter");
    if (type & IKTLContentTypeVideo) {
        return YES;
    }
    return NO;
}

//是否是音频
+ (BOOL)isPicType:(IKTLContentType)type{
//    NSAssert([self isSupportType:type], @"must filter");
    if (type & IKTLContentTypePic) {
        return YES;
    }
    return NO;
}

+ (BOOL)isTextType:(IKTLContentType)type {
    if (type == IKTLContentTypeText) {
        return YES;
    }
    return NO;
}

//是否是支持类型
- (BOOL)isSupportType{
    return [IKTLContentTypeModel isSupportType:self.type];
}

- (BOOL)isVideoType{
    return [IKTLContentTypeModel isVideoType:self.type];
}

- (BOOL)isPicType{
    return [IKTLContentTypeModel isPicType:self.type];
}

- (BOOL)isTextType {
    return [IKTLContentTypeModel isTextType:self.type];
}

//是否是多媒体资源
- (BOOL)isMediaResource{
    return [self isVideoType] || [self isPicType];
}

@end
