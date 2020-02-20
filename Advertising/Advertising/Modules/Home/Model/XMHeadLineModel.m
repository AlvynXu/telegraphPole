//
//  XMHeadLineModel.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/17.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMHeadLineModel.h"

@implementation XMHeadLineItemModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"desc":@"description", @"Id":@"id"};
}

@end

@implementation XMHeadLineModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"records":@"XMHeadLineItemModel"};
}

@end


//
