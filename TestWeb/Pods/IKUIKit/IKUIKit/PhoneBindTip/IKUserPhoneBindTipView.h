//
//  IKUserPhoneBindTipView.h
//  IKUIKit
//
//  Created by 孙西纯 on 2017/6/1.
//  Copyright © 2017年 inke. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ToastBlock)();

@interface IKUserPhoneBindTipView : UIView

+ (IKUserPhoneBindTipView *)toastWithLeftIcon:(UIImage *)icon1
                                    leftTitle:(NSString *)string1
                                    rightIcon:(UIImage *)icon2
                                   rightTitle:(NSString *)string2
                                   clickBlock:(ToastBlock)clickBlock
                             rightButtonClick:(ToastBlock)rightBlock;

+ (IKUserPhoneBindTipView *)toastWithString:(NSString *)string
                                 clickBlock:(ToastBlock)clickBlock
                                 closeBlock:(ToastBlock)closeBlock;

+ (IKUserPhoneBindTipView *)toastWithIcon:(UIImage *)icon
                                   string:(NSString *)string
                               clickBlock:(ToastBlock)clickBlock
                               closeBlock:(ToastBlock)closeBlock;

+ (CGFloat)height;

@end
