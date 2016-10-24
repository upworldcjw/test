//
//  UIViewController+BarButton.m
//  pengpeng
//
//  Created by jianwei.chen on 15/11/18.
//  Copyright © 2015年 AsiaInnovations. All rights reserved.
//

#import "UIViewController+BarButton.h"
#define NavigationHeiht 44

@interface NavBackButton : UIButton
@property (nonatomic,assign) NBCustomedNavBackStyle type;
@property (nonatomic,assign) BOOL showBackImage;
@end

@implementation NavBackButton

+ (instancetype)backButtonWithType:(NBCustomedNavBackStyle)type{
    NavBackButton *backButton = [NavBackButton buttonWithType:UIButtonTypeCustom];
//    backButton.adjustsImageWhenDisabled = NO;
    backButton.adjustsImageWhenHighlighted = NO;
    backButton.type = type;
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    
    NSString *imageName = nil;
    NSString *selectedImg = nil;
    switch (type) {
        case NBCustomedNavBack_WhiteStyle://白色返回按钮
            imageName = @"nav_back_white";
//            selectedImg = @"nav_back_pink";
            break;
        default:
            imageName = @"nav_back_pink";//粉色返回按钮
            break;
    }
    [backButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (selectedImg) {
        [backButton setImage:[UIImage imageNamed:selectedImg] forState:UIControlStateHighlighted];
    }
    //按钮颜色
    if (type == NBCustomedNavBack_PinkStyle) {
        UIColor *grayColor = [UIColor colorWithRed:1 green:0x80/255.0 blue:0 alpha:1];
        [backButton setTitleColor:grayColor forState:UIControlStateNormal];//DEFAULT_MAINBODY_COLOR
        UIColor *highLightedColor = [UIColor colorWithRed:1 green:0x80/255.0 blue:0 alpha:0.7];
        [backButton setTitleColor:highLightedColor forState:UIControlStateHighlighted];
    }else if(type == NBCustomedNavBack_WhiteStyle){
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor colorWithWhite:1 alpha:.7] forState:UIControlStateHighlighted];
    }
    return backButton;
}
//8 * 15
-(CGSize)properImageSize{
    if (!self.showBackImage) {
        return CGSizeMake(0, 0);
    }
    switch (self.type) {
        case NBCustomedNavBack_WhiteStyle:
        case NBCustomedNavBack_PinkStyle:
        default:
            return CGSizeMake(8, 15);
    }
    return CGSizeMake(8, 15);
}

-(CGFloat)titleMarginToBackImage{
    if (!self.showBackImage) {
        return 0;
    }
    switch (self.type) {
        case NBCustomedNavBack_WhiteStyle:
        case NBCustomedNavBack_PinkStyle:
        default:
            return 5;
    }
}

//44,44
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGSize imageSize = [self properImageSize];
    CGRect imageRect = CGRectZero;
    imageRect.size = imageSize;
    imageRect.origin = CGPointMake(0, (NavigationHeiht - imageSize.height)/2.0);
    return imageRect;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGSize imageSize = [self properImageSize];
    CGFloat titleMarginLeft = [self titleMarginToBackImage];
    CGFloat beginX = imageSize.width + titleMarginLeft;
    return CGRectMake(beginX, 0, contentRect.size.width - beginX, contentRect.size.height);
}

-(CGRect)properRectForBackTitle:(NSString *)title{
    CGSize imageSize = [self properImageSize];
    CGFloat titleMarginLeft = [self titleMarginToBackImage];
    CGSize titleSize = CGSizeZero;
    if (title.length >0) {
         titleSize = [title sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    }
    
    CGFloat width = imageSize.width + titleMarginLeft + titleSize.width;
    if (width > 100) {//控制宽度
        width = 100;
    }
    return CGRectMake(0, 0, width, NavigationHeiht);
}
@end


@implementation UIViewController (BarButton)
- (UIButton *)leftBarButton
{
    if ([self.navigationItem.leftBarButtonItem.customView isKindOfClass:[UIButton class]]) {
        return (UIButton *)(self.navigationItem.leftBarButtonItem.customView);
    }
    return nil;
}

#pragma mark - Nav Back Button
- (void)navItem:(UINavigationItem *)navItem setBackBarItemWithTitle:(NSString *)title{
    navItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)setBackBarItemWithTitle:(NSString *)title
{
    NSAssert(title.length > 0, @"fatal error");
    // http://stackoverflow.com/questions/18870128/ios-7-navigation-bar-custom-back-button-without-title
    // Set this in every view controller so that the back button displays back instead of the root view controller name
    [self navItem:self.navigationItem setBackBarItemWithTitle:title];
}

/*
 *Nav Left Button
 *orginaze by jianwei.chen
 */
- (void)setLeftBarItemWithButton:(UIButton *)button{
    if (!button) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];//防止backBarButton起作用
    }else{
        [button addTarget:self action:@selector(leftBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
}

#pragma mark - Nav Left Button

- (void)setLeftBarItemWithTitle:(NSString *)title
{
    [self setLeftBarItemStyle:NBCustomedNavBack_PinkStyle withTitle:title showBackImg:NO];
}

- (void)setLeftBarItemWithTitle:(NSString *)title showBackImg:(BOOL)showBack{
    [self setLeftBarItemStyle:NBCustomedNavBack_PinkStyle withTitle:title showBackImg:showBack];
}

- (void)setLeftBarItemStyle:(NBCustomedNavBackStyle)style withTitle:(NSString *)title showBackImg:(BOOL)showBack{
    UIButton *button = [self navButtonWithItemStyle:style title:title showBackImg:showBack];
    [self setLeftBarItemWithButton:button];
}

- (UIButton *)navButtonWithItemStyle:(NBCustomedNavBackStyle)style title:(NSString *)title showBackImg:(BOOL)showBack{
    if (!showBack && title.length == 0) {
        return nil;
    }
    NavBackButton *button = [NavBackButton backButtonWithType:style];
    button.showBackImage = showBack;
    [button setTitle:title forState:UIControlStateNormal];
    CGRect frame = [button properRectForBackTitle:title];
    button.frame = frame;
    return button;
}

- (void)setLeftBarItemWithNormalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName
{
    UIButton *button = [self navButtonWithNormalImageName:normalImageName selectedImageName:selectedImageName];
    [self setLeftBarItemWithButton:button];
}

- (UIButton *)navButtonWithNormalImageName:(NSString *)normalImageName
                         selectedImageName:(NSString *)selectedImageName{
    if([normalImageName length] == 0) {
        return nil;
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    button.frame = CGRectMake(0, 0, normalImage.size.width, normalImage.size.height);
    [button setBackgroundImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    return button;
}
@end
