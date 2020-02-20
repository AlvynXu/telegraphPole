//
//  XMBuyStateRequest.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/4.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBuyStateRequest.h"



@implementation XMBuyStateModel


@end

@implementation XMBuyStateRequest

- (NSString *)requestUrl
{
    return @"api/street/getDetail";
}

- (id)requestArgument
{
    return @{@"type":@(self.type), @"id":@(self.Id)};
}

- (Class)modelClass
{
    return XMBuyStateModel.class;
}


@end
