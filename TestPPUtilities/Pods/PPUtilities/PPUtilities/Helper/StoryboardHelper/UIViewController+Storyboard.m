//
//  UIViewController+Storyboard.m
//
//  Created by 巩 鹏军
//

#import "UIViewController+Storyboard.h"
#import "UIStoryboard+NBUI.h"

@implementation UIViewController (Storyboard)

+ (instancetype)storyboardViewController;
{
    return [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:[self storyboardIdentifier]];
}

+ (NSString *)storyboardIdentifier;
{
    return NSStringFromClass([self class]);
}

@end
