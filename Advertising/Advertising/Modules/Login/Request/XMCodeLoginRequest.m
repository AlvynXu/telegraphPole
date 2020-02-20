//
//  XMCodeLoginRequest.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/26.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMCodeLoginRequest.h"
#import "XMLoginModel.h"

@implementation XMCodeLoginRequest

- (NSString *)requestUrl
{
    return @"api/users/phoneLogin";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (id)requestArgument
{
    return @{@"phone":self.phone, @"password":self.password};
}

//- (Class)modelClass
//{
//    return XMLoginModel.class;
//}


@end
