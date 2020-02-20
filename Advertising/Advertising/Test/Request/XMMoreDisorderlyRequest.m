//
//  RKMoreDisorderlyRequest.m
//  Refactoring
//
//  Created by dingqiankun on 2019/4/2.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMMoreDisorderlyRequest.h"

@implementation XMMoreDisorderlyDownRequest

- (NSString *)requestUrl
{
    return @"api-buyer/app-home-api/ranking-list";
}

- (id)requestArgument
{
    return @{@"siteId": @(self.siteId), @"pid":@(self.pid)};
}

@end

@implementation XMMoreDisorderlyUpRequest

- (NSString *)requestUrl
{
    return @"api-buyer/app-home-api/conf-renqi-ranking";
}

- (id)requestArgument
{
    return @{@"siteId": @(self.siteId), @"pid":@(self.rid)};
}

@end

