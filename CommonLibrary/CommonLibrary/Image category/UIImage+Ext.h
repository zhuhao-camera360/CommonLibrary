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
