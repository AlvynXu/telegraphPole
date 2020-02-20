//
//  XMBannerModel.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/17.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBannerModel.h"

@implementation XMBannerItemModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id":@"id"};
}

@end

@implementation XMBannerModel


+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"data":@"XMBannerItemModel"};
}

@end
