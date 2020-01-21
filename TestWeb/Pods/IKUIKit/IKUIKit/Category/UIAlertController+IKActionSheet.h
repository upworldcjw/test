//
//  UIAlertController+IKActionSheet.h
//  inke
//
//  Created by 孙西纯 on 16/8/8.
//  Copyright © 2016年 MeeLive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (IKActionSheet)

- (void)setTextFont:(UIFont *)font textColor:(UIColor *)color;

@end


@interface UIAlertAction (IKActionSheet)

- (void)setTextColor:(UIColor *)color;

@end
