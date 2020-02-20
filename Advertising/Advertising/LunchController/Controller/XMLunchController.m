//
//  GXLunchController.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMLunchController.h"
#import "XMTestController.h"
#import "XMBaseNavigationController.h"
#import "XMWelcomeController.h"
#import "LYLocationUtil.h"
#import "WXApi.h"
#import "XMBaseTabBarController.h"
#import "XMLoginController.h"


@interface XMLunchController ()

@end

@implementation XMLunchController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerWeiXinID];
    [self getLocation];
    [self firstInstallCheck];
    
    
}

- (void)registerWeiXinID
{
//    [WXApi registerApp:kWeiXinId universalLink:@"UNIVERSAL_LINK"];
    
}


//
- (void)main
{
    [self setRootController];
}

- (void)setRootController
{
    // 进入主页后保存当前版本号
    if (kLoginManager.login) {
        kWindow.rootViewController = [XMBaseTabBarController new];
    }else{
        XMBaseNavigationController *rootNav = [[XMBaseNavigationController alloc] initWithRootViewController:[XMLoginController new]];
        [rootNav.navigationBar setHidden:YES];
        kWindow.rootViewController = rootNav;
    }
}

// 是否是第一次安装
- (void)firstInstallCheck
{
    // 获取本地存储的版本号
    NSString *appVersion = [kUserDefaults objectForKey:kApp_Version];
    if (appVersion.length) {
        // 不是第一次安装
        [self main];
    }else{
        // 第一次安装进入欢迎页面
        kWindow.rootViewController = [[XMBaseNavigationController alloc] initWithRootViewController:[XMWelcomeController new]];
    }
}

// 获取定位
- (void)getLocation
{
    if (@available(iOS 9.0, *))
    {
        [LYLocationUtil startLocateOnceWith:^(CLLocationManager *locationManager, NSArray<CLLocation *> *updateLocations) {
        } hudView:self.view];
    }
}




@end
