//
//  XMSetPwdRequest.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/26.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMSetPwdRequest.h"
#import "AFNetworking.h"

@implementation XMSetPwdRequest

- (NSString *)requestUrl
{
    return @"api/users/setPassword";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFormData:[kFormat(@"%@", self.phone) dataUsingEncoding:NSUTF8StringEncoding] name:@"phone"];
        [formData appendPartWithFormData:[kFormat(@"%@", self.password) dataUsingEncoding:NSUTF8StringEncoding] name:@"password"];
        [formData appendPartWithFormData:[kFormat(@"%@", self.userId) dataUsingEncoding:NSUTF8StringEncoding] name:@"userId"];
    };
}




@end
