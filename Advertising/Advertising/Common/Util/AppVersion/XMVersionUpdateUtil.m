//
//  XMVersionUpdateUtil.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/5.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMVersionUpdateUtil.h"
#import "XMUpdateVersionRequest.h"
#import "QKAlertView.h"
#import "XMVersionView.h"

@interface XMVersionUpdateUtil()

@property(nonatomic, strong)XMUpdateVersionRequest *versionUpdateRequest;

@end

@implementation XMVersionUpdateUtil

// 检查更新
+ (void)checkUpdate:(UIView *)view
{
    if (view) {
        [view showLoadigWith:@"正在检查更新"];
    }
   XMUpdateVersionRequest *versionUpdateRequest= [XMUpdateVersionRequest request];
    [versionUpdateRequest startWithCompletion:^(__kindof XMUpdateVersionRequest * _Nonnull request, NSError * _Nonnull error) {
        [view hideLoading];
        if (request.businessSuccess) {
            XMUpdateModel *updateModel = request.businessModel;
            if (updateModel.hasUpdate == NO) {
                if (view) {
                    [XMHUD showText:@"已是最新版本"];
                }
                return ;
            }
            // 强制更新
            if (updateModel.forceUpdate) {
                // 否则开始更新
                XMVersionView *versionV = [XMVersionView new];
                versionV.versionLbl.text = kFormat(@"更新版本：%@", updateModel.appVersion);
                versionV.contentLbl.text = updateModel.updateInfo;
                
                QKAlertView *alertV = [[QKAlertView alloc] initWithCustomView:versionV buttonTitles:@"立即更新", nil];
                [alertV showWithCompletion:^(NSInteger index, NSString *msg) {
                    // 更新下载
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:updateModel.downloadPth]];
                    exit(0);  // 强制退出APP
                }];
            }else{
                // 否则开始更新
                XMVersionView *versionV = [XMVersionView new];
                versionV.versionLbl.text = kFormat(@"更新版本：%@", updateModel.appVersion);
                versionV.contentLbl.text = updateModel.updateInfo;
                QKAlertView *alertV = [[QKAlertView alloc] initWithCustomView:versionV buttonTitles:@"取消",@"立即更新", nil];
                [alertV showWithCompletion:^(NSInteger index, NSString *msg) {
                    if (index == 1) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:updateModel.downloadPth]];
                    }
                }];
            }
        }
    }];
}



@end
