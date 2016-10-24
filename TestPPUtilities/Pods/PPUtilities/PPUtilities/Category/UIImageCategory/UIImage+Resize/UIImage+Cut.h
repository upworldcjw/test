//
//  UIImage+Cut.h
//  CalendarLib
//
//  Created by wang yepin on 13-4-18.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Cut)

//截取部分图像
///截取图像注意这个Rect指的是CGImageRef。size * screenScale = CGImageRef的size
- (UIImage *)subImageInRect:(CGRect)rect;

///此方法会返回一个图片的尺寸为size的UIImage。如25*25 显示在30*10区域，则返回的30*10的图片，图片内容不变形。
- (UIImage *)scaleToSize:(CGSize)size;

///此方法根据size返回实际需要图片的size（保证图片不变形）如25*25的图片显示在30*10，则实际返回为10*10的图片
- (UIImage *)scaleToFitSize:(CGSize)size;

@end
