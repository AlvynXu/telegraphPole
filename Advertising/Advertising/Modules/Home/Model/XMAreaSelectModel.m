//
//  XMAreaSelectModel.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/29.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMAreaSelectModel.h"


@implementation XMAreaItemModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id":@"id"};
}

@end


//

@implementation XMAreaCommonModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"data":@"XMAreaItemModel"};
}

@end



@implementation XMStreetItemModel


+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id":@"id"};
}

@end


@implementation XMStreetModel



+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"data":@"XMStreetItemModel"};
}

@end



