//
//  IKStorageConfig.h
//  Meelivve
//
//  Created by Chenxiaocheng on 15/4/27.
//  Copyright (c) 2015年 Meelive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKStorageConfig : NSObject

/**
 *  serviceinfo(服务地址api)存储名称
 *
 */
+ (NSString *)serviceinfoCacheFileName;

+ (NSString *)serviceinfoBackupIpUrls;

/**
 *  闪屏启动图存储名称
 *
 */
+ (NSString *)splashCacheFileName;

+ (NSString *)splashExpireTime;

/**
 *  保存用户最后登录的uid和登录状态
 *
 */
+ (NSString *)loginUidCacheFileName;

/**
 *  地理位置存储文件名称
 *
 */
+ (NSString *)locationCacheFileName;

/**
 *  分享方式存储文件名称
 *
 */
+ (NSString *)shareCacheFileName;

/**
 *  首次启动登录标志存储名称
 *
 */
+ (NSString *)firstLoginCacheFileName;

/**
 *  首次启动时间
 *
 */
+ (NSString *)nextReviewTimeCacheFileName;

/**
 *  点评标志存储名称
 *
 */
+ (NSString *)userReviewedCacheFileName;

/**
 *  首次提示分享标志存储名称
 *
 */
+ (NSString *)firstForShareTipFileName;

/**
 *  首次提示设置标志存储名称
 *
 */

/**
 *  首次提示设置热门
 *
 */
+ (NSString *)firstShowHotTips;

+ (NSString *)firstForSettingTipFileName;

+ (NSString *)giftInfoCacheFileName;

+ (NSString *)giftResourceCacheFileName;

+ (NSString *)likeResourceCacheFileName;

+ (NSString *)rankResourceCacheFileName;

+ (NSString *)verifyResourceCacheFileName;  //个人认证

+ (NSString *)followCacheFileName;  //加关注前三次存储plist

+ (NSString *)SoundEffectEditFileName;  //音效编辑plist

+ (NSString *)fansNumFileName;

+ (NSString *)streamInfoCacheFileName;

+ (NSString *)pubInfoCacheFileName;

+ (NSString *)liveHearbeatCacheFileName;

+ (NSString *)giftWallIsFirstShow;

+ (NSString *)firstAddBlackList;

+ (NSString *)firstDelBlackList;

+ (NSString *)firstShowSwipeRightTip;

+ (NSString *)firstShowSwipeTopBottomTip;

+ (NSString *)firstEnterVideoChatRoom;

+ (NSString *)firstAgreeLiveFileName;

#pragma mark - 地区选择
+ (NSString *)sexAndAreaFileName;

#pragma mark - 跳过绑定
+ (NSString *)jumpPhoneBindWithUid:(NSInteger)uid;

#pragma mark - IP地址
+ (NSString *)IPAddressFileName;

#pragma mark - 长连接的ip地址
+ (NSString *)ipList;

+ (NSString *)connection_config;


extern NSString *const kStartLivingCamaraPos;

extern NSString *const kLastPayType;

extern NSString *const kFirstStartByVersion;

extern NSString *const kLastCrashFileName;

#pragma mark - 附近直播筛选性别存储

+ (NSString *)discoverSelectedGenderFileName;

#pragma mark - 手机绑定引导提示toast次数储存目录

+ (NSString *)phoneBindToastFileName;

#pragma mark - 短视频

extern NSString *const kShortVideoResource;

extern NSString *const kShortVideoFeedConfig;

extern NSString *const kShortVideoLocationConfig;

@end
