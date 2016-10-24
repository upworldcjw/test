//
//  NSDictionary+SafeAccessor.h
//  pengpeng
//
//  Created by 巩鹏军 on 14/12/10.
//  Copyright (c) 2014年 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SafeAccessor)

- (BOOL)objectForKeyIsNSNull:(id)key;
- (BOOL)objectForKeyIsValid:(id)key;

- (NSDictionary*)pp_dictionaryForKey:(id)key;
- (NSArray*)arrayForKey:(id)key;

- (NSMutableArray*)mutableArrayForKey:(id)key;

- (NSInteger)integerForKey:(id)key;
- (NSUInteger)unsignedIntegerForKey:(id)key;

- (int)intForKey:(id)key;
- (unsigned int)unsignedIntForKey:(id)key;

- (long)longForKey:(id)key;
- (unsigned long)unsignedLongForKey:(id)key;

- (long long int)longLongIntForKey:(id)key;
- (unsigned long long int)unsignedLongLongIntForKey:(id)key;

- (BOOL)boolForKey:(id)key;

- (float)floatForKey:(id)key;
- (double)doubleForKey:(id)key;

- (double)mapCoordinateValueForKey:(id)key;

- (NSString*)pp_stringForKey:(id)key;

- (id)JSONObjectForKey:(id)key;

- (NSDate*)dateForKey:(id)key;

@end

@interface NSMutableDictionary (SafeAccessor)
- (void)setDate:(NSDate*)date forKey:(id)key;
@end

@interface NSDictionary (FilterNULL)

- (NSDictionary *)nb_dictonaryFilterNULL;

@end
