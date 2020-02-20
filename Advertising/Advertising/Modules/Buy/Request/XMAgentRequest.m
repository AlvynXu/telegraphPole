//
//  XMAgentRequest.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/30.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMAgentRequest.h"

@implementation XMAgentRequest

- (NSString *)requestUrl
{
    return @"api/aliPay/buyVip";
}


- (Class)modelClass
{
    return XMAgentModel.class;
}

@end

//

@implementation XMAgentWeiXinPayRequest

- (NSString *)requestUrl
{
    return @"api/wxPay/buyVip";
}


@end

