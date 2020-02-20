//
//  XMBuyLandlordRequest.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/29.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBuyLandlordRequest.h"

@implementation XMLandlordListRequest

- (NSString *)requestUrl
{
    return @"api/street/getStreetPage";
}

- (id)requestArgument
{
     [super requestArgument];
    NSMutableDictionary *argumentDict = [super requestArgument];
   [argumentDict addEntriesFromDictionary:@{@"type": @(0), @"areaCode": self.areaCode, @"areaType":@(_areaType)}];
    return argumentDict;
}

- (Class)modelClass
{
    return XMLandlordDataModel.class;
}

- (Class)modelInArray
{
    return XMLandlordRecordsModel.class;
}

- (NSString *)keyForArray
{
    return @"records";
}


@end

// 获取市区编码
@implementation XMGetCityCodeRequest

- (NSString *)requestUrl
{
    return @"api/street/getCityCode";
}

- (id)requestArgument
{
    return @{@"cityName": self.cityName.length>0?self.cityName:@""};
}

- (Class)modelClass
{
    return XMCityCodeModel.class;
}

@end

@implementation XMGenerateOrderRequest

- (NSString *)requestUrl
{
    return @"api/aliPay/bugStreet";
}

- (id)requestArgument
{
    return @{@"streetId": @(self.streetId)};
}

- (Class)modelClass
{
    return XMBuyOrder.class;
}

@end

//

@implementation XMWeixinOrderStreetRequest

- (NSString *)requestUrl
{
    return @"api/wxPay/bugStreet";
}

- (id)requestArgument
{
    return @{@"streetId": @(self.streetId)};
}


@end

@implementation XMWeixinOrderBoothRequest

- (NSString *)requestUrl
{
    return @"api/wxPay/buyBooth";
}

- (id)requestArgument
{
    return @{@"boothId": @(self.boothId)};
}


@end


@implementation XMWeixinCancelOrderRequest

- (NSString *)requestUrl
{
    return @"api/payLog/cancelPay";
}

- (id)requestArgument
{
    return @{@"id": @(self.orderId), @"type":@(self.type)};
}


@end
