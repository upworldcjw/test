//
//  UIImagePickerController+StatusBarHidden.m
//  pengpeng
//
//  Created by 朴明德 on 14-3-17.
//  Copyright (c) 2014年 AsiaInnovations. All rights reserved.
//

#import "UIImagePickerController+StatusBarHidden.h"

@implementation UIImagePickerController (StatusBarHidden)

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setHidetatusBar:NO];
    [self performSelector:@selector(hideStatusBar) withObject:nil afterDelay:0.2];
}


- (BOOL)prefersStatusBarHidden
{
    if ([self hidetatusBar]) {
        BOOL hide = (self.sourceType== UIImagePickerControllerSourceTypeCamera)? YES : NO;
        return hide;
    }
    return NO;
}

- (UIViewController *)childViewControllerForStatusBarHidden
{
    if ([self hidetatusBar]) {
        return nil;
    }
    return [self.childViewControllers lastObject];
}

- (void)setHidetatusBar:(BOOL)hidetatusBar
{
    objc_setAssociatedObject(self, (__bridge const void *)(@"hidetatusBar"), [NSNumber numberWithBool:hidetatusBar], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)hidetatusBar
{
    NSNumber  *hidetatusBar = objc_getAssociatedObject(self, (__bridge const void *)(@"hidetatusBar"));
    return [hidetatusBar boolValue];
}

- (void)hideStatusBar
{
    [self setHidetatusBar:YES];
    [self prefersStatusBarHidden];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
}

- (void)showStatusBar
{
    [self setHidetatusBar:NO];
    [self prefersStatusBarHidden];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
}

@end
