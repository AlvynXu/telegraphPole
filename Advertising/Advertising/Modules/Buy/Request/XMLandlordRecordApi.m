//
//  XMLandlordRecordApi.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/5.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMLandlordRecordApi.h"


@implementation XMLandlordRecordApi

- (NSString *)requestUrl
{
    return @"api/street/getCurrentUserStreet";
}

- (id)requestArgument
{
    NSMutableDictionary *pageDict = [super requestArgument];
    [pageDict addEntriesFromDictionary:@{@"status":@(1)}];
    return pageDict;
}

- (Class)modelInArray
{
    return XMLanlordRecordsItemModel.class;
}

- (NSString *)keyForArray
{
    return @"records";
}

- (Class)modelClass
{
    return XMLanlordRecordModel.class;
}

@end

@implementation XMLandlordGetNumApi

- (NSString *)requestUrl
{
    return @"api/users/getChooseCount";
}

- (Class)modelClass
{
    return XMBoothRecordGetNumModel.class;
}

@end

