//
//  XMWalletRequest.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/17.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMWalletRequest.h"
#import "AFNetworking.h"

@implementation XMWithdrawRequest

- (NSString *)requestUrl
{
    return @"api/wxPay/transfer";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFormData:[kFormat(@"%@", self.amount) dataUsingEncoding:NSUTF8StringEncoding] name:@"amount"];
        
    };
}

@end


@implementation XMWithdrawLimitRequest

- (NSString *)requestUrl
{
    return @"api/balancePay/getRecharge";
}

- (Class)modelClass
{
    return XMMoneyModel.class;
}


@end


@implementation XMRechargeRequest

- (NSString *)requestUrl
{
    return @"api/wxPay/buy";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFormData:[kFormat(@"%@", self.amount) dataUsingEncoding:NSUTF8StringEncoding] name:@"amount"];
       
    };
}




@end
