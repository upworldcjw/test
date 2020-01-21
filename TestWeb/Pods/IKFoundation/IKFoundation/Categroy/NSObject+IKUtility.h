//
//  NSObject+IKModel.h
//  IKBaseModel
//
//  Created by Chenxiaocheng on 17/2/17.
//  Copyright © 2017年 inke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (IKUtility)

- (NSString *)ik_queryParams;

- (void)ik_addProcessToDic:(NSMutableDictionary *)dic key:(NSString *)key sel:(SEL)sel;

- (void)ik_excuteSELWithDict:(NSDictionary *)selDict args:(NSDictionary *)dict key:(NSString *)key;

- (void)ik_excuteSEL:(NSDictionary *)dic args:(id)arg key:(NSString *)key;

- (id)ik_excuteSelReturnValueWithDic:(NSDictionary *)selDic args:(NSDictionary *)dict key:(NSString *)key;

- (void)ik_excuteSELWithDict:(NSDictionary *)selDict dataParam:(NSData *)dataParam key:(NSString *)key;

@end
