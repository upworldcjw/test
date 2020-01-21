//
//  UIView+IKUtility.h
//  IKFoundation
//
//  Created by fanzhang on 2016/12/1.
//  Copyright © 2016年 inke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (IKUtility)

@property (nonatomic, strong, readonly) NSMutableDictionary* ik_userData;
@property (nonatomic, strong, readwrite) NSString* ik_key;

- (UIView*)ik_findSubviewByKey:(NSString*)key;

@end
