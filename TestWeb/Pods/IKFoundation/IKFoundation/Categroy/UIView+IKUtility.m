//
//  UIView+IKUtility.m
//  IKFoundation
//
//  Created by fanzhang on 2016/12/1.
//  Copyright © 2016年 inke. All rights reserved.
//

#import "UIView+IKUtility.h"
#import <objc/runtime.h>
#import "NSMutableArray+IKUtility.h"

@implementation UIView (IKUtility)

#define kIKUserDataKey @"IKUserDataKey"
#define kIKViewFindKey @"IKViewFindKey"

- (NSMutableDictionary*)ik_userData
{
    NSMutableDictionary* dic =  (NSMutableDictionary*)objc_getAssociatedObject(self, CFBridgingRetain(kIKUserDataKey));
    if (!dic)
    {
        dic = [NSMutableDictionary new];
        objc_setAssociatedObject(self, CFBridgingRetain(kIKUserDataKey), dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return dic;
}

- (NSString*)ik_key
{
    NSMutableDictionary* userData =  (NSMutableDictionary*)objc_getAssociatedObject(self, CFBridgingRetain(kIKUserDataKey));
    if (!userData)
        return nil;
    else
        return userData[kIKViewFindKey];
}

- (void)setIk_key:(NSString *)ik_key
{
    NSMutableDictionary* userData = self.ik_userData;
    userData[kIKViewFindKey] = ik_key;
}

- (UIView*)ik_findSubviewByKey:(NSString *)key
{
    NSParameterAssert(key.length);
    
    UIView* view;
    
    NSMutableArray* queue = [NSMutableArray new];
    [queue ik_enqueue:self];
    
    while ([queue count])
    {
        // find current view
        UIView* currentView = [queue ik_dequeue];
        NSMutableDictionary* userData =  (NSMutableDictionary*)objc_getAssociatedObject(currentView, CFBridgingRetain(kIKUserDataKey));
        if (userData && [[userData valueForKey:kIKViewFindKey] isEqualToString:key])
        {
            view = currentView;
            break;
        }
        
        // enqueue subview
        for (UIView* subView in currentView.subviews)
        {
            [queue ik_enqueue:subView];
        }
    }
    
    return view;
}

@end
