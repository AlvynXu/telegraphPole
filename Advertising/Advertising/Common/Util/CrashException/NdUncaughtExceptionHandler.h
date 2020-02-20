//
//  NdUncaughtExceptionHandler.h
//  BaseProject
//
//  Created by yezhongzheng on 17/1/17.
//  Copyright © 2017年 yezhongzheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NdUncaughtExceptionHandler : NSObject
/**
 *捕捉程序发生的异常
 *
 **/

+ (void)setDefaultHandler;

+ (NSUncaughtExceptionHandler *)getHandler;

@end
