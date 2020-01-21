//
//  PublicHeader.h
//  TabbarQuestion
//
//  Created by JianweiChen on 2018/8/3.
//  Copyright © 2018 inke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "UIView+IKSVUtils.h"

UIKIT_EXTERN NSString *kChangeTabKey;

UIKIT_EXTERN BOOL gIsIphoneX(void);

UIKIT_EXTERN UIColor *IKHexColor(unsigned int hexValue, CGFloat alpha);


#define IKIsIphoneX gIsIphoneX(void)

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kRate [UIScreen mainScreen].bounds.size.width/375.0
#define kScale [UIScreen mainScreen].scale


#ifndef weakify
#if __has_feature(objc_arc)
#define weakify(object) __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) __block __typeof__(object) block##_##object = object;
#endif
#endif

#ifndef strongify
#if __has_feature(objc_arc)
#define strongify(object) __typeof__(object) object = weak##_##object;
#else
#define strongify(object) __typeof__(object) object = block##_##object;
#endif
#endif

