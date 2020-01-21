//
//  NSString+IKModel.m
//  IKBaseModel
//
//  Created by Chenxiaocheng on 17/2/20.
//  Copyright © 2017年 inke. All rights reserved.
//

#import "NSString+IKModel.h"
#import <IKFoundation/IKFoundation.h>

@implementation NSString (IKModel)

- (NSDictionary *)ik_queryParamsToDic
{
    NSMutableDictionary *dic           = [NSMutableDictionary dictionary];
    NSArray             *urlComponents = [self componentsSeparatedByString:@"&"];
    
    for (NSString *keyValuePair in urlComponents) {
        NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
        
        if (pairComponents && [pairComponents count] == 2) {
            NSString *key = [[pairComponents firstObject] stringByRemovingPercentEncoding];
            NSString *value = [[pairComponents lastObject] stringByRemovingPercentEncoding];
            if (!kIsEmptyString(key)) {
                [dic setObject:NSStringNONil(value) forKey:key];
            }
        }
    }
    
    return dic;
}

@end
