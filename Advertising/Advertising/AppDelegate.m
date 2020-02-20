//
//  AppDelegate.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "AppDelegate.h"
#import "XMLunchController.h"
#import "XMConfigureUtil.h"
#import "XMBaseTabBarController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "XMTestController.h"
#import "WXApi.h"
#import "XMVersionUpdateUtil.h"
#import "XMTestController.h"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];

    
    // Base类的一些配置信息
    XMLunchController *lunchVC = [XMLunchController new];
    self.window.rootViewController = lunchVC;
    
    // 第三方工具配置初始化信息
    [XMConfigureUtil sharedOneTimeClass];

    [self.window makeKeyAndVisible];
    
    return YES;
}




- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
//    if ([[url absoluteString] hasPrefix:@"xiangmu_aliPay"]) {
//        //跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            NSLog(@"result = %@",resultDic);
//
//        }];
//    }
    
    return [WXApi handleOpenURL:url delegate:self];
    
//    if ([url.host isEqualToString:@"pay"]) {
//        [WXApi handleOpenURL:url delegate:self];
//    }
    
//    if ([[url absoluteString] hasPrefix:@"weixin"]) {
//        [WXApi handleOpenURL:url delegate:self];
//    }
    
    
//    return YES;
}


#pragma mark - WXApiDelegate==========================WXApiDelegate

//微信支付回调
- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[PayResp class]])
    {
        PayResp *response = (PayResp *)resp;
        switch (response.errCode)
        {
                case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                NSLog(@"支付成功");
                [[NSNotificationCenter defaultCenter] postNotificationName:kWeiXinNotiFication_OrderOK object:nil userInfo:nil];
                break;
                case WXErrCodeUserCancel:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                [[NSNotificationCenter defaultCenter] postNotificationName:kWeiXinNotiFication_OrderCancel object:nil userInfo:nil];
                //交易取消
                break;
            default:
//                NSLog(@"支付失败， retcode=%d",resp.errCode);
                [[NSNotificationCenter defaultCenter] postNotificationName:kWeiXinNotiFication_OrderCancel object:nil userInfo:nil];
                break;
        }
    }
}


- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler
{
    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
  
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication * )application
{
    // 版本检查更新
    if (kLoginManager.userToken) {
        [XMVersionUpdateUtil checkUpdate:nil];
    }

}



- (void)applicationWillTerminate:(UIApplication *)application {

}



@end
