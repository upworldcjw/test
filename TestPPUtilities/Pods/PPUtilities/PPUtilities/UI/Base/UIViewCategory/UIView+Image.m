//
//  UIView+Image.m
//  Pods
//
//  Created by jianwei.chen on 16/1/27.
//
//

#import "UIView+Image.h"

@implementation UIView (Image)

- (UIImage *)exportToImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 2.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}


- (UIImage *)exportToImage:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

@end
