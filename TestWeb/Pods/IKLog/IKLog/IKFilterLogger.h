//
//  IKFilterLogger.h
//  IKLogDemo
//
//  Created by fanzhang on 2016/12/30.
//  Copyright © 2016年 meelive. All rights reserved.
//

#import <Foundation/Foundation.h>

// Disable legacy macros
#ifndef DD_LEGACY_MACROS
    #define DD_LEGACY_MACROS 0
#endif

#import "DDLog.h"

//--------------------------------------------------------------------------------------------------------------------------------------------------------------

@protocol IKLogFilterDelegate <NSObject>
@optional
- (void)onLogMessage:(NSString*)rawMessage;

@end

//--------------------------------------------------------------------------------------------------------------------------------------------------------------

@interface IKFilterLogger : DDAbstractLogger<DDLogger>

- (void)addFilter:(id<IKLogFilterDelegate>)filter;
- (void)removeFilter:(id<IKLogFilterDelegate>)filter;

@end
