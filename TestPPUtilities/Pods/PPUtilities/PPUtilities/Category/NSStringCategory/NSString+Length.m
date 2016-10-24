//
//  NSString+Length.m
//  pengpeng
//
//  Created by jianwei.chen on 15/12/9.
//  Copyright © 2015年 AsiaInnovations. All rights reserved.
//

#import "NSString+Length.h"
//系统表情长度为1，中文长度为2，英文长度为1
@implementation NSString (Length)
- (uint)nb_inputLength{
    __block uint count = 0;
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length)
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring,NSRange substringRange,NSRange enclosingRange,BOOL *stop){
                                
                                BOOL isAscii = (substring.length == 1 && isascii([substring characterAtIndex:0]));
                                
                                count += isAscii ? 1:2;
                            }];
    return count;
}

- (NSString *)nb_stringForMaxLength:(NSUInteger)nb_MaxLength{
    return [self nb_stringForMaxLength:nb_MaxLength truncatingTail:NO];
}

- (NSString *)nb_stringForMaxLength:(NSUInteger)nb_MaxLength  truncatingTail:(BOOL)trail{
    __block NSUInteger count = 0;
    __block NSString *handledStr = [self copy];
    //如果不超过 maxLength，则直接返回
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length)
                                 options:NSStringEnumerationByComposedCharacterSequences
                              usingBlock:^(NSString *substring,NSRange substringRange,NSRange enclosingRange,BOOL *stop){
                                  if (1 == substring.length) {
                                      if (isascii([substring characterAtIndex:0])) {
                                          count += 1;
                                      }else{
                                          count += 2;
                                      }
                                  }else{
                                      count += [substring length];
                                  }

                                  if (count > nb_MaxLength) {
                                      if(trail){
                                          handledStr = [[self substringToIndex:substringRange.location-1] stringByAppendingString:@"..."];
                                      }else{
                                          handledStr = [self substringToIndex:substringRange.location];
                                      }
                                      *stop = YES;
                                  }
                              }];
    return handledStr;
}
@end
