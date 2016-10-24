//
//  UIButton+block.m
//  pengpeng
//
//  Created by 朴明德 on 14-5-29.
//  Copyright (c) 2014年 AsiaInnovations. All rights reserved.
//

#import "UIButton+block.h"
#import <objc/runtime.h>


@implementation UIButton (block)
static char overviewKey;
static char paramKey;
@dynamic actions;


- (void)setAction:(NSString*)action withBlock:(void(^)())block {
    
    if ([self actions] == nil) {
        
        [self setActions:[[NSMutableDictionary alloc] init]];
        
    }
    [[self actions] setObject:block forKey:action];
    
    if ([kUIButtonBlockTouchUpInside isEqualToString:action]) {
        
        [self addTarget:self action:@selector(doTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}


- (void)setActions:(NSMutableDictionary*)actions {
    objc_setAssociatedObject (self, &overviewKey,actions,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSMutableDictionary*)actions {
    return objc_getAssociatedObject(self, &overviewKey);
    
}


- (void)doTouchUpInside:(id)sender {
    void(^block)();
    block = [[self actions] objectForKey:kUIButtonBlockTouchUpInside];
    block();
}

- (void)setParam:(NSMutableDictionary *) params {
    objc_setAssociatedObject (self, &paramKey,params,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString*)param {
    return objc_getAssociatedObject (self, &paramKey);
}


@end
