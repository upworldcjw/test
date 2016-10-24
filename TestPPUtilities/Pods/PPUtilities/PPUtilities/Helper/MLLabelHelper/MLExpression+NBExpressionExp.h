//
//  MLExpression+NBExpressionExp.h
//  pengpeng
//
//  Created by ios_feng on 15/10/30.
//  Copyright © 2015年 AsiaInnovations. All rights reserved.
//

#import <MLLabel/MLLabel.h>
#import <MLLabel/NSString+MLExpression.h>

extern NSString * const kExpressionExp;

@interface MLExpression (NBExpressionExp)
+ (MLExpression *)nb_expressionExp;

+ (NSString *)imageNameForEmotionKey:(NSString *)key;

+ (BOOL)isEmotionKey:(NSString *)key;

@end


@interface NSString(EmotionSupport)
-(BOOL)emotionKeyAtEnd:(NSRange *)atRange;
@end


