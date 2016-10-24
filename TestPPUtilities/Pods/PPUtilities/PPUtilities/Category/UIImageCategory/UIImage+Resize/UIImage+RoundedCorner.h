// UIImage+RoundedCorner.h
// Created by Trevor Harmon on 9/20/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

// Extends the UIImage class to support making rounded corners
@interface UIImage (RoundedCorner)

///图片加圆角 + borderWidth
- (UIImage *)imageWithCornerRadius:(NSInteger)radius borderWidth:(NSInteger)borderWidth;

///图片加圆角
- (UIImage *)imageWithCornerRadius:(NSInteger)radius;


@end

@interface UIImage (Circle)
///如果imageWidth == imageHeight 返回圆形图片，否则为椭圆
- (UIImage*)circleImage;

@end
