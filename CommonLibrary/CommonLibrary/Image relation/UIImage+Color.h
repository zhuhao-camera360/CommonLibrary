//
//  UIImage+Color.h
//  CommonLibrary
//
//  Created by zhuhao on 15/5/10.
//  Copyright (c) 2015年 zhuhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

/**
 *  根据颜色值，生成 UIImage
 *
 *  @param color 指定的颜色
 *
 *  @return 根据颜色 生成的UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
