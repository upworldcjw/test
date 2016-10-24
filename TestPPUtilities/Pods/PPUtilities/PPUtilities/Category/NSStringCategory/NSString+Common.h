//
//  NSString+Common.h
//  Pods
//
//  Created by jianwei.chen on 16/2/26.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Common)

+ (NSString *)nb_UUID;

///如果为空返回YES，否则返回NO
- (BOOL)isBlankString;
@end
