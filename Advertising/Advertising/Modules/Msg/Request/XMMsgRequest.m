//
//  XMMsgRequest.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/3.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMMsgRequest.h"

@implementation XMMsgPageRequest

- (NSString *)requestUrl
{
    return @"api/message/getMessageList";
}

- (id)requestArgument
{
    NSMutableDictionary *dict = [super requestArgument];
    [dict addEntriesFromDictionary:@{@"status":@(self.status)}];
    return dict;
}

- (Class)modelInArray
{
    return XMMsgItemModel.class;
}

- (NSString *)keyForArray
{
    return @"records";
}


- (Class)modelClass
{
    return XMMsgModel.class;
    
}


@end


@implementation XMMsgSetReadRequest


- (NSString *)requestUrl
{
    return @"api/message/getMessageInfo";
}

- (id)requestArgument
{
    return @{@"id":@(self.Id)};
}


@end
