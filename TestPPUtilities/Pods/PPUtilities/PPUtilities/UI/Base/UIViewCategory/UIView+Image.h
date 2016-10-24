//
//  UIView+Image.h
//  Pods
//
//  Created by jianwei.chen on 16/1/27.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Image)

- (UIImage *)exportToImage;

- (UIImage *)exportToImage:(CGSize)size;

@end
