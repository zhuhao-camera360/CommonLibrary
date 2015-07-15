//
//  UIImage+Color.h
//  CommonLibrary
//
//  Created by zhuhao on 15/5/10.
//  Copyright (c) 2015年 zhuhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Ext)

/**
 *  根据颜色值，生成 UIImage
 *
 *  @param color 指定的颜色
 *
 *  @return 根据颜色 生成的UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color;


/**
 * 对view 进行截图
 */
+ (UIImage *)imageFromView:(UIView *)theView;


// ////////////////////////////////////////////////////////////////////////////

/**
 *  对一张 图片 添加 文字水印
 *
 *  @param sourceImage 要加 水印 的 图片
 *  @param text        要加 的 文字
 *
 *  @return 加好水印的 图片
 */
+ (UIImage *)waterMarkImageWithImage:(UIImage*)sourceImage info:(NSString*)text;


/**
 *  对一张 图片 添加 文字水印
 *
 *  @param sourceImage 要加 水印 的 图片
 *  @param text        要加 的 文字
 *  @param point       加文字的 位置
 *
 *  @return 加好水印的 图片
 */
+ (UIImage *)waterMarkImageWithImage:(UIImage*)sourceImage info:(NSString*)text atPoint:(CGPoint)point;


/**
 *  对 一张 图片添加 水印
 *
 *  @param sourceImage 要加水印 的图片
 *  @param markImage   水印照片
 *  @param point       加水印的位置
 *  @param alpha       水印的透明度(1 : 不透明  0：完全透明)
 *
 *  @return 加好水印效果的图片
 */
+ (UIImage *)waterMarkImageWithImage:(UIImage*)sourceImage
                           markImage:(UIImage*)markImage
                             atPoint:(CGPoint)point
                          waterAlpha:(CGFloat)alpha;



// ////////////////////////////////////////////////////////////////////////////

/**
 *  模糊图片
 *
 *  @param blur      0~1
 *  @param tintColor 颜色
 *
 *  @return 模糊后的图片
 */
- (UIImage *)blueImage:(CGFloat)blur tintColor:(UIColor*)tintColor;



@end
