//
//  XMCollectModel.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/31.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMCollectModel.h"

@implementation XMCollectItemModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"desc":@"description", @"Id":@"id"};
}


@end

@implementation XMCollectModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"records":@"XMCollectItemModel"};
}

@end

