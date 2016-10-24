// UIImage+Alpha.h
// Created by Trevor Harmon on 9/20/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

// Helper methods for adding an alpha layer to an image
@interface UIImage (Alpha)

- (BOOL)hasAlpha;
/// 返回带alpha通道的图片
- (UIImage *)imageWithAlpha;

/// 图片边缘加透明border
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;

@end
