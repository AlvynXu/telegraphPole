//
//  XMTeamModel.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/3.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMTeamModel.h"

@implementation XMTeamModel

@end


@implementation XMTeamPageItemModel


@end

@implementation XMTeamPageModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"records":@"XMTeamPageItemModel"};
}

@end


@implementation XMProfitPageItemModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id":@"id"};
}

@end

@implementation XMProfitPageModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"records":@"XMProfitPageItemModel"};
}

@end


