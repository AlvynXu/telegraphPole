//
//  XMAdvertRequest.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMAdvertRequest.h"

@implementation XMAdvertRequest

- (NSString *)requestUrl
{
    return @"api/mallItemInfo/getMyItemPageList";
}

- (Class)modelInArray
{
    return XMAdvertItemModel.class;
}

- (NSString *)keyForArray
{
    return @"records";
}

- (Class)modelClass
{
    return XMAdvertModel.class;
}

@end


//

@implementation XMCollectRequest

- (NSString *)requestUrl
{
    return @"api/mallItemInfo/getCollectionPageList";
}

- (Class)modelInArray
{
    return XMCollectItemModel.class;
}

- (NSString *)keyForArray
{
    return @"records";
}

- (Class)modelClass
{
    return XMCollectModel.class;
}

@end

//

@implementation XMDeleteRequest

- (NSString *)requestUrl
{
    return @"api/mallItemInfo/remove";
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
