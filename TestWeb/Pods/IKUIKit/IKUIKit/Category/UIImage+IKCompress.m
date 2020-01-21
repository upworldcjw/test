//
//  UIImage+IKCompress.m
//  imageCompressDemo
//
//  Created by zld on 01/04/2017.
//  Copyright © 2017 zld. All rights reserved.
//

#import "UIImage+IKCompress.h"

static const CGFloat ikDefaultCompressQuality = 0.9;
static const CGFloat ikDefaultMaxBytes = 100 * 1024;
static const CGFloat ikDefaultMaxWidth = 800;
static const CGFloat ikDefaultMaxHeight = 640;

//#ifndef IKICDebugLog
//#ifdef DEBUG
//#define IKICDebugLog(log, ...) do{ NSLog((log), ##__VA_ARGS__); } while(0)
//#else
//#define IKICDebugLog(log) YES
//#endif
//#endif

@implementation UIImage (IKCompress)

- (UIImage *)compressedImageWithMaxSize:(CGSize)size maxBytes:(NSUInteger)maxBytes leastCompressQuality:(CGFloat)leastCompressQuality maxCompressQuality:(CGFloat)maxCompressQuality completion:(IKImageCompressCompletionBlock)completion {
    
    BOOL isMaxBytesSetManually = maxBytes;
    BOOL isSuperWideOrSuperHighImage = NO;
    
//    IKICDebugLog(@"Image Compress Start");
    
    UIImage *image = [self copy];
    
    // resize image if needed
    CGFloat newScale = 1;
    if (size.width == 0 || size.height == 0) {
        size = CGSizeMake(ikDefaultMaxWidth, ikDefaultMaxHeight);
    }
    
    if (image.size.width > size.width || image.size.height > size.height) {
        CGFloat wScale = size.width / image.size.width;
        CGFloat hScale = size.height / image.size.height;
        // horizonal, vertical super size
        if (MAX(image.size.width/image.size.height, image.size.height/image.size.width) >= 16.f/9.f) {
            newScale = MAX(wScale, hScale);
            isSuperWideOrSuperHighImage = YES;
        } else {
            newScale = wScale <= hScale ? wScale : hScale;
        }
        newScale = newScale < 1 ? newScale : 1;
    }
    
    image = newScale == 1 ? image : [self scaleWithSize:CGSizeMake(self.size.width * newScale, self.size.height * newScale)];
    
    // compress by reducing quality
    CGFloat compressQuality = maxCompressQuality ?: ikDefaultCompressQuality;
    leastCompressQuality = leastCompressQuality ?: 0.3;
    maxBytes = maxBytes ?: ikDefaultMaxBytes;
    
//#ifdef DEBUG
//    CGFloat testCompressQuality = 0.9;
//    NSData *testImageData = UIImageJPEGRepresentation(image, testCompressQuality);
//    while (testCompressQuality > 0) {
//        testImageData = UIImageJPEGRepresentation(image, testCompressQuality);
//        IKICDebugLog(@"Test Data Length: %lu, quality: %f", (unsigned long)testImageData.length, testCompressQuality);
//        testCompressQuality -= 0.1;
//    }
//#endif
    
    // TODO: maybe very slow here
    NSData *imageData = UIImageJPEGRepresentation(image, compressQuality);
    while (imageData.length > maxBytes && compressQuality > leastCompressQuality) {
        imageData = UIImageJPEGRepresentation(image, compressQuality);
//        IKICDebugLog(@"Data Length: %lu", (unsigned long)imageData.length);
        compressQuality -= 0.1;
    }
    
    // still too big
    if (imageData.length > maxBytes && !isSuperWideOrSuperHighImage && isMaxBytesSetManually) {
        do {
            newScale *= 0.9;
            image = [self scaleWithSize:CGSizeMake(self.size.width * newScale, self.size.height * newScale)];
            
            imageData = UIImageJPEGRepresentation(image, maxCompressQuality ?: ikDefaultCompressQuality);
            while (imageData.length > maxBytes && compressQuality > leastCompressQuality) {
                compressQuality -= 0.1;
                imageData = UIImageJPEGRepresentation(image, compressQuality);
//                IKICDebugLog(@"Again Data Length: %lu", (unsigned long)imageData.length);
            }
        } while (imageData.length > maxBytes);
    }
    
    image = [[UIImage alloc] initWithData:imageData];
    
//    IKICDebugLog(@"Image Compress Finished - Final Quality:%f, Final Scale:%f", compressQuality, newScale);
//    IKICDebugLog(@"Result: width:%.1f, height:%.1f, size:%lu", image.size.width, image.size.height, imageData.length);
    
    if (completion) {
        completion(image, image.size, imageData.length, compressQuality);
    }
    
    return image;
}

- (UIImage*)scaleWithSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

#pragma mark -

- (UIImage *)compressedImage {
    return [self compressedImageWithMaxSize:CGSizeZero maxBytes:0 leastCompressQuality:0 maxCompressQuality:0 completion:nil];
}

- (UIImage *)compressedImageWithMaxBytes:(NSUInteger)maxBytes {
    return [self compressedImageWithMaxSize:CGSizeZero maxBytes:maxBytes leastCompressQuality:0 maxCompressQuality:0 completion:nil];
}

- (UIImage *)compressedImageWithMaxSize:(CGSize)size maxBytes:(NSUInteger)maxBytes {
    return [self compressedImageWithMaxSize:size maxBytes:maxBytes leastCompressQuality:0 maxCompressQuality:0 completion:nil];
}

- (UIImage *)compressedImageWithMaxSize:(CGSize)size maxBytes:(NSUInteger)maxBytes leastCompressQuality:(CGFloat)leastCompressQuality {
    return [self compressedImageWithMaxSize:size maxBytes:maxBytes leastCompressQuality:leastCompressQuality maxCompressQuality:0 completion:nil];
}

@end
