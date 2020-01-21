//
//  IKDefaultImage.h
//  IKFoundation
//
//  Created by kyle on 2017/5/12.
//  Copyright © 2017年 inke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IKDefaultImage : NSObject

/**
 个人头像默认图

 @return return value description
 */
+ (UIImage *)userImage;

+ (UIImage *)photoImage;

/**
 男默认图

 @return return value description
 */
+ (UIImage *)boyImage;

/**
 女默认图

 @return return value description
 */
+ (UIImage *)girlImage;

/**
 默认new图

 @return return value description
 */
+ (UIImage *)newTagImage;


/**
 直播间默认图

 @return return value description
 */
+ (UIImage *)roomImage;

@end
