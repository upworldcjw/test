//
//  NSURL+IKUtility.h
//  inke
//
//  Created by zld on 7/6/16.
//  Copyright © 2016 MeeLive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (IKUtility)

- (BOOL)ik_isWebUrl;

- (BOOL)ik_isInAppUrl;

- (NSDictionary *)ik_queryDictionary;

@end
