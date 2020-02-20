//
//  XMBuyBoothRequest.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/29.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBuyBoothRequest.h"
#import "XMBuyOrder.h"

@implementation XMBoothDataRequest

- (NSString *)requestUrl
{
    return @"api/booth/getBoothPage";
}

- (id)requestArgument
{
    [super requestArgument];
    NSMutableDictionary *argumentDict = [super requestArgument];
    [argumentDict addEntriesFromDictionary:@{@"type": @(0), @"areaCode": self.areaCode, @"areaType":@(self.areaType), @"size":@15}];
    return argumentDict;
}

- (Class)modelInArray
{
    return XMBoothRecordsModel.class;
}

- (Class)modelClass
{
    return XMBoothDataModel.class;
}

- (NSString *)keyForArray
{
    return @"records";
}

@end

//

@implementation XMGenerateBoothOrderRequest

- (NSString *)requestUrl
{
    return @"api/aliPay/buyBooth";
}

- (id)requestArgument
{
    return @{@"boothId": @(self.boothId)};
}

- (Class)modelClass
{
    return XMBuyBoothOrder.class;
}

@end

//

@implementation XMBoothFreeRequest

- (NSString *)requestUrl
{
    return @"api/booth/choose";
}

- (id)requestArgument
{
    return @{@"boothId": @(self.boothId)};
}

@end
