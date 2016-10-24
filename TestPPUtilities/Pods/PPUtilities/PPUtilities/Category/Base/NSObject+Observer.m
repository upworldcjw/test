//
//  NSObject+Observer.m
//  pengpeng
//
//  Created by jianwei.chen on 15/11/17.
//  Copyright © 2015年 AsiaInnovations. All rights reserved.
//

#import "NSObject+Observer.h"
#import <objc/runtime.h>

@interface NSObject (Observer_Inner)
@property (nullable,nonatomic) NSMutableArray *nb_observers;
@end

@implementation NSObject (Observer_Inner)
@dynamic nb_observers;

-(NSMutableArray *)nb_observers{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setNb_observers:(NSMutableArray *)nb_observers{
    objc_setAssociatedObject(self, @selector(nb_observers), nb_observers, OBJC_ASSOCIATION_RETAIN);
}

@end

@implementation NSObject (Observer)

#pragma mark 添加所有消息监听，NSNotification
- (void)nb_regiserObserverName:(NSString *)name selector:(SEL)selector{
    __weak typeof(self) wself = self;
    id observer = [[NSNotificationCenter defaultCenter] addObserverForName:name object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [wself performSelector:selector withObject:note];
#pragma clang diagnostic pop
    }];
    if (self.nb_observers == nil) {
        NSMutableArray *observers = [NSMutableArray array];
        [self setNb_observers:observers];
    }
    [self.nb_observers addObject:observer];
}

- (void)nb_removeRegiserObservers{
    for (id observer in self.nb_observers) {
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }
    [self.nb_observers removeAllObjects];
    self.nb_observers = nil;
}

- (void)nb_removeAllObservers{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self nb_removeRegiserObservers];
}

@end
