//
//  UIAlertController+IKActionSheet.m
//  inke
//
//  Created by 孙西纯 on 16/8/8.
//  Copyright © 2016年 MeeLive. All rights reserved.
//

#import "UIAlertController+IKActionSheet.h"

@interface UILabel (IKActionSheet)

- (void)setAppearanceFont:(UIFont *)font;

- (void)setAppearanceTextColor:(UIColor *)color;
@end

@implementation UILabel (IKActionSheet)

- (void)setAppearanceFont:(UIFont *)font{
    if(font){
        [self setFont:font];
    }
}

- (void)setAppearanceTextColor:(UIColor *)color{
    if(color){
        [self setTextColor:color];
    }
}

@end

@implementation UIAlertController (IKActionSheet)

- (void)setTextFont:(UIFont *)font textColor:(UIColor *)color{
    UILabel *appearanceLabel;

    if ([[[UIDevice currentDevice] systemVersion] doubleValue] < 9.0) {
        appearanceLabel = [UILabel appearanceWhenContainedIn:self.class, nil];
    }else{
        appearanceLabel = [UILabel appearanceWhenContainedInInstancesOfClasses:@[self.class]];
    }
    [appearanceLabel setAppearanceFont:font];
    [appearanceLabel setAppearanceTextColor:color];
}

@end

@implementation UIAlertAction (IKActionSheet)

- (void)setTextColor:(UIColor *)color{
    if (color) {
        [self setValue:color forKey:@"_titleTextColor"];
    }
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
