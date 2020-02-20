//
//  XMRentModel.m
//  Advertising
//
//  Created by dingqiankun on 2020/1/2.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import "XMRentModel.h"

//

@implementation XMMyRentItemModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id":@"id"};
}

@end


@implementation XMMyRentModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"data":@"XMMyRentItemModel"};
}

@end


@implementation XMRentItemModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id":@"id"};
}

@end



@implementation XMRentModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"records":@"XMRentItemModel"};
}

@end


//

@implementation XMRentCanStreetItemModel



@end


@implementation XMRentCanStreetModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"userStreetDTOList":@"XMRentCanStreetItemModel"};
}

@end
