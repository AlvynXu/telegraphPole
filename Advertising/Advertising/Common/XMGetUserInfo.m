//
//  XMGetUserInfo.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/4.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMGetUserInfo.h"

//

@implementation XMUserBaseNumInfo

@end


@implementation XMCurrentUserInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id":@"id"};
}

- (NSString *)levelImgName
{
    return [kLoginManager getCurrentLevelAvarImg:self.level];
}

@end


@implementation XMGetUserInfoRequest

- (NSString *)requestUrl
{
    return @"api/users/getCurrentUserInfo";
}

- (Class)modelClass
{
    return XMCurrentUserInfo.class;
}

@end

//

@implementation XMGetUserBaseNumRequest

- (NSString *)requestUrl
{
    return @"api/users/getMyBaseInfo";
}

- (Class)modelClass
{
    return XMUserBaseNumInfo.class;
}

@end
