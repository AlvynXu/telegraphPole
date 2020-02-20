//
//  XMLandlordModel.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/29.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMLandlordModel.h"

@implementation XMLandlordRecordsModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id":@"id"};
}

@end


@implementation XMLandlordDataModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"records":@"XMLandlordRecordsModel"};
}

- (NSString *)notSoldCount
{
    if ([_notSoldCount isEmpty]) {
        NSLog(@"=========------");
    }
    return [_notSoldCount isEmpty]?@"0":_notSoldCount;
}

- (NSString *)soldCount
{
    return [_soldCount isEmpty]?@"0":_soldCount;
}

@end

//
@implementation XMCityCodeModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id":@"id"};
}

@end
