//
//  XMBoothMangerModel.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBoothMangerModel.h"


@implementation XMBoothMangerItemModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id":@"id"};
}

@end

@implementation XMBoothMangerModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"records":@"XMBoothMangerItemModel"};
}

@end
