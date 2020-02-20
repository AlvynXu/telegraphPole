//
//  ConstantMacro.h
//  Refactoring
//
//  Created by dingqiankun on 2019/3/18.
//  Copyright © 2019 rongshu. All rights reserved.
//

#ifndef ConstantMacro_h
#define ConstantMacro_h

// 屏幕尺寸
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScaleW(width) (width) * (kScreenWidth) / 375
#define kScaleH(height) (height) * (kScreenHeight) / 667
// 安全区域
#define kNabigationSafeArea (MAX(kScreenWidth, kScreenHeight)  == 812 ? 88 : 64)
#define kTabbarSafeArea (MAX(kScreenWidth, kScreenHeight)  == 812 ? 83 : 49)



#define EMPTY_STRING(string) \
( [string isKindOfClass:[NSNull class]] || \
string == nil || [string isEqualToString:@""] || \
[string isEqualToString:@"null"] || \
[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)

// 字体\颜色
#define kSysFont(size) [UIFont systemFontOfSize:size]
#define kBoldFont(size) [UIFont boldSystemFontOfSize:size]

#define kRGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define kRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define kHexColor(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]
#define kHexColorA(c, a) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:a]

// 线条颜色
#define kLineBorderColor [UIColor colorWithRed:((0xEDEDED>>16)&0xFF)/255.0 green:((0xEDEDED>>8)&0xFF)/255.0 blue:(0xEDEDED&0xFF)/255.0 alpha:1.0]

#define kDisEnableColor [UIColor colorWithRed:((0xB5B5B5>>16)&0xFF)/255.0 green:((0xB5B5B5>>8)&0xFF)/255.0 blue:(0xB5B5B5&0xFF)/255.0 alpha:1.0]


// 常用对象方法
#define kGetImage(name) [UIImage imageNamed:name]
#define kFormat(string, args...) [[NSString stringWithFormat:string, args] stringByReplacingOccurrencesOfString:@"(null)" withString:@""]

// 常用对象
#define kWindow [[UIApplication sharedApplication] delegate].window
#define kUserDefaults [NSUserDefaults standardUserDefaults]

// 设备判断
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)

#define kIphone4        ([[UIScreen mainScreen] bounds].size.height == 480.f)
#define kIphone5        ([[UIScreen mainScreen] bounds].size.height == 568.f) // 640 * 1336 (5, 5s)
#define kIphone6        ([[UIScreen mainScreen] bounds].size.height == 667.f) // 750 * 1334 (6, 6s, 7)
#define kIphone6p       ([[UIScreen mainScreen] bounds].size.height == 736.f) // 1242 * 2208 (6 plus, 7plus)
#define kIphoneX        ([[UIScreen mainScreen] bounds].size.height == 812.f) // 1125 * 2436 (X)

// 判断是否是刘海屏
#define kIsIphoneX        ([[UIScreen mainScreen] bounds].size.height >= 812.f) // 1125 * 2436 (X)

//#define kIsIphoneX ({\
//BOOL isPhoneX = NO;\
//if (@available(iOS 11.0, *)) {\
//if (!UIEdgeInsetsEqualToEdgeInsets([UIApplication sharedApplication].delegate.window.safeAreaInsets, UIEdgeInsetsZero)) {\
//isPhoneX = YES;\
//}\
//}\
//isPhoneX;\
//})

// 版本号
#define kApp_Version [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]
// APP显示名称
#define kApp_Name ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"])
// build版本号
#define kApp_BuildVersion [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"]
#define KCrashLogPath [NSString stringWithFormat:@"%@/Documents/crash", NSHomeDirectory()]



/*****  容易变动修改的  ****/
#define kUnPubKey @"b2a0be44-57a0-493c-a521-7ce4db4007db" // 有盾publicKey

#define kTuoChuan @"50dec4d4aec13fa549ad36173281d7e4"   // 拓传参数

//腾讯异常上报appid
#define kBuglyAppID @"df5c903f31"
//腾讯异常上报appkey
#define kBuglyAppKey @"8c0f60e5-ea4c-401f-bffc-4c2b7418f3d7"

// 主题颜色
#define kMainColor [UIColor colorWithRed:((0xFFFFCF46>>16)&0xFF)/255.0 green:((0xFFFFCF46>>8)&0xFF)/255.0 blue:(0xFFFFCF46&0xFF)/255.0 alpha:1.0]

#define kMainBackGroundColor [UIColor colorWithRed:((0xF7F7F7>>16)&0xFF)/255.0 green:((0xF7F7F7>>8)&0xFF)/255.0 blue:(0xF7F7F7&0xFF)/255.0 alpha:1.0]


#define kButton_tag 2020






/************  微信支付  *************/
#define kWeiXinId @"wx8c36899dfe6607fa"

// 微信支付成功
#define kWeiXinNotiFication_OrderOK @"kNotificationWXSuccess"
// 微信支付取消
#define kWeiXinNotiFication_OrderCancel @"kNotificationWXCancel"
// 微信支付失败
#define kWeiXinNotiFication_OrderFaile @"kNotificationWXFaile"
// 求租支付成功后刷新
#define kRentNotiFication_PaySuccessRefresh @"kNotificationRentPaySuccess"


#endif /* ConstantMacro_h */
