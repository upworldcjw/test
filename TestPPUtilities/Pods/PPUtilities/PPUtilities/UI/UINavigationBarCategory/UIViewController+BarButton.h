//
//  UIViewController+BarButton.h
//  pengpeng
//
//  Created by jianwei.chen on 15/11/18.
//  Copyright © 2015年 AsiaInnovations. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,NBCustomedNavBackStyle) {
    NBCustomedNavBack_PinkStyle,//默认粉色
    NBCustomedNavBack_WhiteStyle,
};

@protocol NBViewControllerBarButtonProtocol <NSObject>
-(void)leftBarButtonClicked:(id)sender;
@end

@interface UIViewController (BarButton)

- (UIButton *)leftBarButton;

#pragma mark - Nav Back Button

//- (void)setBackBarItemWithTitle:(NSString *)title;

#pragma mark - Nav Left Button
- (void)setLeftBarItemWithTitle:(NSString *)title;

- (void)setLeftBarItemWithTitle:(NSString *)title showBackImg:(BOOL)showBack;

- (void)setLeftBarItemWithNormalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName;

- (void)setLeftBarItemStyle:(NBCustomedNavBackStyle)style withTitle:(NSString *)title showBackImg:(BOOL)showBack;

@end
