//
//  UIImage+Color.m
//  CommonLibrary
//
//  Created by zhuhao on 15/5/10.
//  Copyright (c) 2015年 zhuhao. All rights reserved.
//

#import "UIImage+Ext.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageFromView:(UIView *)theView
{
    UIGraphicsBeginImageContextWithOptions(theView.frame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext: context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark -
#pragma mark - 水印

+ (UIImage *)waterMarkImageWithImage:(UIImage*)sourceImage info:(NSString*)text
{
    
    int imageW = sourceImage.size.width;
    int imageH = sourceImage.size.height;
    NSInteger fontSize = 20;
    
    CGSize size = [self boundingRectWithText:text size:CGSizeMake(imageW, 20) fontSize:fontSize];
    CGPoint point = CGPointMake(imageW - size.width - 10, imageH - size.height - 10);
    
    UIImage *waterImage = [self waterMarkImageWithImage:sourceImage info:text atPoint:point];
    
    return waterImage;
}

+ (UIImage *)waterMarkImageWithImage:(UIImage*)sourceImage info:(NSString*)text atPoint:(CGPoint)point
{

    NSInteger fontSize = 20;
    
    UIGraphicsBeginImageContextWithOptions(sourceImage.size, NO, /*[UIScreen mainScreen].scale*/0);
    
    [sourceImage drawAtPoint:CGPointZero];
    
    
    NSDictionary* dict=@{NSFontAttributeName:[UIFont fontWithName:@"Arial-BoldItalicMT" size:fontSize],NSForegroundColorAttributeName:[UIColor redColor]};
    [text drawAtPoint:point withAttributes:dict];
    
    UIImage *waterImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return waterImage;
}


+ (UIImage *)waterMarkImageWithImage:(UIImage*)sourceImage
                           markImage:(UIImage*)markImage
                             atPoint:(CGPoint)point
                          waterAlpha:(CGFloat)alpha
{
    UIGraphicsBeginImageContextWithOptions(sourceImage.size, NO, /*[UIScreen mainScreen].scale*/0);
    
    [sourceImage drawAtPoint:CGPointZero];
  
    [markImage drawAtPoint:point blendMode:kCGBlendModeNormal alpha:alpha];
    
    UIImage *waterImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return waterImage;
}


#pragma mark -
#pragma mark - 模糊

/**
 *  模糊图片
 *
 *  @param blur 0~1
 *
 *  @return 模糊后的图片
 */
- (UIImage *)blueImage:(CGFloat)blur
{
    return [self blueImage:blur tintColor:nil];
}


/**
 *  模糊图片
 *
 *  @param blur      0~1
 *  @param tintColor 颜色
 *
 *  @return 模糊后的图片
 */
- (UIImage *)blueImage:(CGFloat)blur tintColor:(UIColor*)tintColor
{
    return [self blueImage:blur tintColor:tintColor count:1];
}

- (UIImage *)blueImage:(CGFloat)blur tintColor:(UIColor*)tintColor count:(int)count
{
    NSData *imageData = UIImageJPEGRepresentation(self, 0.001);
    UIImage *downSampledImage = [UIImage imageWithData:imageData];
    
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = downSampledImage.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    
    //create vImage_Buffer with data from CGImageRef
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //create vImage_Buffer for output
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    //perform convolution
    count = count < 1 ? 1 : count;
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    for(int i=0; i<count; i++)
    {
        error = vImageBoxConvolve_ARGB8888(&outBuffer, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    }
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    
    if (tintColor)
    {
        CGRect imageRect = {CGPointZero, downSampledImage.size};
        
        // Add in color tint.
        if (tintColor) {
            CGContextSaveGState(ctx);
            CGContextSetFillColorWithColor(ctx, tintColor.CGColor);
            CGContextFillRect(ctx, imageRect);
            CGContextRestoreGState(ctx);
        }
    }
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    //free(pixelBuffer2);
    
    CFRelease(inBitmapData);
    
    CGImageRelease(imageRef);
    
    return returnImage;
}

#pragma mark -
#pragma mark - private

+ (CGSize)boundingRectWithText:(NSString*)text size:(CGSize)size fontSize:(NSInteger)fontSize
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    
    CGSize retSize = [text boundingRectWithSize:size
                                             options:
                      NSStringDrawingUsesLineFragmentOrigin
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}



@end
