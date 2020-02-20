//
//  RKConfigureUtil.m
//  Refactoring
//
//  Created by dingqiankun on 2019/3/21.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMConfigureUtil.h"
#import <JSPatchPlatform/JSPatch.h>

@implementation XMConfigureUtil

static XMConfigureUtil *_configureUtil;
+(XMConfigureUtil *)sharedOneTimeClass
{
    static dispatch_once_t oneToken;
    
    dispatch_once(&oneToken, ^{
        
        _configureUtil = [[XMConfigureUtil alloc]init];
        
    });
    
    return _configureUtil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self delegateLunchConfigure];
    }
    return self;
}

// delegate 启动一些配置信息
- (void)delegateLunchConfigure
{
    // 网络host配置
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = kHost;
   
    // 键盘配置
    [self _initalizeKeyboard];
    
    // 热修复
    [self initJSPatch];
    
    
    
}

// 键盘
- (void)_initalizeKeyboard {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    [IQKeyboardManager sharedManager].toolbarTintColor = kMainColor;
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;//控制点击背景是否收起键盘
}

// 初始化JSPatch
- (void)initJSPatch
{
//    [JSPatch testScriptInBundle];  // 热修复本地测试代码
    [JSPatch startWithAppKey:@"516c6d3bc8eaa922"];
    [JSPatch setupRSAPublicKey:@"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDFdWCTH/xXbzyQrl0x9CUXLzBG\n8hvmJu8rPWbBphkC3vf3//dKH1TRmdmDr5V4Jh8FLpbCHnAq+O66LuRC4gqfoiPH\n5qZo4VTDRCW17s9J7IQJhy2YTui1Ay6Iwn3XjdEgoM1oaT3rIN5elel1j+HCUqc/\n9t29FgVbBb2O/9oQRwIDAQAB\n-----END PUBLIC KEY-----"];
    [JSPatch sync];
}



@end
