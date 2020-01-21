//
//  IKStorageConfig.m
//  Meelive
//
//  Created by Chenxiaocheng on 15/4/27.
//  Copyright (c) 2015年 Meelive. All rights reserved.
//

#import "IKStorageConfig.h"

@implementation IKStorageConfig

+ (NSString *)serviceinfoCacheFileName {
    return @"serviceinfo_info";
}

+ (NSString *)serviceinfoBackupIpUrls {
    return @"serviceinfo_backup_ip_list.plist";
}

+ (NSString *)splashCacheFileName {
    return @"splash";
}

+ (NSString *)splashExpireTime {
    return @"splash_expire";
}

+ (NSString *)locationCacheFileName {
    return @"location.plist";
}

+ (NSString *)loginUidCacheFileName {
    return @"login_uid.plist";
}

+ (NSString *)shareCacheFileName {
    return @"share.plist";
}

+ (NSString *)firstLoginCacheFileName {
    return @"firstStart";
}

+ (NSString *)nextReviewTimeCacheFileName {
    return @"firstlaunchtime.plist";
}

+ (NSString *)userReviewedCacheFileName {
    return @"userreview.plist";
}

+ (NSString *)firstForShareTipFileName {
    return @"firstsharetip.plist";
}

+ (NSString *)firstForSettingTipFileName {
    return @"firstlivesettingtip.plist";
}

+ (NSString *)firstShowHotTips {
    return @"firstShowHotTips.plist";
}

+ (NSString *)giftInfoCacheFileName {
    return @"giftInfo.plist";
}

+ (NSString *)giftResourceCacheFileName {
    return @"giftResource_new.plist";
}

+ (NSString *)likeResourceCacheFileName {
    return @"likeResource.plist";
}

+ (NSString *)rankResourceCacheFileName {
    return @"rankResource.plist";
}

+ (NSString *)verifyResourceCacheFileName {
    return @"verifyResource.plist";
}

+ (NSString *)followCacheFileName {
    return @"followResource.plist";
}
+ (NSString *)SoundEffectEditFileName {
    return @"inkeSoundEffectFile.plist";
}
+ (NSString *)fansNumFileName {
    return @"fansNumFile.plist";
}

+ (NSString *)pubInfoCacheFileName {
    return @"pubInfo_new.plist";
}

+ (NSString *)liveHearbeatCacheFileName {
    return @"liveHearbeat.plist";
}
+ (NSString *)giftWallIsFirstShow {
    return @"giftWallIsFirstShow.plist";
}
+ (NSString *)firstAddBlackList {
    return @"firstAddBlackList.plist";
}
+ (NSString *)firstDelBlackList {
    return @"firstDelBlackList.plist";
}
+ (NSString *)firstShowSwipeRightTip {
    return @"firstShowSwipeRightTip.plist";
}
+ (NSString *)firstShowSwipeTopBottomTip {
    return @"firstShowSwipeTopBottomTip.plist";
}

+ (NSString *)firstEnterVideoChatRoom {
    return @"firstEnterVideoChatRoom.plist";
}

+ (NSString *)firstAgreeLiveFileName {
    return @"agreelive.plist";
}

+ (NSString *)streamInfoCacheFileName {
    return @"streamInfoCache.plist";
}

+ (NSString *)sexAndAreaFileName {
    return @"areaSelect.plist";
}

+ (NSString *)discoverSelectedGenderFileName {
    return @"discoverSelectedGender.plist";
}

+ (NSString *)phoneBindToastFileName {
    return @"phoneBindToastFile";
}

+ (NSString *)jumpPhoneBindWithUid:(NSInteger)uid
{
    NSString *plistName = [NSString stringWithFormat:@"%@%ld%@", @"jumpPhoneBind", (long)uid, @".plist"];
    return plistName;
}

//网络IP地址
+ (NSString *)IPAddressFileName {
    return @"ipAddress.plist";
}

+ (NSString *)ipList {
    return @"ip_list.plist";
}

+ (NSString *)connection_config {
    return @"connection_config.plist";
}

NSString *const kStartLivingCamaraPos = @"camera.plist";

NSString *const kLastPayType = @"paytype.plit";

NSString *const kFirstStartByVersion = @"first_version.plist";

NSString *const kLastCrashFileName = @"last_crash_filename.plist";

NSString *const kShortVideoResource = @"short_video_resource.plist";

NSString *const kShortVideoFeedConfig = @"short_video_feed_config.plist";

NSString *const kShortVideoLocationConfig = @"short_video_location_config.plist";

@end
