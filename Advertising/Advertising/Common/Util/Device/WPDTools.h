//
//  WPDTools.h
//  WPD
//
//  Created by chenshenyi on 15/10/21.
//  Copyright © 2015年 Huarong Wealth Manage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WPDTools : NSObject

/**
 *获取当前网络的ip地址
 */
+ (NSString *)currentAppIPAddress;

/**
 *获取系统版本号
 */
+ (NSString *)currentAppVersion;

/**
 *获取手机系统版本
 *
 */
+ (NSString *)phoneSystemVersion;

/**
 *系统名
 */
+ (NSString *)phoneName;

/**
 *获取程序的主窗口
 */
+ (UIWindow *)getKeyWindow;

/**
 *获取当前设备
 */
+ (NSString *)getCurrentDevice;

/**
 *给定一个版本字符串, 获取对应一个数字字符串
 */
+ (NSString *)getVersionWithString:(NSString *)str;

/**
 *获取mac地址
 */
+ (NSString *)macAddress;

/**
 *获取当前网络状态
 */
+ (NSString *)getNetworkType;

/**
 *获取设备
 */
+ (NSString *)getDeviceModel;

+ (NSString *)getDeviceIMSI;

/**
 *获取设备UUID
 */
+ (NSString *)getDeviceUUID;

/**
 *解析文件
 */
+ (id)parseWithFilePath:(NSString *)filePath;

@end
