//
//  MLLabel+AutoSize.m
//  pengpeng
//
//  Created by jianwei.chen on 15/11/2.
//  Copyright © 2015年 AsiaInnovations. All rights reserved.
//

#define LABEL ((MLLinkLabel*)self.label)
#import "MLExpression+NBExpressionExp.h"
#import "MLLabel+AutoSize.h"


@implementation MLLabel (AutoSize)

@end


@implementation MLLinkLabel(AutoSize)
static MLLinkLabel *s_shareLabel = nil;
+(MLLinkLabel *)shareLabel{
    if (s_shareLabel == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            s_shareLabel = [[MLLinkLabel alloc] init];
            s_shareLabel.lineSpacing = 5.0;
//            s_shareLabel.textColor = [UIColor redColor];
//            s_shareLabel.font = [UIFont systemFontOfSize:14.0f];
            s_shareLabel.numberOfLines = 0;
            s_shareLabel.textAlignment = NSTextAlignmentLeft;
            s_shareLabel.allowLineBreakInsideLinks = NO;
            s_shareLabel.linkTextAttributes = nil;
            s_shareLabel.activeLinkTextAttributes = nil;

        });
    }
    return s_shareLabel;
}

+ (CGSize)sizeForText:(NSString *)text
         withMaxWidth:(CGFloat)maxWidth
              andFont:(UIFont *)txtFont
         andLineSpace:(CGFloat)lineSpace
            lineMultiple:(CGFloat)lineMultiple{
    [[self shareLabel] setFrame:CGRectMake(0, 0, maxWidth, 0)];
    [[self shareLabel] setFont:txtFont];
    [[self shareLabel] setLineSpacing:lineSpace];
    [self refreshLabel:[self shareLabel] withMessage:text lineMultiple:lineMultiple];
    CGSize size = [[self shareLabel] sizeThatFits:CGSizeMake(maxWidth, CGFLOAT_MAX)];
    return size;
}

+(void)refreshLabel:(MLLinkLabel *)label withMessage:(NSString *)message lineMultiple:(CGFloat)multiple{
    MLExpression *exp = [MLExpression nb_expressionExp];
    NSAttributedString *attStr = [MLExpressionManager expressionAttributedStringWithString:message expression:exp withLineLineHeightMultiple:multiple];
    label.attributedText = attStr;
}
@end
