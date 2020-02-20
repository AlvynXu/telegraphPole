//
//  XMLoginRequest.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/25.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMLoginRequest.h"

@implementation XMLoginRequest

- (NSString *)requestUrl
{
    return @"api/users/login";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (id)requestArgument
{
    return @{@"phone":self.phone, @"password":self.password};
}

@end

@implementation XMUserRuleRequest

- (NSString *)requestUrl
{
    return @"api/users/phoneLogin/getRegisterInfos";
}

- (Class)modelClass
{
    return XMUserRuleModel.class;
}

@end

//
