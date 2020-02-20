//
//  XMAreaSelectRequest.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/29.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMAreaSelectRequest.h"


@implementation XMParentRequest

- (NSString *)requestUrl
{
    return @"api/areas/provinces";
}

- (Class)modelClass
{
    return XMAreaCommonModel.class;
}

@end

@implementation XMCityRequest

- (NSString *)requestUrl
{
    return @"api/areas/cities";
}

- (id)requestArgument
{
    return @{@"code":self.code};
}
- (Class)modelClass
{
    return XMAreaCommonModel.class;
}

@end

@implementation XMCountyRequest

- (NSString *)requestUrl
{
    return @"api/areas/districts";
}

- (id)requestArgument
{
    return @{@"code":self.code};
}

- (Class)modelClass
{
    return XMAreaCommonModel.class;
}

@end

@implementation XMStreetRequest

- (NSString *)requestUrl
{
    return @"api/areas/streets";
}

- (id)requestArgument
{
    return @{@"code":self.code};
}

- (Class)modelClass
{
    return XMStreetModel.class;
}

@end

