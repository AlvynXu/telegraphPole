//
//  XMPayUtil.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/3.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMPayUtil.h"
#import "WXApi.h"

@implementation XMPayUtil

+ (NSString *)weiXinPay:(NSDictionary *)dict comple:(WeiXinPayBlock)payblcok;
{
    if ([dict.allKeys count] > 0) {
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = [[dict objectForKey:@"timestamp"] intValue];
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];
        
        // 微信配置
        [WXApi registerApp:[dict objectForKey:@"appid"] universalLink:@"https://help.wechat.com/sdksample/abc"];
        
        [WXApi sendReq:req completion:^(BOOL success) {
            if (payblcok) {
                payblcok(success);
            }
        }];
        //日志输出
        
        NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
        return @"";
    }else{
        [XMHUD showFail:@"支付失败"];
    }
    return nil;
}

@end
