//
//  XMAllCityRequest.m
//  Advertising
//
//  Created by dingqiankun on 2020/1/3.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import "XMAllCityRequest.h"

@implementation XMAllCityItemModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id":@"id"};
}

@end

@implementation XMAllCityModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"data":@"XMAllCityItemModel"};
}

@end

@implementation XMAllCityRequest

- (NSString *)requestUrl
{
    return @"api/admin/areas/getCities";
}

- (Class)modelClass
{
    return XMAllCityModel.class;
}


@end
