//
//  UIImage+Cut.m
//  CalendarLib
//
//  Created by wang yepin on 13-4-18.
//
//

#import "UIImage+Cut.h"

@implementation UIImage (Cut)
//截取部分图像
///截取图像注意这个Rect指的是CGImageRef
-(UIImage*)subImageInRect:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CFRelease(subImageRef);
    
    return smallImage;
}

///等比例缩放
///此方法会返回一个图片的尺寸为size的UIImage。如25*25 显示在30*10区域，则返回的30*10的图片，图片内容不变形。
-(UIImage*)scaleToSize:(CGSize)size
{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1)//目标大 》 实际图片
    {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else//目标 《 实际图片
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    // 创建一个bitmap的context
    UIGraphicsBeginImageContextWithOptions(size, NO, .0);
    ///设置参数获取高质量代码
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(contextRef, kCGInterpolationHigh);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

///等比例缩放
///此方法根据 size 返回实际需要图片的高度。保证图片不变形。如25*25的图片显示在30*10，则实际返回为10*10的图片
- (UIImage *)scaleToFitSize:(CGSize)size;
{
    CGSize oriSize = self.size;
    
    float verticalRadio = oriSize.height/size.height*1.0;
    float horizontalRadio = oriSize.width /size.width*1.0;
    
    float radio = 1.0;
    int width1 = 0;
    int height1 = 0;
    if (verticalRadio > 1 && horizontalRadio > 1) {//表示图片大小 > size
        radio = verticalRadio > horizontalRadio ? verticalRadio : horizontalRadio;
        width1 = oriSize.width/radio;
        height1 = oriSize.height/radio;
    }
    else if(verticalRadio<=1 && horizontalRadio>1){
        
        width1 = size.width;
        height1 = oriSize.height/horizontalRadio;
    }
    else if(verticalRadio>1 && horizontalRadio<=1){
        width1 = oriSize.width/verticalRadio;
        height1 = size.height;
    }else{///图片太小，size太大
        return self;// 返回实际大小
    }
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width1, height1));
    ///设置参数获取高质量代码
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(contextRef, kCGInterpolationHigh);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, width1, height1)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

// 缩放从顶部开始平铺图片
- (UIImage *)imageScaleAspectFillFromTop:(CGSize)frameSize {
    CGFloat screenScale = [UIScreen mainScreen].scale;
    CGFloat radio = self.size.height / self.size.width;
    // 缩放
    UIImage *adjustedImg = [self scaleToSize:CGSizeMake(frameSize.width * screenScale,
                                                         frameSize.width * screenScale * radio)];
    // 裁剪
    adjustedImg = [adjustedImg subImageInRect:CGRectMake(0, 0, frameSize.width * screenScale,
                                                         frameSize.width * screenScale)];
    
    return adjustedImg;
}




@end
