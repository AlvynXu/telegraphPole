//
//  XMBoothMangerRequest.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBoothMangerRequest.h"

@implementation XMBoothMangerRequest

- (NSString *)requestUrl
{
    return @"api/itemBoot/getCanUseBooth";
}

- (Class)modelInArray
{
    return XMBoothMangerItemModel.class;
}

- (Class)modelClass
{
    return XMBoothMangerModel.class;
}

- (NSString *)keyForArray
{
    return @"records";
}

@end

//

@implementation XMBoothMangerSureRequest

- (NSString *)requestUrl
{
    return @"api/itemBoot/saveItemBooth";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (id)requestArgument
{
    return @{@"boothIds":self.boothIds, @"itemId":@(self.itemId)};
}


@end
