//
//  WPDTools.m
//  WPD
//
//  Created by chenshenyi on 15/10/21.
//  Copyright © 2015年 Huarong Wealth Manage. All rights reserved.
//

#import "WPDTools.h"
//ip
#import <ifaddrs.h>
#import <arpa/inet.h>
//mac
#import <sys/utsname.h>

#import <sys/socket.h>
#import <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
//运营商
#include <CoreTelephony/CTCarrier.h>
#include <CoreTelephony/CTTelephonyNetworkInfo.h>

@implementation WPDTools

/**
 *获取当前网络的ip地址
 */
+ (NSString *)currentAppIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    //retrieve the current interfaces - return 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        //loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

/**
 *获取系统版本号
 */
+ (NSString *)currentAppVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

/**
 *获取手机系统版本
 *
 */
+ (NSString *)phoneSystemVersion
{
    return [UIDevice currentDevice].systemVersion;
}

/**
 *系统名
 */
+ (NSString *)phoneName
{
    return [UIDevice currentDevice].systemName;
}

/**
 *获取程序的主窗口
 */
+ (UIWindow *)getKeyWindow
{
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            
            return window;
    }
    
    return [UIApplication sharedApplication].keyWindow;
}

/**
 *获取当前设备
 */
+ (NSString *)getCurrentDevice
{
    return [[UIDevice currentDevice].model substringToIndex:4];
}

/**
 *给定一个版本字符串, 获取对应一个数字字符串
 */
+ (NSString *)getVersionWithString:(NSString *)str
{
    NSArray *strArray = [str componentsSeparatedByString:@"."];
    NSMutableArray *versionArray = [NSMutableArray arrayWithArray:strArray];
    if (strArray.count == 2) {
        [versionArray addObject:@"00"];
    }
    NSMutableString *version = [NSMutableString string];
    for (NSString *str in versionArray) {
        NSString *numberStr = [NSString string];
        if (str.length == 1) {
            numberStr = [NSString stringWithFormat:@"0%@", str];
        } else {
            numberStr = str;
        }
        [version appendFormat:@"%@", numberStr];
    }
    return version;
}

/**
 *获取mac地址
 */
+ (NSString *)macAddress
{
    int mib[6];
    size_t len;
    char * buf;
    unsigned char * ptr;
    struct if_msghdr * ifm;
    struct sockaddr_dl * sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *macString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return macString;
}

+ (NSString *)getNetworkType
{
    NSArray *infoArray = [[[[UIApplication sharedApplication] valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    int type = 0;
    for (id info in infoArray) {
        if ([info isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            type = [[info valueForKey:@"dataNetworkType"] intValue];
            break;
        }
    }
    switch (type) {
        case 0:
            return @"未知网络/没有网络";
            break;
        case 1:
            return @"2G网络";
            break;
        case 2:
            return @"3G网络";
            break;
        case 3:
            return @"4G网络";
            break;
        case 5:
            return @"WiFi网络";
            break;
        default:
            return @"未知网络";
            break;
    }
    
}

+ (NSString *)getDeviceModel
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return platform;
}

+ (NSString *)getDeviceIMSI
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    return [NSString stringWithFormat:@"%@",[carrier carrierName]];
}

+ (NSString *)getDeviceUUID
{
    NSUUID * udid = [[UIDevice currentDevice] identifierForVendor];
    NSString * uuid = udid.UUIDString;
    return uuid;
}

/**
 *解析文件
 */
+ (id)parseWithFilePath:(NSString *)filePath
{
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    return object;
}

@end
