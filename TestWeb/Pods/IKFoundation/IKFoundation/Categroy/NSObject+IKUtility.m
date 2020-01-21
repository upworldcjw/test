//
//  NSObject+IKModel.m
//  IKBaseModel
//
//  Created by Chenxiaocheng on 17/2/17.
//  Copyright © 2017年 inke. All rights reserved.
//

#import "NSObject+IKUtility.h"
#import <YYModel/YYModel.h>
#import <IKFoundation/IKFoundation.h>

@implementation NSObject (IKUtility)

- (NSString *)ik_queryParams
{
    NSString *jsonStr = [self yy_modelToJSONString];
    NSDictionary *dic = [IKSerialization unSerializeFromJsonString:jsonStr withError:nil];
    
    NSMutableString *mutStr  = [NSMutableString string];
    
    NSEnumerator *enumerator = [dic keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
        [mutStr appendFormat:@"&%@=%@", key, dic[key]];
    }
    
    return mutStr;
}

- (void)ik_addProcessToDic:(NSMutableDictionary *)dic key:(NSString *)key sel:(SEL)sel
{
    NSMethodSignature *sig = [[self class] instanceMethodSignatureForSelector:sel];
    NSInvocation *invo     = [NSInvocation invocationWithMethodSignature:sig];
    [invo setTarget:self];
    [invo setSelector:sel];
    [dic setObject:invo forKey:key];
    return;
}

- (void)ik_excuteSELWithDict:(NSDictionary *)selDict args:(NSDictionary *)dict key:(NSString *)key
{
    NSInvocation *invo = [selDict objectForKey:key];
    if (!invo) {
        return;
    }
    
    [invo setArgument:&dict atIndex:2];
    [invo invoke];
    
    return;
}

- (void)ik_excuteSEL:(NSDictionary *)dic args:(id)arg key:(NSString *)key
{
    NSInvocation *invo = [dic objectForKey:key];
    if (!invo) {
        return;
    }
    
    [invo setArgument:&arg atIndex:2];
    [invo invoke];
    
    return;
}

- (id)ik_excuteSelReturnValueWithDic:(NSDictionary *)selDic args:(NSDictionary *)dict key:(NSString *)key
{
    NSInvocation *invo = [selDic objectForKey:key];
    if (!invo) {
        return nil;
    }
    
    [invo setArgument:&dict atIndex:2];
    [invo invoke];
    
    void *result;
    [invo getReturnValue:&result];
    return (__bridge id)result;
}

- (void)ik_excuteSELWithDict:(NSDictionary *)selDict dataParam:(NSData *)dataParam key:(NSString *)key
{
    NSInvocation *invo = [selDict objectForKey:key];
    if (!invo) {
        return;
    }
    
    [invo setArgument:&dataParam atIndex:2];
    [invo invoke];
    return;
}

@end
