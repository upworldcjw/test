//
//  UIImage+IKCompress.h
//  imageCompressDemo
//
//  Created by zld on 01/04/2017.
//  Copyright © 2017 zld. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^IKImageCompressCompletionBlock)(UIImage *image, CGSize size, NSUInteger length, CGFloat finalQuality);

@interface UIImage (IKCompress)

- (UIImage *)compressedImage;
- (UIImage *)compressedImageWithMaxBytes:(NSUInteger)maxBytes;
- (UIImage *)compressedImageWithMaxSize:(CGSize)size maxBytes:(NSUInteger)maxBytes;
- (UIImage *)compressedImageWithMaxSize:(CGSize)size maxBytes:(NSUInteger)maxBytes leastCompressQuality:(CGFloat)leastCompressQuality;
- (UIImage *)compressedImageWithMaxSize:(CGSize)size
                               maxBytes:(NSUInteger)maxBytes
                   leastCompressQuality:(CGFloat)leastCompressQuality
                     maxCompressQuality:(CGFloat)maxCompressQuality
                             completion:(IKImageCompressCompletionBlock)completion;

@end
