//
//  MLExpression+NBExpressionExp.m
//  pengpeng
//
//  Created by ios_feng on 15/10/30.
//  Copyright © 2015年 AsiaInnovations. All rights reserved.
//

#import "MLExpression+NBExpressionExp.h"

NSString * const kExpressionExp = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";

NS_INLINE NSString *expressionAtEndRegex(){//字符串最后是自定义表情。
    return [kExpressionExp stringByAppendingString:@"$"];
}

static NSString * const kExpressionBundle = @"CustomExpression";

@implementation MLExpression (NBExpressionExp)
+ (MLExpression *)nb_expressionExp
{
    static MLExpression *exp = nil;
    if (exp == nil)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            exp = [MLExpression expressionWithRegex:kExpressionExp plistName:@"Expression" bundleName:kExpressionBundle];
        });
    }
    return exp;
}

+ (NSString *)imageNameForEmotionKey:(NSString *)key{
    NSDictionary *dic = [[MLExpression nb_expressionExp] valueForKey:@"expressionMap"];//私有变量
    NSString *imgName = [dic valueForKey:key];
    if (imgName) {
        imgName = [kExpressionBundle stringByAppendingPathComponent:imgName];
    }
    return imgName;
}

+ (BOOL)isEmotionKey:(NSString *)key{
    return [[self imageNameForEmotionKey:key] length] >0;
}
@end



@implementation NSString(EmotionSupport)
-(BOOL)emotionKeyAtEnd:(NSRange *)atRange{
    //最后一个字符
    NSString *lastStr = [self substringFromIndex:[self length]-1];
    if([lastStr isEqualToString:@"]"]){//如果是自定义表情
        NSRange range = [self rangeOfString:expressionAtEndRegex() options:NSRegularExpressionSearch];
        //不能判断最后一个是否是表情，还是 【xx】输入其他文本
        if ((range.location + range.length) == [self length]) {//如果最后一个是自定义表情
            NSString *mayEmotionKey = [self substringWithRange:range];
            if ([MLExpression isEmotionKey:mayEmotionKey]) {//是表情
                if(atRange){
                    *atRange = range;
                }
                return YES;
            }
        }
    }
    return NO;
}
@end
