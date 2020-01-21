//
//  GaussiImage.m
//  MeeChat
//
//  Created by HouGuangling on 15/3/27.
//  Copyright (c) 2015年 HouGuangling. All rights reserved.
//

#import "IKGaussiImage.h"
#import <Accelerate/Accelerate.h>
#import "FCBasics.h"

@implementation IKGaussiImage


+ (UIImage *)gaussi:(UIImage *)image value:(CGFloat)val
{
    if (val < 0.f || val > 1.f) {
        val = 0.5f;
    }
    int boxSize = (int)(val * 100);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    if (pixelBuffer == NULL) IKLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize,
                                       boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        IKLogE(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo info = CGImageGetBitmapInfo(img);
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes,
                                             colorSpace, info);
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    // clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}
@end
