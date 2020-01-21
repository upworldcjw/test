//
//  NSURL+IKUtility.m
//  inke
//
//  Created by zld on 7/6/16.
//  Copyright © 2016 MeeLive. All rights reserved.
//

#import "NSURL+IKUtility.h"

@implementation NSURL (IKUtility)

- (BOOL)ik_isWebUrl {
    BOOL result = NO;
    if (([self.scheme hasPrefix:@"http"] || !self.scheme) && ![self ik_isInkeLink]) {
        result = YES;
    }
    return result;
}

- (BOOL)ik_isInAppUrl {
    BOOL result = NO;
    // 统跳为 `inke://`, 前端的 `inkejs://` 不应该判断为统跳
    if (self.scheme && ([[self.scheme lowercaseString] isEqualToString:@"inke"] || [self ik_isInkeLink])) {
        result = YES;
    }
    return result;
}

- (BOOL)ik_isInkeLink {
    BOOL result = NO;
    if (([self.absoluteString containsString:@"link=inke"] || [self.absoluteString containsString:@"isInkeLink=1"]) &&
        ![self.absoluteString containsString:@"isNotInkeInAppUrl=1"]) {
        result = YES;
    }
    return result;
}

- (NSDictionary *)ik_queryDictionary {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *paramsString = nil;
    /*
     &&
     ![self.absoluteString containsString:@"?"] &&
     [self.absoluteString containsString:@"&"]
     */
    if (!([self.absoluteString hasPrefix:@"http://"] || [self.absoluteString hasPrefix:@"https://"])) {
        NSRange range = [self.absoluteString rangeOfString:@"://"];
        NSRange finalRange = NSMakeRange(range.location+range.length,
                                         self.absoluteString.length - (range.location+range.length));
        paramsString = [self.absoluteString substringWithRange:finalRange];
    } else {
        paramsString = [self query];
    }
    
    NSArray *paths = [paramsString componentsSeparatedByString:@"?"];
    
    if ([paths count] > 1) {
        paramsString = paths[1];
    }
    
    NSArray *urlComponents = [paramsString componentsSeparatedByString:@"&"];
    
    for (NSString *keyValuePair in urlComponents) {
        NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
        if (pairComponents && [pairComponents count] == 2) {
            NSString *key = [[pairComponents firstObject] stringByRemovingPercentEncoding];
            NSString *value = [[pairComponents lastObject] stringByRemovingPercentEncoding];
            [params setObject:value forKey:key];
        }
    }
    return params;
}

@end
