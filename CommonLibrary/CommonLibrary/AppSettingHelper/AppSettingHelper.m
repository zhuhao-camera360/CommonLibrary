//
//  AppSettingHelper.m
//  CommonLibrary
//
//  Created by zhuhao on 15/7/15.
//  Copyright (c) 2015年 zhuhao. All rights reserved.
//

#import "AppSettingHelper.h"

@implementation AppSettingHelper

+(CGFloat)getAppCurrentVersion{
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];

    // app版本
    NSString *app_Version = [infoDict objectForKey:@"CFBundleShortVersionString"];
    
    
    return 1.0;
}

@end
