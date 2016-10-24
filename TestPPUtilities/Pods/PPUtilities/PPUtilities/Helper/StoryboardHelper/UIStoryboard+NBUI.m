//
//  UIStoryboard+NBUI.m
//
//  Created by 巩 鹏军
//

#import "UIStoryboard+NBUI.h"

@implementation UIStoryboard (NBUI)

+ (instancetype)mainStoryboard;
{
    return [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
}

@end
