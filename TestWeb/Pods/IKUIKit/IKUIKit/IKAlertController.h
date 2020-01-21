//
//  IKAlertController.h
//  IKUIKit
//
//  Created by zld on 17/05/2017.
//  Copyright © 2017 inke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKThemeDefine.h"

// 如果只想改其中一个按钮，可以直接用默认颜色补充另一个
#define IKAlertControllerDefaultGreenColor colorWithHexString(@"0x4D97A7")
#define IKAlertControllerDefaultGrayColor colorWithHexString(@"0x999999")

typedef void(^IKAlertControllerActionBlock)(NSUInteger index);

typedef NS_ENUM(NSUInteger, IKAlertControllerStyle) {
    IKAlertControllerOneButtonStyle,    // 底部一个按钮
    IKAlertControllerTwoButtonStyle,    // 底部两个按钮
};

typedef NS_OPTIONS(NSUInteger, IKAlertOptions) {
    IKAlertOptionDefault = 1 << 0,
    IKAlertOptionDissmissWhenClickOutside = 1 << 1,
    IKAlertOptionDisableButtons = 1 << 2,
};

@interface IKAlertController : UIViewController

// buttonTextArray 可以是NSString，也可以是NSAttributedString，用来支撑带图片的富文本

+ (void)alertWithStyle:(IKAlertControllerStyle)style
           contentText:(NSString *)contentText
       buttonTextArray:(NSArray *)buttonTextArray
           actionBlock:(IKAlertControllerActionBlock)actionBlock;

+ (void)alertWithStyle:(IKAlertControllerStyle)style
 attributedContentText:(NSAttributedString *)attributedContentText
       buttonTextArray:(NSArray *)buttonTextArray
           actionBlock:(IKAlertControllerActionBlock)actionBlock;

+ (void)alertWithStyle:(IKAlertControllerStyle)style
 attributedContentText:(NSAttributedString *)attributedContentText
     customContentSize:(CGSize)customContentSize
       buttonTextArray:(NSArray *)buttonTextArray
           actionBlock:(IKAlertControllerActionBlock)actionBlock;

// 需要指定按钮颜色的情况
// 颜色数组传nil会使用默认颜色，第一个是灰色，第二个是绿色
+ (void)alertWithStyle:(IKAlertControllerStyle)style
           contentText:(NSString *)contentText
       buttonTextArray:(NSArray *)buttonTextArray
      buttonColorArray:(NSArray<UIColor *> *)buttonColorArray
           actionBlock:(IKAlertControllerActionBlock)actionBlock;

+ (void)alertWithStyle:(IKAlertControllerStyle)style
 attributedContentText:(NSAttributedString *)attributedContentText
       buttonTextArray:(NSArray *)buttonTextArray
      buttonColorArray:(NSArray<UIColor *> *)buttonColorArray
           actionBlock:(IKAlertControllerActionBlock)actionBlock;

// 正文是有标题、内容的
// 如果需要标题、内容attributed化的，直接用上面的方法自己写在attributedContent里
+ (void)alertWithStyle:(IKAlertControllerStyle)style
                 title:(NSString *)title
           contentText:(NSString *)contentText
       buttonTextArray:(NSArray *)buttonTextArray
           actionBlock:(IKAlertControllerActionBlock)actionBlock;

+ (void)alertWithStyle:(IKAlertControllerStyle)style
                 title:(NSString *)title
           contentText:(NSString *)contentText
       buttonTextArray:(NSArray *)buttonTextArray
      buttonColorArray:(NSArray<UIColor *> *)buttonColorArray
           actionBlock:(IKAlertControllerActionBlock)actionBlock;

// 自定义view
+ (void)alertWithStyle:(IKAlertControllerStyle)style
            customView:(UIView *)customView
        customViewSize:(CGSize)customViewSize
       buttonTextArray:(NSArray *)buttonTextArray
           actionBlock:(IKAlertControllerActionBlock)actionBlock;

// 万能
+ (void)alertWithStyle:(IKAlertControllerStyle)style
               options:(IKAlertOptions)options
                 title:(NSString *)title
           contentText:(NSString *)contentText
       attributedTitle:(NSAttributedString *)attributedTitle
 attributedContentText:(NSAttributedString *)attributedContentText
            customView:(UIView *)customView
        customViewSize:(CGSize)customViewSize
       buttonTextArray:(NSArray *)buttonTextArray
      buttonColorArray:(NSArray<UIColor *> *)buttonColorArray
           actionBlock:(IKAlertControllerActionBlock)actionBlock;

@end
