//
//  UIImage+ImageEffects.h
//  inke
//
//  Created by Chenxiaocheng on 15/11/6.
//  Copyright (c) 2015年 MeeLive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (IKUtility)

- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius
                       tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                       maskImage:(UIImage *)maskImage;


- (UIImage *)getImageWithSize:(CGSize)size;

/**
 *​ @brief​   此方法作用为将一新图片在本图片中渲染合并，并将合并后的图片返回。
 *
 *​ @param   imgToAdd 要添到目标图片的图片
 *
 *​ @param   position 添加的图片在目标图片上渲染的位置
 *
 *​ @return  合并后的新图片
 */
-(UIImage *)imageCombinedWithImage:(UIImage *)imgToAdd atPosition:(CGPoint)position;


- (UIImage *)imageWithTintColor:(UIColor *)color;

+ (UIImage *)colorizeImage:(UIImage *)baseImage withColor:(UIColor *)theColor;

@end
