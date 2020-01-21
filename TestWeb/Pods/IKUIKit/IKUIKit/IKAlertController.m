//
//  IKAlertController.m
//  IKUIKit
//
//  Created by zld on 17/05/2017.
//  Copyright © 2017 inke. All rights reserved.
//

#import "IKAlertController.h"
#import "Masonry.h"
#import <YYText.h>

@interface IKAlertController ()

// Data
@property (nonatomic, assign) IKAlertControllerStyle style;
@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, copy) NSString *contentText;
@property (nonatomic, copy) NSAttributedString *attributedTitleText;
@property (nonatomic, copy) NSAttributedString *attributedContentText;
@property (nonatomic, strong) NSArray *buttonTextArray;
@property (nonatomic, strong) NSArray<UIColor *> *buttonColorArray;
@property (nonatomic, copy) IKAlertControllerActionBlock actionBlock;
@property (nonatomic, assign) CGSize customViewSize;
@property (nonatomic, assign) IKAlertOptions options;

// UI Components
@property (nonatomic, strong) UIView *backgroundMaskView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) CALayer *containerBGLayer;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *longButton;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIView *customView;

// Assistant
@property (nonatomic, strong) UIWindow *mainWindow;
@property (nonatomic, strong) UIWindow *alertWindow;

@end

@implementation IKAlertController

- (instancetype)initWithStyle:(IKAlertControllerStyle)style
                        title:(NSString *)title
                  contentText:(NSString *)contentText
              attributedTitle:(NSAttributedString *)attributedTitle
        attributedContentText:(NSAttributedString *)attributedContentText
              buttonTextArray:(NSArray *)buttonTextArray
             buttonColorArray:(NSArray<UIColor *> *)buttonColorArray
                  actionBlock:(IKAlertControllerActionBlock)actionBlock {
    return [self initWithStyle:style
                         title:title
                   contentText:contentText
               attributedTitle:attributedTitle
         attributedContentText:attributedContentText
                    customView:nil
                customViewSize:CGSizeZero
               buttonTextArray:buttonTextArray
              buttonColorArray:buttonColorArray
                   actionBlock:actionBlock];
}

- (instancetype)initWithStyle:(IKAlertControllerStyle)style
                        title:(NSString *)title
                  contentText:(NSString *)contentText
              attributedTitle:(NSAttributedString *)attributedTitle
        attributedContentText:(NSAttributedString *)attributedContentText
                   customView:(UIView *)customView
               customViewSize:(CGSize)customViewSize
              buttonTextArray:(NSArray *)buttonTextArray
             buttonColorArray:(NSArray<UIColor *> *)buttonColorArray
                  actionBlock:(IKAlertControllerActionBlock)actionBlock{
    return [self initWithStyle:style
                       options:IKAlertOptionDefault
                         title:title
                   contentText:contentText
               attributedTitle:attributedTitle
         attributedContentText:attributedContentText
                    customView:customView
                customViewSize:customViewSize
               buttonTextArray:buttonTextArray
              buttonColorArray:buttonColorArray
                   actionBlock:actionBlock];
}

- (instancetype)initWithStyle:(IKAlertControllerStyle)style
                      options:(IKAlertOptions)options
                        title:(NSString *)title
                  contentText:(NSString *)contentText
              attributedTitle:(NSAttributedString *)attributedTitle
        attributedContentText:(NSAttributedString *)attributedContentText
                   customView:(UIView *)customView
               customViewSize:(CGSize)customViewSize
              buttonTextArray:(NSArray *)buttonTextArray
             buttonColorArray:(NSArray<UIColor *> *)buttonColorArray
                  actionBlock:(IKAlertControllerActionBlock)actionBlock{
    self = [super init];
    if (self) {
        _style = style;
        _options = options;
        _titleText = title;
        _contentText = contentText;
        _attributedTitleText = attributedTitle;
        _attributedContentText = attributedContentText;
        _customView = customView;
        _customViewSize = customViewSize;
        _buttonTextArray = buttonTextArray;
        _buttonColorArray = buttonColorArray;
        _actionBlock = actionBlock;
        [self layoutUI];
        [self loadData];
    }
    return self;
}

- (void)layoutUI {
    // Get Window
    self.mainWindow = [self windowWithLevel:UIWindowLevelNormal];
    self.alertWindow = [self windowWithLevel:UIWindowLevelAlert];
    
    if (!self.alertWindow) {
        self.alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.alertWindow.windowLevel = UIWindowLevelAlert;
        self.alertWindow.backgroundColor = [UIColor clearColor];
    }
    self.alertWindow.rootViewController = self;
    
    // For Animation
    self.backgroundMaskView.alpha = 0;
    self.containerView.alpha = 0;
    
    // Add UI & Layout
    [self.view addSubview:self.backgroundMaskView];
    if (self.options & IKAlertOptionDissmissWhenClickOutside) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        self.backgroundMaskView.userInteractionEnabled = YES;
        [self.backgroundMaskView addGestureRecognizer:tapGesture];
    }
    [self.view addSubview:self.containerView];
    if (self.customView) {
        [self.containerView addSubview:self.customView];
    } else {
        [self.containerView addSubview:self.contentLabel];
    }
    
    [self.backgroundMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@280);
        make.height.equalTo(@160);
        make.center.equalTo(self.view);
    }];
    
    if (self.customView) {
        [self.customView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 50 + 0 + 0.25, 0));
        }];
    } else {
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 16, 50 + 0 + 0.25, 16));
        }];
    }
    
    switch (_style) {
        case IKAlertControllerTwoButtonStyle:
        {
            [self.containerView addSubview:self.leftButton];
            [self.containerView addSubview:self.rightButton];
            
            [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.equalTo(@0);
                make.width.equalTo(@(140 - 0.25));
                make.height.equalTo(@(50 - 0.25));
            }];
            
            [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.bottom.equalTo(@0);
                make.width.equalTo(@(140 - 0.25));
                make.height.equalTo(@(50 - 0.25));
            }];
        }
            break;
        case IKAlertControllerOneButtonStyle:
        default:
        {
            [self.containerView addSubview:self.longButton];
            [self.longButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(@0);
                make.height.equalTo(@(50 - 0.25));
            }];
        }
            break;
    }
}

- (void)loadData {
    if (self.customView && self.customViewSize.height > 0) {
        CGFloat newContainerHeight = self.customViewSize.height + 50.25;
        [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@280);
            make.height.equalTo(@(newContainerHeight));
            make.center.equalTo(self.view);
        }];
        self.containerBGLayer.frame = CGRectMake(0, 0, 280, newContainerHeight-50.25);
    } else {
        if (self.attributedContentText) {
            self.contentLabel.attributedText = self.attributedContentText;
            
        } else if (self.titleText && self.titleText.length > 0) {
            NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] init];
            
            NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithString:self.titleText];
            attrTitle.yy_font = [UIFont systemFontOfSize:17];
            attrTitle.yy_color = colorWithHexString(@"0x333333");
            attrTitle.yy_lineSpacing = 12;
            attrTitle.yy_alignment = NSTextAlignmentCenter;
            
            NSMutableAttributedString *attrContent = [[NSMutableAttributedString alloc] initWithString:self.contentText];
            attrContent.yy_font = [UIFont systemFontOfSize:15];
            attrContent.yy_color = colorWithHexString(@"0x333333");
            attrContent.yy_lineSpacing = 6;
            attrContent.yy_alignment = NSTextAlignmentCenter;
            
            [attrString appendAttributedString:attrTitle];
            [attrString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
            [attrString appendAttributedString:attrContent];
            
            self.contentLabel.attributedText = attrString;
        } else {
            NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.contentText];
            attrString.yy_font = [UIFont systemFontOfSize:17];
            attrString.yy_color = colorWithHexString(@"0x333333");
            attrString.yy_lineSpacing = 8;
            attrString.yy_alignment = NSTextAlignmentCenter;
            self.contentLabel.attributedText = attrString;
        }
        
        if (self.customViewSize.height > 0) {
            [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@280);
                make.height.equalTo(@(self.customViewSize.height + 50.25));
                make.center.equalTo(self.view);
            }];
            self.containerBGLayer.frame = CGRectMake(0, 0, 280, self.customViewSize.height);
        } else {
            YYTextLayout *contentLayout = [YYTextLayout layoutWithContainerSize:CGSizeMake(280-32, CGFLOAT_MAX) text:self.contentLabel.attributedText];
            CGFloat textHeight = contentLayout.textBoundingRect.origin.y + contentLayout.textBoundingRect.size.height;
            CGFloat offset = 30;
            if (textHeight + offset > 160 - 50.25) {
                CGFloat newContainerHeight = textHeight + 50.25 + offset;
                [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(@280);
                    make.height.equalTo(@(newContainerHeight));
                    make.center.equalTo(self.view);
                }];
                self.containerBGLayer.frame = CGRectMake(0, 0, 280, newContainerHeight-50.25);
            }
        }
    }
    
    switch (self.style) {
        case IKAlertControllerTwoButtonStyle:
        {
            if (self.buttonColorArray && self.buttonColorArray.count >= 2) {
                [self.leftButton setTitleColor:self.buttonColorArray[0] forState:UIControlStateNormal];
                [self.rightButton setTitleColor:self.buttonColorArray[1] forState:UIControlStateNormal];
                
                UIColor *highlightedColor = [self darkerColorWithColor:self.buttonColorArray[0] darkValue:0.16];
                [self.leftButton setTitleColor:highlightedColor forState:UIControlStateHighlighted];
                
                UIColor *highlightedColor1 = [self darkerColorWithColor:self.buttonColorArray[1] darkValue:0.16];
                [self.rightButton setTitleColor:highlightedColor1 forState:UIControlStateHighlighted];
            }
            
            if (self.buttonTextArray && self.buttonTextArray.count >= 2) {
                id str0 = self.buttonTextArray[0];
                id str1 = self.buttonTextArray[1];
                
                if ([str0 isKindOfClass:[NSString class]]) {
                    [self.leftButton setTitle:str0 forState:UIControlStateNormal];
                } else if ([str0 isKindOfClass:[NSAttributedString class]]) {
                    [self.leftButton setAttributedTitle:str0 forState:UIControlStateNormal];
                }
                
                if ([str1 isKindOfClass:[NSString class]]) {
                    [self.rightButton setTitle:str1 forState:UIControlStateNormal];
                } else if ([str1 isKindOfClass:[NSAttributedString class]]) {
                    [self.rightButton setAttributedTitle:str1 forState:UIControlStateNormal];
                }
            }
        }
            break;
        case IKAlertControllerOneButtonStyle:
        {
            if (self.buttonColorArray && self.buttonColorArray.count >= 1) {
                [self.longButton setTitleColor:self.buttonColorArray[0] forState:UIControlStateNormal];
                
                UIColor *highlightedColor = [self darkerColorWithColor:self.buttonColorArray[0] darkValue:0.16];
                [self.longButton setTitleColor:highlightedColor forState:UIControlStateHighlighted];
            }
            
            if (self.buttonTextArray && self.buttonTextArray.count >= 1) {
                [self.longButton setTitle:self.buttonTextArray[0] forState:UIControlStateNormal];
            }
        }
        default:
            break;
    }
    
    if (self.options & IKAlertOptionDisableButtons) {
        self.longButton.enabled = NO;
        self.leftButton.enabled = NO;
        self.rightButton.enabled = NO;
    }
}

- (void)show {
    [self.alertWindow makeKeyAndVisible];
    self.containerView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    [UIView animateWithDuration:0.2 animations:^{
        self.containerView.transform = CGAffineTransformMakeScale(1, 1);
        self.backgroundMaskView.alpha = 1;
        self.containerView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    [self hideWithCompletion:nil];
}

- (void)hideWithCompletion:(void(^)())completion {
    [UIView animateWithDuration:0.2 animations:^{
        self.containerView.transform = CGAffineTransformMakeScale(0.8, 0.8);
        self.backgroundMaskView.alpha = 0;
        self.containerView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.alertWindow setHidden:YES];
        [self.alertWindow removeFromSuperview];
        self.alertWindow.rootViewController = nil;
        self.alertWindow = nil;
        [self.mainWindow makeKeyAndVisible];
        if (completion) {
            completion();
        }
    }];
}

#pragma mark - Tools

- (UIWindow *)windowWithLevel:(UIWindowLevel)windowLevel
{
    UIWindow *target = nil;
    
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in windows) {
        if (window.windowLevel == windowLevel) {
            target = window;
            return target;
        }
    }
    
    return target;
}

- (UIColor *)darkerColorWithColor:(UIColor *)color darkValue:(CGFloat)darkValue {
    darkValue = darkValue > 1 ? 1 : darkValue;
    UIColor *darkColor = color;
    CGFloat h, s, b, a;
    if ([color getHue:&h saturation:&s brightness:&b alpha:&a]) {
        darkColor = [UIColor colorWithHue:h saturation:s brightness:(b * (1 - darkValue)) alpha:a];
    }
    return darkColor;
}

#pragma mark - Actions

- (void)firstAction {
    [self hideWithCompletion:^{
        if (self.actionBlock) {
            self.actionBlock(0);
        }
    }];
}

- (void)secondAction {
    [self hideWithCompletion:^{
        if (self.actionBlock) {
            self.actionBlock(1);
        }
    }];
}

#pragma mark - Class Methods

+ (void)alertWithStyle:(IKAlertControllerStyle)style
           contentText:(NSString *)contentText
       buttonTextArray:(NSArray *)buttonTextArray
           actionBlock:(IKAlertControllerActionBlock)actionBlock {
    IKAlertController *alert = [[IKAlertController alloc] initWithStyle:style
                                                                  title:nil
                                                            contentText:contentText
                                                        attributedTitle:nil
                                                  attributedContentText:nil
                                                        buttonTextArray:buttonTextArray
                                                       buttonColorArray:nil
                                                            actionBlock:actionBlock];
    [alert show];
}

// 需要特殊处理的正文提示
+ (void)alertWithStyle:(IKAlertControllerStyle)style
 attributedContentText:(NSAttributedString *)attributedContentText
       buttonTextArray:(NSArray *)buttonTextArray
           actionBlock:(IKAlertControllerActionBlock)actionBlock {
    IKAlertController *alert = [[IKAlertController alloc] initWithStyle:style
                                                                  title:nil
                                                            contentText:nil
                                                        attributedTitle:nil
                                                  attributedContentText:attributedContentText
                                                        buttonTextArray:buttonTextArray
                                                       buttonColorArray:nil
                                                            actionBlock:actionBlock];
    [alert show];
    
}

+ (void)alertWithStyle:(IKAlertControllerStyle)style
 attributedContentText:(NSAttributedString *)attributedContentText
     customContentSize:(CGSize)customContentSize
       buttonTextArray:(NSArray *)buttonTextArray
           actionBlock:(IKAlertControllerActionBlock)actionBlock {
    IKAlertController *alert = [[IKAlertController alloc] initWithStyle:style
                                                                  title:nil
                                                            contentText:nil
                                                        attributedTitle:nil
                                                  attributedContentText:attributedContentText
                                                             customView:nil
                                                         customViewSize:customContentSize
                                                        buttonTextArray:buttonTextArray
                                                       buttonColorArray:nil
                                                            actionBlock:actionBlock];
    [alert show];
}

// 需要指定按钮颜色的情况
+ (void)alertWithStyle:(IKAlertControllerStyle)style
           contentText:(NSString *)contentText
       buttonTextArray:(NSArray *)buttonTextArray
      buttonColorArray:(NSArray<UIColor *> *)buttonColorArray
           actionBlock:(IKAlertControllerActionBlock)actionBlock {
    IKAlertController *alert = [[IKAlertController alloc] initWithStyle:style
                                                                  title:nil
                                                            contentText:contentText
                                                        attributedTitle:nil
                                                  attributedContentText:nil
                                                        buttonTextArray:buttonTextArray
                                                       buttonColorArray:buttonColorArray
                                                            actionBlock:actionBlock];
    [alert show];
}

+ (void)alertWithStyle:(IKAlertControllerStyle)style
 attributedContentText:(NSAttributedString *)attributedContentText
       buttonTextArray:(NSArray *)buttonTextArray
      buttonColorArray:(NSArray<UIColor *> *)buttonColorArray
           actionBlock:(IKAlertControllerActionBlock)actionBlock {
    IKAlertController *alert = [[IKAlertController alloc] initWithStyle:style
                                                                  title:nil
                                                            contentText:nil
                                                        attributedTitle:nil
                                                  attributedContentText:attributedContentText
                                                        buttonTextArray:buttonTextArray
                                                       buttonColorArray:buttonColorArray
                                                            actionBlock:actionBlock];
    [alert show];
}

// 正文是有标题、内容的
+ (void)alertWithStyle:(IKAlertControllerStyle)style
                 title:(NSString *)title
           contentText:(NSString *)contentText
       buttonTextArray:(NSArray *)buttonTextArray
           actionBlock:(IKAlertControllerActionBlock)actionBlock {
    IKAlertController *alert = [[IKAlertController alloc] initWithStyle:style
                                                                  title:title
                                                            contentText:contentText
                                                        attributedTitle:nil
                                                  attributedContentText:nil
                                                        buttonTextArray:buttonTextArray
                                                       buttonColorArray:nil actionBlock:actionBlock];
    [alert show];
}

+ (void)alertWithStyle:(IKAlertControllerStyle)style
                 title:(NSString *)title
           contentText:(NSString *)contentText
       buttonTextArray:(NSArray *)buttonTextArray
      buttonColorArray:(NSArray<UIColor *> *)buttonColorArray
           actionBlock:(IKAlertControllerActionBlock)actionBlock {
    IKAlertController *alert = [[IKAlertController alloc] initWithStyle:style
                                                                  title:title
                                                            contentText:contentText
                                                        attributedTitle:nil
                                                  attributedContentText:nil
                                                        buttonTextArray:buttonTextArray
                                                       buttonColorArray:buttonColorArray
                                                            actionBlock:actionBlock];
    [alert show];
}

// 自定义view
+ (void)alertWithStyle:(IKAlertControllerStyle)style
            customView:(UIView *)customView
        customViewSize:(CGSize)customViewSize
       buttonTextArray:(NSArray *)buttonTextArray
           actionBlock:(IKAlertControllerActionBlock)actionBlock {
    IKAlertController *alert = [[IKAlertController alloc] initWithStyle:style
                                                                  title:nil
                                                            contentText:nil
                                                        attributedTitle:nil
                                                  attributedContentText:nil
                                                             customView:customView
                                                         customViewSize:customViewSize
                                                        buttonTextArray:buttonTextArray
                                                       buttonColorArray:nil
                                                            actionBlock:actionBlock];
    [alert show];
}

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
           actionBlock:(IKAlertControllerActionBlock)actionBlock {
    IKAlertController *alert = [[IKAlertController alloc] initWithStyle:style
                                                                options:options
                                                                  title:title
                                                            contentText:contentText
                                                        attributedTitle:attributedTitle
                                                  attributedContentText:attributedContentText
                                                             customView:customView
                                                         customViewSize:customViewSize
                                                        buttonTextArray:buttonTextArray
                                                       buttonColorArray:buttonColorArray
                                                            actionBlock:actionBlock];
    [alert show];
}

#pragma mark - Getters

- (UIView *)backgroundMaskView {
    if (!_backgroundMaskView) {
        _backgroundMaskView = [[UIView alloc] init];
        _backgroundMaskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.16];
    }
    return _backgroundMaskView;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = colorWithHexString(@"0xDDDDDD");
        _containerView.clipsToBounds = YES;
        _containerView.layer.cornerRadius = 6;
        [_containerView.layer addSublayer:self.containerBGLayer];
    }
    return _containerView;
}

- (CALayer *)containerBGLayer {
    if (!_containerBGLayer) {
        _containerBGLayer = [[CALayer alloc] init];
        _containerBGLayer.backgroundColor = [UIColor whiteColor].CGColor;
        _containerBGLayer.frame = CGRectMake(0, 0, 280, 160-50);
    }
    return _containerBGLayer;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.clipsToBounds = YES;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.numberOfLines = 0;
        _contentLabel.backgroundColor = [UIColor whiteColor];
        _contentLabel.textColor = colorWithHexString(@"0x333333");
        _contentLabel.font = [UIFont systemFontOfSize:17];
    }
    return _contentLabel;
}

- (UIButton *)longButton {
    if (!_longButton) {
        _longButton = [[UIButton alloc] init];
        [_longButton addTarget:self action:@selector(firstAction) forControlEvents:UIControlEventTouchUpInside];
        _longButton.backgroundColor = [UIColor whiteColor];
        [_longButton setTitleColor:colorWithHexString(@"0x4D97A7") forState:UIControlStateNormal];
        [_longButton setBackgroundImage:[self highlightedBackgroundImage] forState:UIControlStateHighlighted];
        [_longButton setTitleColor:colorWithHexString(@"0x666666") forState:UIControlStateHighlighted];
        _longButton.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _longButton;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] init];
        [_leftButton addTarget:self action:@selector(firstAction) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.backgroundColor = [UIColor whiteColor];
        [_leftButton setTitleColor:colorWithHexString(@"0x999999") forState:UIControlStateNormal];
        [_leftButton setBackgroundImage:[self highlightedBackgroundImage] forState:UIControlStateHighlighted];
        [_leftButton setTitleColor:colorWithHexString(@"0x666666") forState:UIControlStateHighlighted];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] init];
        [_rightButton addTarget:self action:@selector(secondAction) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.backgroundColor = [UIColor whiteColor];
        [_rightButton setTitleColor:colorWithHexString(@"0x4D97A7") forState:UIControlStateNormal];
        [_rightButton setBackgroundImage:[self highlightedBackgroundImage] forState:UIControlStateHighlighted];
        [_rightButton setTitleColor:colorWithHexString(@"0x30616B") forState:UIControlStateHighlighted];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _rightButton;
}

- (UIImage *)highlightedBackgroundImage {
    CGSize imageSize = CGSizeMake(160, 50);
    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [colorWithHexString(@"0xF4F4F4") setFill];
    CGContextFillRect(context, CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
