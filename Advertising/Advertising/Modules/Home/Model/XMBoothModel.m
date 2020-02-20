//
//  XMBoothModel.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/29.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBoothModel.h"


@implementation XMBoothRecordsModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id":@"id"};
}

@end

@implementation XMBoothDataModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"records":@"XMBoothRecordsModel"};
}

- (NSString *)notSoldCount
{
    return [_notSoldCount isEmpty]?@"0":_notSoldCount;
}

- (NSString *)soldCount
{
    return [_soldCount isEmpty]?@"0":_soldCount;
}


@end


