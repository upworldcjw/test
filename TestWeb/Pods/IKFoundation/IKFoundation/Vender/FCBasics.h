//
//  FCBasics.h
//  Part of FCUtilities by Marco Arment. See included LICENSE file for BSD
//  license.
//

#import <Foundation/Foundation.h>
#import <IKLog/IKLog.h>

#define NSStringNONil(x) (x ? x : @"")
#define NSDictionaryNONil(d) (d ? d : @{})
#define NSArrayNONil(a) (a ? a : @[])
#define RES_OK(sel) (self.delegate && [self.delegate respondsToSelector:sel])

#define deviceIsPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define sysVersionIsIOS8 \
([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)

#define user_defaults_get_bool(key) \
  [[NSUserDefaults standardUserDefaults] boolForKey:key]
#define user_defaults_get_int(key) \
  ((int)[[NSUserDefaults standardUserDefaults] integerForKey:key])
#define user_defaults_get_double(key) \
  [[NSUserDefaults standardUserDefaults] doubleForKey:key]
#define user_defaults_get_string(key) \
  fc_safeString([[NSUserDefaults standardUserDefaults] stringForKey:key])
#define user_defaults_get_array(key) \
  [[NSUserDefaults standardUserDefaults] arrayForKey:key]
#define user_defaults_get_object(key) \
  [[NSUserDefaults standardUserDefaults] objectForKey:key]

#define user_defaults_set_bool(key, b)                            \
  {                                                               \
    [[NSUserDefaults standardUserDefaults] setBool:b forKey:key]; \
    [[NSUserDefaults standardUserDefaults] synchronize];          \
  }
#define user_defaults_set_int(key, i)                                \
  {                                                                  \
    [[NSUserDefaults standardUserDefaults] setInteger:i forKey:key]; \
    [[NSUserDefaults standardUserDefaults] synchronize];             \
  }
#define user_defaults_set_double(key, d)                            \
  {                                                                 \
    [[NSUserDefaults standardUserDefaults] setDouble:d forKey:key]; \
    [[NSUserDefaults standardUserDefaults] synchronize];            \
  }
#define user_defaults_set_string(key, s)                            \
  {                                                                 \
    [[NSUserDefaults standardUserDefaults] setObject:s forKey:key]; \
    [[NSUserDefaults standardUserDefaults] synchronize];            \
  }
#define user_defaults_set_array(key, a)                             \
  {                                                                 \
    [[NSUserDefaults standardUserDefaults] setObject:a forKey:key]; \
    [[NSUserDefaults standardUserDefaults] synchronize];            \
  }
#define user_defaults_set_object(key, o)                            \
  {                                                                 \
    [[NSUserDefaults standardUserDefaults] setObject:o forKey:key]; \
    [[NSUserDefaults standardUserDefaults] synchronize];            \
  }

#define APP_DISPLAY_NAME \
  [NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleDisplayName"]
#define APP_VERSION    \
  [NSBundle.mainBundle \
      objectForInfoDictionaryKey:@"CFBundleShortVersionStrin" @"g"]
#define APP_BUILD_NUMBER \
  [NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleVersion"]

#define sysVersionIsIOS8Later \
  ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)
#define sysVersionIsIOS9Later \
  ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 9.0)
#define sysVersionIsIOS10Later \
  ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0)

inline __attribute__((always_inline)) NSString *fc_safeString(NSString *str) {
  return str ? str : @"";
}

inline __attribute__((always_inline)) NSString
    *fc_dictionaryValueToString(NSObject *cfObj) {
  if ([cfObj isKindOfClass:[NSString class]])
    return (NSString *)cfObj;
  else
    return [(NSNumber *)cfObj stringValue];
}

#pragma mark -

// If we're currently on the main thread, run block() sync, otherwise dispatch
// block() sync to main thread.
inline __attribute__((always_inline)) void fc_executeOnMainThread(
    void (^block)()) {
  if (block) {
    if ([NSThread isMainThread])
      block();
    else
      dispatch_sync(dispatch_get_main_queue(), block);
  }
}

// If we're currently on the main thread, run block() **sync**, otherwise
// dispatch block() **ASYNC** to main thread.
inline __attribute__((always_inline)) void fc_executeOnMainThreadAsync(
    void (^block)()) {
  if (block) {
    if ([NSThread isMainThread])
      block();
    else
      dispatch_async(dispatch_get_main_queue(), block);
  }
}

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#endif


#define dispatch_main_sync_safe(block)               \
if ([NSThread isMainThread]) {                     \
block();                                         \
} else {                                           \
dispatch_sync(dispatch_get_main_queue(), block); \
}

#define IK_dispatch_global_queue \
dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#define IK_dispatch_after_main(x, block)                             \
dispatch_after(                                                    \
dispatch_time(DISPATCH_TIME_NOW, (int64_t)(x * NSEC_PER_SEC)), \
dispatch_get_main_queue(), block)

#define IK_dispatch_after_global(x, block)                           \
dispatch_after(                                                    \
dispatch_time(DISPATCH_TIME_NOW, (int64_t)(x * NSEC_PER_SEC)), \
IK_dispatch_global_queue, block)

#define IK_dispatch_async_global(block) \
dispatch_async(IK_dispatch_global_queue, block)

#define IK_dispatch_async_main(block) \
dispatch_async(dispatch_get_main_queue(), block)

inline __attribute((always_inline)) uint64_t fc_random_int64() {
  uint64_t urandom;
  if (0 != SecRandomCopyBytes(kSecRandomDefault, sizeof(uint64_t),
                              (uint8_t *)(&urandom))) {
    arc4random_stir();
    urandom = (((uint64_t)arc4random()) << 32) | (uint64_t)arc4random();
  }
  return urandom;
}

#pragma mark -

#define kIsEmptyString(s) (s == nil || [s isKindOfClass:[NSNull class]] || ([s isKindOfClass:[NSString class]] && s.length == 0))
#define kIsInvalidDict(objDict) (objDict == nil || ![objDict isKindOfClass:[NSDictionary class]])

// 是否是无效数组
#define kIsInvalidArray(objArray) (objArray == nil || ![objArray isKindOfClass:[NSArray class]])

#define kIsEmptyArray(objArray) (objArray == nil || ![objArray isKindOfClass:[NSArray class]] || objArray.count == 0)

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kScale [UIScreen mainScreen].scale
#define kRate  kScreenWidth / 375.0

