//
//  FCReachability.m
//  Part of FCUtilities by Marco Arment. See included LICENSE file for BSD
//  license.
//

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "FCBasics.h"
#import "FCReachability.h"
@import SystemConfiguration;

NSString *const FCReachabilityStatusChangedNotification =
@"FCReachabilityStatusChangedNotification";
NSString *const FCReachabilityOnlineNotification =
@"FCReachabilityStatusOnlineNotification";
NSString *const FCReachabilityOfflineNotification =
@"FCReachabilityStatusOfflineNotification";
NSString *const FCReachabilityCellularPolicyChangedNotification =
@"FCReachabilityStatusCellularPolicyChangedNotification";

static CTTelephonyNetworkInfo *telephonyInfo;

@interface FCReachability () {
    BOOL isOnline;
    BOOL requireWiFi;
    SCNetworkReachabilityRef reachability;
}

- (void)update;

@property(nonatomic) SCNetworkReachabilityFlags reachabilityFlags;
@property(nonatomic) FCReachabilityStatus status;
@end

static void FCReachabilityChanged(SCNetworkReachabilityRef target,
                                  SCNetworkReachabilityFlags flags,
                                  void *info) {
    FCReachability *fcr = (__bridge FCReachability *)info;
    fcr.status = (flags & kSCNetworkReachabilityFlagsReachable)
    ? (flags & kSCNetworkReachabilityFlagsIsWWAN
       ? FCReachabilityStatusOnlineViaCellular
       : FCReachabilityStatusOnlineViaWiFi)
    : FCReachabilityStatusOffline;
    // IKLog(@"[reachability] %@, %@", (flags &
    // kSCNetworkReachabilityFlagsReachable) ? @"reachable" : @"offline", (flags &
    // kSCNetworkReachabilityFlagsIsWWAN) ? @"cellular" : @"wi-fi");
    [fcr update];
}

@implementation FCReachability

+ (instancetype)shareInstance {
    static FCReachability *reachable = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        reachable = [[FCReachability alloc] initWithHostname:@"www.baidu.com"
                                               allowCellular:YES];
        telephonyInfo = [CTTelephonyNetworkInfo new];
    });
    return reachable;
}

- (instancetype)initWithHostname:(NSString *)hostname
                   allowCellular:(BOOL)allowCellular {
    if ((self = [super init])) {
        isOnline = NO;
        requireWiFi = !allowCellular;
        [self setReachabilityHostname:hostname];
    }
    return self;
}

- (BOOL)isOnline {
    return isOnline;
}

- (BOOL)allowCellular {
    return !requireWiFi;
}
- (void)setAllowCellular:(BOOL)allowCellular {
    if (requireWiFi == allowCellular) {
        requireWiFi = !allowCellular;
        fc_executeOnMainThread(^{
            [NSNotificationCenter.defaultCenter
             postNotificationName:FCReachabilityCellularPolicyChangedNotification
             object:self];
        });
        [self update];
    }
}

- (void)update {
    dispatch_async(dispatch_get_main_queue(), ^{
        BOOL nowOnline =
        self.status == FCReachabilityStatusOnlineViaWiFi ||
        (!requireWiFi && self.status == FCReachabilityStatusOnlineViaCellular);
        
        if (nowOnline && !isOnline) {
            isOnline = YES;
            [NSNotificationCenter.defaultCenter
             postNotificationName:FCReachabilityOnlineNotification
             object:self];
        } else if (!nowOnline && isOnline) {
            isOnline = NO;
            [NSNotificationCenter.defaultCenter
             postNotificationName:FCReachabilityOfflineNotification
             object:self];
        }
        
        [NSNotificationCenter.defaultCenter
         postNotificationName:FCReachabilityStatusChangedNotification
         object:self];
    });
}

- (BOOL)internetConnectionIsOfflineForError:(NSError *)error {
    if (error && (error.code == kCFURLErrorNotConnectedToInternet ||
                  error.code == kCFURLErrorNetworkConnectionLost)) {
        [self update];
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Reachability support

- (void)setReachabilityHostname:(NSString *)hostname {
    if (reachability) {
        SCNetworkReachabilitySetCallback(reachability, NULL, NULL);
        CFRelease(reachability);
        reachability = NULL;
    }
    
    if (hostname) {
        reachability =
        SCNetworkReachabilityCreateWithName(NULL, [hostname UTF8String]);
        if (!reachability) return;
        SCNetworkReachabilityContext context = {0, (__bridge void *)self, NULL,
            NULL, NULL};
        SCNetworkReachabilitySetCallback(reachability, FCReachabilityChanged,
                                         &context);
        SCNetworkReachabilityScheduleWithRunLoop(reachability, CFRunLoopGetMain(),
                                                 kCFRunLoopCommonModes);
    }
}

- (void)dealloc {
    if (reachability) {
        SCNetworkReachabilitySetCallback(reachability, NULL, NULL);
        SCNetworkReachabilityUnscheduleFromRunLoop(reachability, CFRunLoopGetMain(),
                                                   kCFRunLoopCommonModes);
        CFRelease(reachability);
        reachability = NULL;
    }
}

- (NSString *)getNetworkTypeString {
    if (_status == FCReachabilityStatusOffline) {
        return @"No";
    } else if (_status == FCReachabilityStatusOnlineViaWiFi) {
        return @"Wifi";
    } else if (_status == FCReachabilityStatusOnlineViaCellular) {
        if ([telephonyInfo.currentRadioAccessTechnology
             isEqualToString:CTRadioAccessTechnologyGPRS]) {
            return @"2G-GPRS";
        } else if ([telephonyInfo.currentRadioAccessTechnology
                    isEqualToString:CTRadioAccessTechnologyEdge]) {
            return @"2G-E";
        } else if ([telephonyInfo.currentRadioAccessTechnology
                    isEqualToString:CTRadioAccessTechnologyWCDMA]) {
            return @"3G-WCDMA";
        } else if ([telephonyInfo.currentRadioAccessTechnology
                    isEqualToString:CTRadioAccessTechnologyHSDPA]) {
            return @"3G-HSDPA";
        } else if ([telephonyInfo.currentRadioAccessTechnology
                    isEqualToString:CTRadioAccessTechnologyHSUPA]) {
            return @"3G-HSUPA";
        } else if ([telephonyInfo.currentRadioAccessTechnology
                    isEqualToString:CTRadioAccessTechnologyCDMA1x]) {
            return @"3G-CDMA1X";
        } else if ([telephonyInfo.currentRadioAccessTechnology
                    isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0]) {
            return @"3G-CDMA";
        } else if ([telephonyInfo.currentRadioAccessTechnology
                    isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA]) {
            return @"3G-CDMA";
        } else if ([telephonyInfo.currentRadioAccessTechnology
                    isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB]) {
            return @"3G-CDMA";
        } else if ([telephonyInfo.currentRadioAccessTechnology
                    isEqualToString:CTRadioAccessTechnologyeHRPD]) {
            return @"3G-EHRPD";
        } else if ([telephonyInfo.currentRadioAccessTechnology
                    isEqualToString:CTRadioAccessTechnologyLTE]) {
            return @"4G-LTE";
        }
    }
    return @"Unknow";
}

- (NSString *)getNetworkTypeShortString {
    if (_status == FCReachabilityStatusOffline) {
        return @"No";
    } else if (_status == FCReachabilityStatusOnlineViaWiFi) {
        return @"wifi";
    } else if (_status == FCReachabilityStatusOnlineViaCellular) {
        if ([telephonyInfo.currentRadioAccessTechnology
             isEqualToString:CTRadioAccessTechnologyGPRS]) {
            return @"2G";
        } else if ([telephonyInfo.currentRadioAccessTechnology
                    isEqualToString:CTRadioAccessTechnologyEdge]) {
            return @"2G";
        } else if ([telephonyInfo.currentRadioAccessTechnology
                    isEqualToString:CTRadioAccessTechnologyWCDMA]) {
            return @"3G";
        } else if ([telephonyInfo.currentRadioAccessTechnology
                    isEqualToString:CTRadioAccessTechnologyHSDPA]) {
            return @"3G";
        } else if ([telephonyInfo.currentRadioAccessTechnology
                    isEqualToString:CTRadioAccessTechnologyHSUPA]) {
            return @"3G";
        } else if ([telephonyInfo.currentRadioAccessTechnology
                    isEqualToString:CTRadioAccessTechnologyCDMA1x]) {
            return @"3G";
        } else if ([telephonyInfo.currentRadioAccessTechnology
                    isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0]) {
            return @"3G";
        } else if ([telephonyInfo.currentRadioAccessTechnology
                    isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA]) {
            return @"3G";
        } else if ([telephonyInfo.currentRadioAccessTechnology
                    isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB]) {
            return @"3G";
        } else if ([telephonyInfo.currentRadioAccessTechnology
                    isEqualToString:CTRadioAccessTechnologyeHRPD]) {
            return @"3G";
        } else if ([telephonyInfo.currentRadioAccessTechnology
                    isEqualToString:CTRadioAccessTechnologyLTE]) {
            return @"4G";
        }
    }
    return @"unknow";
}

@end
