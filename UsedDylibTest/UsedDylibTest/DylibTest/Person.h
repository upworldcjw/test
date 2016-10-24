//
//  Person.h
//  DylibTest
//
//  Created by jianwei on 9/29/16.
//  Copyright © 2016 jianwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic, strong) NSString *name;

- (void)printName;
@end
