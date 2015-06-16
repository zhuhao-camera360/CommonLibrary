//
//  NSDictionary+CommonJson.m
//  CommonLibrary
//
//  Created by zhuhao on 15/6/16.
//  Copyright (c) 2015年 zhuhao. All rights reserved.
//

#import "NSDictionary+CommonJson.h"

@implementation NSDictionary (CommonJson)

- (NSString *)c_stringForKey:(id)aKey
{
    NSString *strRet = nil;
    id value = self[aKey];
    if ([value isKindOfClass:[NSString class]])
    {
        strRet = value;
    }
    else if ([value isKindOfClass:[NSNumber class]])
    {
        strRet = [value stringValue];
    }
    else if ([value isKindOfClass:[NSArray class]] ||
             [value isKindOfClass:[NSDictionary class]] ||
             [value isKindOfClass:[NSNull class]])
    {
    }
    else
    {
    }
    return strRet;
}


- (NSInteger)c_integerForKey:(id)aKey
{
    NSInteger iRet = -1;
    id value = self[aKey];
    if (value)
    {
        if ([value isKindOfClass:[NSString class]])
        {
            if ([[value lowercaseString] isEqualToString:@"true"])
            {
                value = @"1";
            }
            iRet = [value integerValue];
        }
        else if ([value isKindOfClass:[NSNumber class]])
        {
            iRet = [value integerValue];
        }
        else if ([value isKindOfClass:[NSArray class]] ||
                 [value isKindOfClass:[NSDictionary class]] ||
                 [value isKindOfClass:[NSNull class]])
        {
        }
        else
        {
        }
    }
    return iRet;
}


@end
