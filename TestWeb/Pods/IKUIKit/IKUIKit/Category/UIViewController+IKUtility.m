//
//  UIViewController+IKUtility.m
//  IKUIKit
//
//  Created by Chenxiaocheng on 17/5/12.
//  Copyright © 2017年 inke. All rights reserved.
//

#import "UIViewController+IKUtility.h"

@implementation UIViewController (IKUtility)

- (BOOL)ik_isVisible
{
    return self.viewLoaded && self.view.window;
}


@end
