//
//  RKHUD.m
//  Refactoring
//
//  Created by dingqiankun on 2019/3/29.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation XMHUD

+ (MBProgressHUD *)hudWithView:(UIView *)view animated:(BOOL)animated
{
    MBProgressHUD *hud = nil;
    if (view == nil) {
        
        hud = [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
    } else {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    hud.label.numberOfLines = 0;
    return hud;
}

+ (void)showText:(NSString *)message
{
    MBProgressHUD *hud = [XMHUD hudWithView:nil animated:YES];
    hud.userInteractionEnabled = YES;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = kHexColorA(0x000000, 0.7);
    hud.label.text = message;
    hud.contentColor = kHexColorA(0xffffff, 1);
    hud.mode = MBProgressHUDModeText;
    NSInteger timestamp = [XMHUD timestampForMessage:message];
    [XMHUD hideAfterDelay:timestamp with:hud];
}

+ (void)showSuccess:(NSString *)message
{
    MBProgressHUD *hud = [XMHUD hudWithView:nil animated:YES];
    hud.minSize = CGSizeMake(100, 64);
    hud.contentColor = kHexColorA(0xffffff, 1);
    hud.bezelView.backgroundColor = kHexColorA(0x000000, 0.7);
//    hud.backgroundColor = kHexColorA(0x000000, 0.7);
//    hud.pro
    hud.label.text = message ? message : @"成功";
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:kGetImage(@"success-hud")];
    NSInteger timestamp = [XMHUD timestampForMessage:message];
    [XMHUD hideAfterDelay:timestamp with:hud];
}

+ (void)showFail:(NSString *)message;
{
    MBProgressHUD *hud = [XMHUD hudWithView:nil animated:YES];
    hud.minSize = CGSizeMake(100, 64);
    hud.contentColor = kHexColorA(0xffffff, 1);
    hud.bezelView.backgroundColor = kHexColorA(0x000000, 0.7);
    hud.label.text = message;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:kGetImage(@"failed-hud")];
    hud.label.numberOfLines = 0;
    NSInteger timestamp = [XMHUD timestampForMessage:message];
    [XMHUD hideAfterDelay:timestamp with:hud];
}

+ (void)showError:(NSError *)error
{
    [self showText:error.localizedDescription];
}

+ (NSInteger)timestampForMessage:(NSString *)message
{
    NSInteger timestamp = 2.5;
    if (message.length > 10) {
        timestamp = timestamp + (message.length - 10) * 0.25;
    }
    if (timestamp > 8) {
        timestamp = 8;
    }
    return timestamp;
}

+ (void)hideAfterDelay:(NSInteger)timestamp with:(MBProgressHUD *)hud
{
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:timestamp];
}

@end
