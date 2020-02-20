//
//  RKTestRequest.m
//  Refactoring
//
//  Created by dingqiankun on 2019/4/1.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMTestRequest.h"
#import "XMDataModel.h"

@implementation XMTestRequest

- (Class)modelInArray
{
    return XMDataModel.class;
}

- (id)requestArgument
{
    NSMutableDictionary *argumentDict = [super requestArgument];
    [argumentDict addEntriesFromDictionary:@{@"item": @"1", @"keyword": @"男", @"siteId": @(1), @"sort": @(1)}];
    
    return argumentDict;
}

- (NSString *)baseUrl
{
    return @"https://backend.wsy.com";
}


- (NSString *)requestUrl
{
    return @"/api-buyer/app-home-api/search";
}


@end
