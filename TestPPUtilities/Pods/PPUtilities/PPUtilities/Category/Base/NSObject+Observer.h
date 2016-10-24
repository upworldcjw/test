//
//  NSObject+Observer.h
//  pengpeng
//
//  Created by jianwei.chen on 15/11/17.
//  Copyright © 2015年 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Observer)

- (void)nb_regiserObserverName:(nonnull NSString *)name selector:(nonnull SEL)selector;

- (void)nb_removeRegiserObservers;

- (void)nb_removeAllObservers;
@end
