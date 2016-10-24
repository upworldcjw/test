//
//  UIView+UIViewController.m
//  pengpeng
//
//  Created by 朴明德 on 13-12-12.
//  Copyright (c) 2013年 Cartier_朴. All rights reserved.
//

#import "UIView+UIViewController.h"

@implementation UIView (UIViewController)
- (UIViewController *)viewController {
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    return nil;
}
@end
