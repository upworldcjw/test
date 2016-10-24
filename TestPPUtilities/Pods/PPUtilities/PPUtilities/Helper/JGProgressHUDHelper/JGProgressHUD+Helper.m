//
//  JGProgressHUD+Helper.m
//  pengpeng
//
//  Created by 巩鹏军 on 15/1/18.
//  Copyright (c) 2015年 AsiaInnovations. All rights reserved.
//
//#import "JGTalkHUDIndicatorView.h"
#import "JGProgressHUD+Helper.h"
#import "JGProgressHUDSuccessIndicatorView.h"
#import "JGProgressHUDErrorIndicatorView.h"
#import "JGProgressHUDPengPengIndicatorView.h"
//#import "PPMacro.h"
static JGProgressHUD *_static_hud;
@implementation JGProgressHUD (Helper)

+ (JGProgressHUD *)showHUDInView:(UIView*)hostView
{
    return [self showHUDInView:hostView message:NSLocalizedString(@"Loading", nil)];
}

+ (JGProgressHUD *)showHUDInView:(UIView*)hostView message:(NSString*)message
{
    return [self showHUDInView:hostView message:message animated:NO];
}

+ (JGProgressHUD *)showHUDInView:(UIView*)hostView message:(NSString*)message animated:(BOOL)animated;
{
    JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
//    HUD.indicatorView =  [[JGProgressHUDPengPengIndicatorView alloc] init];
    HUD.layoutChangeAnimationDuration = 0.0;
    HUD.textLabel.text = message;
    [HUD showInView:hostView animated:animated];
    return HUD;
}

#pragma mark - Convenice API

+ (JGProgressHUD *)showAutoDismissHUDWithMessage:(NSString*)message;
{
    return [self showAutoDismissHUDWithMessage:message dismissDelay:1];
}

+ (JGProgressHUD *)showAutoDismissHUDWithMessage:(NSString*)message dismissDelay:(NSTimeInterval)delayTime{
    if (message.length == 0) {
        return nil;
    }
    if (!_static_hud) {
        JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
        HUD.indicatorView = nil;
        HUD.textLabel.text = message;
        _static_hud = HUD;
    }
    _static_hud.layoutChangeAnimationDuration = 0.0;
    _static_hud.textLabel.text = message;
    if (!_static_hud.superview) {
        [_static_hud showInView:[UIApplication sharedApplication] animated:YES];
    }
    [_static_hud dismissAfterDelay:delayTime];
    return _static_hud;
}

+ (JGProgressHUD *)showSuccessAutoDismissHUDWithMessage:(NSString*)successMessage;
{
    return [self showHUDInView:[[[UIApplication sharedApplication] delegate] window] successMessage:successMessage dismissAfterDelay:1.0];
}

+ (JGProgressHUD *)showFailureAutoDismissHUDWithMessage:(NSString*)failureMessage;
{
    return [self showHUDInView:[[[UIApplication sharedApplication] delegate] window] failureMessage:failureMessage dismissAfterDelay:1.0];
}

#pragma mark - Raw API

+ (JGProgressHUD *)showHUDInView:(UIView*)hostView message:(NSString*)message dismissAfterDelay:(NSTimeInterval)delay;
{
    JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    HUD.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
    HUD.layoutChangeAnimationDuration = 0.0;
    HUD.indicatorView = nil;
    HUD.textLabel.text = message;
    [HUD showInView:hostView animated:YES];
    [HUD dismissAfterDelay:delay];
    return HUD;
}

+ (JGProgressHUD *)showHUDInView:(UIView*)hostView successMessage:(NSString*)successMessage dismissAfterDelay:(NSTimeInterval)delay;
{
    JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    HUD.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
    HUD.layoutChangeAnimationDuration = 0.0;
    HUD.indicatorView = [[JGProgressHUDSuccessIndicatorView alloc] init];
    HUD.textLabel.text = successMessage;
    [HUD showInView:hostView animated:YES];
    [HUD dismissAfterDelay:delay];
    return HUD;
}

+ (JGProgressHUD *)showHUDInView:(UIView*)hostView failureMessage:(NSString*)failureMessage dismissAfterDelay:(NSTimeInterval)delay;
{
    JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    HUD.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
    HUD.layoutChangeAnimationDuration = 0.0;
    HUD.indicatorView = HUD.indicatorView = [[JGProgressHUDErrorIndicatorView alloc] init];
    HUD.textLabel.text = failureMessage;
    [HUD showInView:hostView animated:YES];
    [HUD dismissAfterDelay:delay];
    return HUD;
}

#pragma mark - Instance Methods

- (void)showAutoDismissHUDWithMessage:(NSString *)message
{
    if (message.length == 0) {
        return;
    }
    self.indicatorView = nil;
    self.textLabel.text = message;
    [self dismissAfterDelay:1.0 animated:YES];
}

@end

@implementation JGProgressHUD(CustomedView_1)
+ (JGProgressHUD *)showCustomedStyle:(JGProgressHUDCustomedStyle)style
                              onView:(UIView *)hostView
                             message:(NSString *)message
                    autoDismissAfter:(NSTimeInterval)delay{
    JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleLight];
    switch (style) {
        case JGProgressHUDCustomedStyle_A:
        {
            HUD.contentView.backgroundColor = [UIColor whiteColor];
            HUD.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
            HUD.layoutChangeAnimationDuration = 0.0;
            HUD.indicatorView = [[JGProgressHUDImageIndicatorView alloc] initWithImage:[UIImage imageNamed:@"group_createSuccess"]];
            CGRect rect = CGRectMake(0, 0, 50, 50);
            [HUD.indicatorView setFrame:rect];
            [HUD.indicatorView.contentView setFrame:rect];
            HUD.textLabel.text = message;
            [HUD showInView:hostView animated:YES];
            HUD.cornerRadius = 9;
            [HUD dismissAfterDelay:delay];
        }
            break;
            
        default:
            break;
    }
    return HUD;
}
@end

