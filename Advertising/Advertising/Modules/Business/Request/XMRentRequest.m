//
//  XMRentRequest.m
//  Advertising
//
//  Created by dingqiankun on 2020/1/2.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import "XMRentRequest.h"

@implementation XMRentListRequest

- (NSString *)requestUrl
{
    return @"api/market/getRent";
}

- (id)requestArgument
{
    NSMutableDictionary *mdict = [super requestArgument];
    [mdict addEntriesFromDictionary:@{@"areaCode":@(self.areaCode)}];
    return mdict;
}

- (Class)modelClass
{
    return XMRentModel.class;
}

- (Class)modelInArray
{
    return XMRentItemModel.class;
}

- (NSString *)keyForArray
{
    return @"records";
}


@end

//
@implementation XMRentMyRentRequest

- (NSString *)requestUrl
{
    return @"api/market/getMyRent";
}

- (Class)modelClass
{
    return XMMyRentModel.class;
}

- (id)requestArgument
{
    return @{@"areaCode":@(self.areaCode)};
}

@end


@implementation XMRentOtherRequest

- (NSString *)requestUrl
{
    return @"api/market/getMyRent";
}

- (Class)modelClass
{
    return XMMyRentModel.class;
}

@end

@implementation XMRentCanStreetRequest

- (NSString *)requestUrl
{
    return @"api/market/getCanRentStreet";
}

- (id)requestArgument
{
    return @{@"id":@(self.orderId)};
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (Class)modelClass
{
    return XMRentCanStreetModel.class;
}

@end

//

@implementation XMRentOtherPersonRequest

- (NSString *)requestUrl
{
    return @"api/market/rentToOther";
}

- (id)requestArgument
{
    return @{@"orderId":@(self.orderId), @"streetCodes":self.streetCodes};
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (Class)modelClass
{
    return XMRentCanStreetModel.class;
}

@end

//

@implementation XMWantRentPayRequest

- (NSString *)requestUrl
{
    return @"api/wxPay/seekRent";
}

- (id)requestArgument
{
    return @{@"areaCodes":self.areaCodes, @"cityCode":self.cityCode, @"count":@(self.count), @"days":@(self.days), @"price":@(self.price)};
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

//- (Class)modelClass
//{
//    return XMRentCanStreetModel.class;
//}

@end


