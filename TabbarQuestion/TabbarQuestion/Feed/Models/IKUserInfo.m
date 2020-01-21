//
//  IKUserInfo.m
//  InkeCoreDataStructure
//
//  Created by fanzhang on 2016/12/1.
//  Copyright © 2016年 meelive. All rights reserved.
//

#import "IKUserInfo.h"

@implementation UserInfo

- (NSString *)profession {
    if (_profession.length == 0) {
        return @"主播";
    }
    return _profession;
}

- (id)copy {
    UserInfo *info = [[UserInfo alloc] init];
    info.uid             = self.uid;
    info.nickName        = self.nickName;
    info.portrait        = self.portrait;
    info.level           = self.level;
    info.location        = self.location;
    info.desc            = self.desc;
    info.verified_reason = self.verified_reason;
    info.gender          = self.gender;
    info.rank_veri       = self.rank_veri;
    info.gmutex          = self.gmutex;
    info.liveRank        = self.liveRank;
    info.nativePlace     = self.nativePlace;
    return info;
}

- (id)copyWithZone:(NSZone *)zone {
    UserInfo *info = [[[self class] allocWithZone:zone] init];
    return info;
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.uid             = [[coder decodeObjectForKey:@"_uid"] integerValue];
        self.nickName        = [coder decodeObjectForKey:@"_nickName"];
        self.desc            = [coder decodeObjectForKey:@"_desc"];
        self.portrait        = [coder decodeObjectForKey:@"_portrait"];
        self.verified_reason = [coder decodeObjectForKey:@"_reason"];
        self.location        = [coder decodeObjectForKey:@"_location"];
        self.rank_veri       = [[coder decodeObjectForKey:@"_veriLevel"] integerValue];
        self.level           = [[coder decodeObjectForKey:@"_level"] integerValue];
        self.gender          = [[coder decodeObjectForKey:@"_gender"] integerValue];
        self.gmutex          = [[coder decodeObjectForKey:@"_gmutex"] boolValue];
        self.liveRank        = [coder decodeObjectForKey:@"_liveRank"];
        self.nativePlace     = [coder decodeObjectForKey:@"_nativePlace"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:@(_uid) forKey:@"_uid"];
    [coder encodeObject:_nickName forKey:@"_nickName"];
    [coder encodeObject:_portrait forKey:@"_portrait"];
    [coder encodeObject:_desc forKey:@"_desc"];
    [coder encodeObject:_verified_reason forKey:@"_reason"];
    [coder encodeObject:_location forKey:@"_location"];
    [coder encodeObject:@(_rank_veri) forKey:@"_veriLevel"];
    [coder encodeObject:@(_level) forKey:@"_level"];
    [coder encodeObject:@(_gender) forKey:@"_gender"];
    [coder encodeObject:@(_gmutex) forKey:@"_gmutex"];
    [coder encodeObject:_liveRank forKey:@"_liveRank"];
    [coder encodeObject:_nativePlace forKey:@"_nativePlace"];
}
@end




