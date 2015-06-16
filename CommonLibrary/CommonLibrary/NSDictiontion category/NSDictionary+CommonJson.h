//
//  NSDictionary+CommonJson.h
//  CommonLibrary
//
//  Created by zhuhao on 15/6/16.
//  Copyright (c) 2015年 zhuhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (CommonJson)


/**
 * 通过key获取string
 */
- (NSString *)c_stringForKey:(id)aKey;


/**
 * 通过key获取int
 */
- (NSInteger)c_integerForKey:(id)aKey;


@end
