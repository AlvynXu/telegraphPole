//
//  XMMyTeamRequest.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/2.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMMyTeamRequest.h"

@implementation XMMyTeamRequest

- (NSString *)requestUrl
{
    return @"api/users/getTeam";
}

- (Class)modelClass
{
    return XMTeamModel.class;
}


@end


@implementation XMMyTeamPageRequest

- (NSString *)requestUrl
{
    return @"api/users/getTeamPage";
}

- (Class)modelInArray
{
    return XMTeamPageItemModel.class;
}

- (NSString *)keyForArray
{
    return @"records";
}

- (Class)modelClass
{
    return XMTeamPageModel.class;
}


@end


@implementation XMMyProfitPageRequest

- (NSString *)requestUrl
{
    return @"api/users/getPayLog";
}

- (Class)modelInArray
{
    return XMProfitPageItemModel.class;
}

- (NSString *)keyForArray
{
    return @"records";
}

- (Class)modelClass
{
    return XMProfitPageModel.class;
}


@end

