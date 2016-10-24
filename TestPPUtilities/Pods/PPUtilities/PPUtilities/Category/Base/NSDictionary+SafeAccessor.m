//
//  NSDictionary+SafeAccessor.m
//  pengpeng
//
//  Created by 巩鹏军 on 14/12/10.
//  Copyright (c) 2014年 AsiaInnovations. All rights reserved.
//

#import "NSDictionary+SafeAccessor.h"
//#import "PPMacro.h"
@implementation NSDictionary (SafeAccessor)

- (BOOL)objectForKeyIsNSNull:(id)key;
{
    id obj = [self objectForKey:key];
    return !obj || [obj isKindOfClass:[NSNull class]];
}

- (BOOL)objectForKeyIsValid:(id)key;
{
    id obj = [self objectForKey:key];
    return obj && ![obj isKindOfClass:[NSNull class]];
}

- (NSString*)pp_stringForKey:(id)key;
{
    if([self objectForKeyIsNSNull:key])
        return nil;
    
    NSString *retString = [self objectForKey:key];
    if([retString isKindOfClass:[NSString class]])
        return retString;
    
    if([retString isKindOfClass:[NSValue class]] || [retString isKindOfClass:[NSNumber class]]){
        retString = [retString description];
        return  retString;
    }
    return nil;
}

- (NSDictionary*)pp_dictionaryForKey:(id)key;
{
    if([self objectForKeyIsNSNull:key])
        return nil;
    
    NSDictionary *retDict = [self objectForKey:key];
    if ([retDict isKindOfClass:[NSDictionary class]])
        return retDict;
    
    return nil;
}

- (NSArray*)arrayForKey:(id)key;
{
    if([self objectForKeyIsNSNull:key])
        return nil;
    
    NSArray *retArray = [self objectForKey:key];
    if ([retArray isKindOfClass:[NSArray class]])
        return retArray;
    
    return nil;
}

- (NSMutableArray*)mutableArrayForKey:(id)key;
{
    if([self objectForKeyIsNSNull:key])
        return nil;
    
    NSMutableArray *retArray = [self objectForKey:key];
    if ([retArray isKindOfClass:[NSMutableArray class]])
        return retArray;
    
    return nil;
}

- (NSInteger)integerForKey:(id)key;
{
    if([self objectForKeyIsNSNull:key])
        return 0;
    
    id obj = [self objectForKey:key];
    if([obj respondsToSelector:@selector(integerValue)])
        return [obj integerValue];
    
    return 0;
}

- (NSUInteger)unsignedIntegerForKey:(id)key;
{
    if([self objectForKeyIsNSNull:key])
        return 0;
    
    id obj = [self objectForKey:key];
    
    if([obj respondsToSelector:@selector(unsignedIntegerValue)])
        return [obj unsignedIntegerValue];
    
    if([obj respondsToSelector:@selector(integerValue)])
        return (NSUInteger)[obj integerValue];
    
    return 0;
}

- (int)intForKey:(id)key;
{
    if([self objectForKeyIsNSNull:key])
        return 0;
    
    id obj = [self objectForKey:key];
    
    if([obj respondsToSelector:@selector(intValue)])
        return [obj intValue];
    
    return 0;
}

- (unsigned int)unsignedIntForKey:(id)key;
{
    if([self objectForKeyIsNSNull:key])
        return 0;
    
    id obj = [self objectForKey:key];
    
    if([obj respondsToSelector:@selector(unsignedIntValue)])
        return [obj unsignedIntValue];
    
    if([obj respondsToSelector:@selector(intValue)])
        return (unsigned int)[obj intValue];
    
    return 0;
}

- (long)longForKey:(id)key;
{
    if([self objectForKeyIsNSNull:key])
        return 0;
    
    id obj = [self objectForKey:key];
    if([obj respondsToSelector:@selector(longValue)])
        return [obj longValue];
    
    return 0;
}

- (unsigned long)unsignedLongForKey:(id)key;
{
    if([self objectForKeyIsNSNull:key])
        return 0;
    
    id obj = [self objectForKey:key];
    if([obj respondsToSelector:@selector(unsignedLongValue)])
        return [obj unsignedLongValue];
    
    if([obj respondsToSelector:@selector(longValue)])
        return (unsigned long)[obj longValue];
    
    return 0;
}

- (long long int)longLongIntForKey:(id)key;
{
    if([self objectForKeyIsNSNull:key])
        return 0;
    
    id obj = [self objectForKey:key];
    if([obj respondsToSelector:@selector(longLongValue)])
        return [obj longLongValue];
    
    return 0;
}

- (unsigned long long int)unsignedLongLongIntForKey:(id)key;
{
    if([self objectForKeyIsNSNull:key])
        return 0;
    
    id obj = [self objectForKey:key];
    if([obj respondsToSelector:@selector(unsignedLongLongValue)])
        return [obj unsignedLongLongValue];
    
    if([obj respondsToSelector:@selector(longLongValue)])
        return (unsigned long long int)[obj longLongValue];

    return 0;
}

- (BOOL)boolForKey:(id)key;
{
    if([self objectForKeyIsNSNull:key])
        return NO;
    
    id obj = [self objectForKey:key];
    if([obj respondsToSelector:@selector(boolValue)])
        return [obj boolValue];
    
    return NO;
}

- (float)floatForKey:(id)key;
{
    if([self objectForKeyIsNSNull:key])
        return 0.0;
    
    id obj = [self objectForKey:key];
    if([obj respondsToSelector:@selector(floatValue)])
        return [obj floatValue];
    
    return 0.0;
}

- (double)doubleForKey:(id)key;
{
    if([self objectForKeyIsNSNull:key])
        return 0.0;
    
    id obj = [self objectForKey:key];
    if([obj respondsToSelector:@selector(doubleValue)])
        return [obj doubleValue];
    
    return 0.0;
}

- (double)mapCoordinateValueForKey:(id)key;
{
    if([self objectForKeyIsNSNull:key])
        return 360.0f; // invalid coordinate
    
    id obj = [self objectForKey:key];
    if([obj respondsToSelector:@selector(doubleValue)])
        return [obj doubleValue];
    
    return 360.0f; // invalid coordinate
}

- (id)JSONObjectForKey:(id)key;
{
    NSString* text = [self pp_stringForKey:key];
    NSData* data = [text dataUsingEncoding:NSUTF8StringEncoding];
    if(data) {
        return [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    } else {
        return nil;
    }
}

- (NSDate*)dateForKey:(id)key;
{
    NSTimeInterval interval = [self doubleForKey:key];
    if(interval == 0.0)
        return nil;
    else
        return [NSDate dateWithTimeIntervalSince1970:interval];
}

@end

@implementation NSMutableDictionary (SafeAccessor)

- (void)setDate:(NSDate*)date forKey:(id)key;
{
    NSTimeInterval interval = [date timeIntervalSince1970];
    if(interval == 0.0) {
        [self removeObjectForKey:key];
    } else {
        [self setValue:@(interval) forKey:key];
    }
}

@end

@implementation NSDictionary (FilterNULL)

- (NSDictionary *)nb_dictonaryFilterNULL{
    if (!self || ![self isKindOfClass:[NSDictionary class]] || self.count < 1) {
        return nil;
    }
    
    NSMutableDictionary *middleDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSArray *keyArray = [self allKeys];
    
    if (!keyArray || ![keyArray isKindOfClass:[NSArray class]] || keyArray.count < 1) {
        return nil;
    }
    
    for (int i = 0; i < keyArray.count; i++){
        NSString *key = [keyArray objectAtIndex:i];
        if ([self objectForKey:key]&&![[self objectForKey:key] isKindOfClass:[NSNull class]]){
            [middleDict setObject:[self valueForKey:key] forKey:[keyArray objectAtIndex:i]];
        }else{
            [middleDict setObject:@"" forKey:[keyArray objectAtIndex:i]];
        }
    }
    
    return middleDict;
}

@end
