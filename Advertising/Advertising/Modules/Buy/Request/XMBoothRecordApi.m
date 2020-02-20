//
//  XMBoothRecordApi.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/5.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBoothRecordApi.h"

@implementation XMBoothRecordApi

- (NSString *)requestUrl
{
    return @"api/booth/getCurrentUserBooth";
}

- (id)requestArgument
{
    NSMutableDictionary *pageDict = [super requestArgument];
    [pageDict addEntriesFromDictionary:@{@"status":@(1)}];
    return pageDict;
}

- (Class)modelClass
{
    return XMBoothRecordModel.class;
}

- (Class)modelInArray
{
    return XMBoothRecordsItemModel.class;
}

- (NSString *)keyForArray
{
    return @"records";
}


@end
