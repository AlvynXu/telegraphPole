//
//  NdUncaughtExceptionHandler.m
//  BaseProject
//
//  Created by yezhongzheng on 17/1/17.
//  Copyright © 2017年 yezhongzheng. All rights reserved.
//
#import "NdUncaughtExceptionHandler.h"
#import "WPDTools.h"


///返回绝对路径
NSString *applicationDocumentsDirectory() {
    return KCrashLogPath;
}

void UncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *sversion  = [NSString stringWithFormat:@"ios %@", [WPDTools currentAppVersion]];
    NSString *phoneVersion = [WPDTools phoneSystemVersion];
    NSString *mac = [WPDTools macAddress];
    NSString *type = [WPDTools getNetworkType];
    NSString *model = [WPDTools getDeviceModel];
    NSString *imsi = [WPDTools getDeviceIMSI];
    NSString *deviceID = [WPDTools getDeviceUUID];
    NSString *url = [NSString stringWithFormat:@"=============异常崩溃报告=============\nname:\n%@\nreason:\n%@\ncallStackSymbols:\n%@\nsversion:%@\nphoneVersion:%@\nmac:%@\ntype:%@\nmodel:%@\nimsi:%@\ndeviceID:%@",
                     name,reason,[arr componentsJoinedByString:@"\n"], sversion, phoneVersion, mac, type, model, imsi, deviceID];
    NSString *path = [KCrashLogPath stringByAppendingPathComponent:@"CrashLog.txt"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isDirExist = [fileManager fileExistsAtPath:KCrashLogPath isDirectory:&isDir];
    if (!(isDir && isDirExist)) {
        [fileManager createDirectoryAtPath:KCrashLogPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    BOOL result = [url writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    //除了可以选择写到应用下的某个文件，通过后续处理将信息发送到服务器等
    //还可以选择调用发送邮件的的程序，发送信息到指定的邮件地址
    //或者调用某个处理程序来处理这个信息
    if (result) {
        NSLog(@"有新崩溃日志生成");
        //这里可以写一些监听崩溃信息的代码
    } else {
        NSLog(@"没有新崩溃日志生成");
    }
}
@implementation NdUncaughtExceptionHandler

//返回绝对路径
-(NSString *)applicationDocumentsDirectory {
    return KCrashLogPath;
}

+ (void)setDefaultHandler
{
    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
}

+ (NSUncaughtExceptionHandler*)getHandler
{
    return NSGetUncaughtExceptionHandler();
}

@end
