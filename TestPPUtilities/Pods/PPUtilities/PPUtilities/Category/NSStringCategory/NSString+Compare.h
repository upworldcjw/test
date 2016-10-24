//
//  NSString+Compare.h
//  pengpeng
//
//  Created by 巩鹏军 on 15/4/27.
//  Copyright (c) 2015年 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Compare)

- (BOOL)nb_containsString:(NSString *)aString; // 不区分大小写，支持iOS 8一下的系统

- (BOOL)nb_containsString:(NSString *)aString
                  options:(NSStringCompareOptions)mask;

@end
