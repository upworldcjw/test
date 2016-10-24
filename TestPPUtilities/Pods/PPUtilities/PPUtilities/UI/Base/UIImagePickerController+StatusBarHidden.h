//
//  UIImagePickerController+StatusBarHidden.h
//  pengpeng
//
//  Created by 朴明德 on 14-3-17.
//  Copyright (c) 2014年 AsiaInnovations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIImagePickerController (StatusBarHidden)
- (void)showStatusBar;
- (void)hideStatusBar;
@end
