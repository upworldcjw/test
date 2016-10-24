//
//  NSString+Length.h
//  pengpeng
//
//  Created by jianwei.chen on 15/12/9.
//  Copyright © 2015年 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Length)
//ascii 为1，其他为2
- (uint)nb_inputLength;

///maxLength 一般是nb_inputLength的返回
- (NSString *)nb_stringForMaxLength:(NSUInteger)nb_MaxLength;

///maxLength 一般是nb_inputLength的返回,trail为yes的话，如果字符>nb_MaxLength则第nb_MaxLength-1个字符用"。。。"替代
- (NSString *)nb_stringForMaxLength:(NSUInteger)nb_MaxLength  truncatingTail:(BOOL)trail;

@end
