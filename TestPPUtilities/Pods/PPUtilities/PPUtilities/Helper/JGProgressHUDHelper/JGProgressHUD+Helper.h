//
//  JGProgressHUD+Helper.h
//  pengpeng
//
//  Created by 巩鹏军 on 15/1/18.
//  Copyright (c) 2015年 AsiaInnovations. All rights reserved.
//

#import <JGProgressHUD/JGProgressHUD.h>
typedef NS_ENUM(NSInteger,JGProgressHUDCustomedStyle){
    JGProgressHUDCustomedStyle_A,
};

@interface JGProgressHUD (Helper)

+ (JGProgressHUD *)showHUDInView:(UIView*)hostView;
+ (JGProgressHUD *)showHUDInView:(UIView*)hostView message:(NSString*)message;
+ (JGProgressHUD *)showHUDInView:(UIView*)hostView message:(NSString*)message animated:(BOOL)animated;

#pragma mark - Convenice API

+ (JGProgressHUD *)showAutoDismissHUDWithMessage:(NSString*)message;
+ (JGProgressHUD *)showAutoDismissHUDWithMessage:(NSString*)message dismissDelay:(NSTimeInterval)delayTime;
+ (JGProgressHUD *)showSuccessAutoDismissHUDWithMessage:(NSString*)successMessage;
+ (JGProgressHUD *)showFailureAutoDismissHUDWithMessage:(NSString*)failureMessage;
#pragma mark - Raw API

+ (JGProgressHUD *)showHUDInView:(UIView*)hostView message:(NSString*)message dismissAfterDelay:(NSTimeInterval)delay;
+ (JGProgressHUD *)showHUDInView:(UIView*)hostView successMessage:(NSString*)successMessage dismissAfterDelay:(NSTimeInterval)delay;
+ (JGProgressHUD *)showHUDInView:(UIView*)hostView failureMessage:(NSString*)failureMessage dismissAfterDelay:(NSTimeInterval)delay;

#pragma mark - Instance Methods

- (void)showAutoDismissHUDWithMessage:(NSString *)message;

@end



@interface JGProgressHUD(CustomedView_1)
+ (JGProgressHUD *)showCustomedStyle:(JGProgressHUDCustomedStyle)style
                              onView:(UIView *)hostView
                                message:(NSString *)message
                          autoDismissAfter:(NSTimeInterval)delay;
@end
