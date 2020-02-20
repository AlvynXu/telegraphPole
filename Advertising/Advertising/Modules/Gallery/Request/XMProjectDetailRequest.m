//
//  XMProjectDetailRequest.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/18.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMProjectDetailRequest.h"

@implementation XMProjectDetailRequest
- (NSString *)requestUrl
{
    return @"api/mallItemInfo/getDetail";
}

- (id)requestArgument
{
     return @{@"itemId":@(self.itemId)};
}

- (Class)modelClass
{
    return XMProjectDetailModel.class;
}

@end

//

@implementation XMProjectDownRequest
- (NSString *)requestUrl
{
    return @"api/itemBoot/removeItem";
}

- (id)requestArgument
{
    return @{@"id":@(self.itemId)};
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

@end

//

@implementation XMProjectReportRequest
- (NSString *)requestUrl
{
    return @"api/mallItemInfo/report";
}

- (id)requestArgument
{
    return @{@"itemId":@(self.itemId)};
}

@end


@implementation XMProjectCollectRequest
- (NSString *)requestUrl
{
    return @"api/itemCollection/collection";
}

- (id)requestArgument
{
    return @{@"itemId":@(self.itemId)};
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

@end


@implementation XMProjectCancelCollectRequest
- (NSString *)requestUrl
{
    return @"api/itemCollection/cancelCollection";
}

- (id)requestArgument
{
    return @{@"itemId":@(self.itemId)};
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

@end


@implementation XMProjectShareRequest

- (NSString *)requestUrl
{
    return @"api/mallItemInfo/getShareUrl";
}

- (id)requestArgument
{
    return @{@"itemId":@(self.itemId)};
}

@end


@implementation XMProjectGetMessageRequest

- (NSString *)requestUrl
{
    return @"api/mallItemInfo/getLeaveMessagePage";
}

- (id)requestArgument
{
    NSMutableDictionary *dictM = [super requestArgument];
    [dictM addEntriesFromDictionary:@{@"itemId":@(self.itemId)}];
    return dictM;
}

- (Class)modelInArray
{
    return XMProjectMessageItemModel.class;
}

- (NSString *)keyForArray
{
    return @"records";
}

- (Class)modelClass
{
    return XMProjectGetMessageModel.class;
}

@end


@implementation XMProjectSaveMessageRequest

- (NSString *)requestUrl
{
    return @"api/mallItemInfo/saveLeaveMessage";
}

- (id)requestArgument
{
    return @{@"itemId":@(self.itemId), @"message":self.message};
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

@end
