//
//  XMHomeGuidVm.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/4.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMHomeGuidVm.h"
#import "XMHomeGuidView.h"

@implementation XMHomeGuidVm

+ (void)firstLoadGuid
{
    
    // 引导图取消
    NSString *appVersion = [kUserDefaults objectForKey:kApp_Version];
    if (appVersion.length) {
        // 不是第一次安装
    }else{
        [kUserDefaults setValue:kApp_Version forKey:kApp_Version];
        [kUserDefaults synchronize];
    }

    
//     NSString *appVersion = [kUserDefaults objectForKey:kApp_Version];
//    if (appVersion.length) {
//        // 不是第一次安装
//    }else{
//        XMHomeGuidView *guid1 = [[XMHomeGuidView alloc]initWithFrame:kWindow.bounds];
//        guid1.step = 1;
//        guid1.baseImgV.image = kGetImage(@"home_guid_one");
//        XMHomeGuidView *guid2 = [[XMHomeGuidView alloc]initWithFrame:kWindow.bounds];
//        guid2.step = 2;
//        guid2.baseImgV.image = kGetImage(@"home_guid_two");
//
//        [[guid1.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//            // 移除第一步
//            [guid1 removeFromSuperview];
//            // 添加第二步
//            [kWindow addSubview:guid2];
//        }];
//        [kWindow addSubview:guid1];
//
//        [[guid2.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//            // 移除 进入主页
//            [guid2 removeFromSuperview];
//            // 同时保存状态
//            // 保存当前版本号
//            [kUserDefaults setValue:kApp_Version forKey:kApp_Version];
//            [kUserDefaults synchronize];
//        }];
//    }
}

@end
