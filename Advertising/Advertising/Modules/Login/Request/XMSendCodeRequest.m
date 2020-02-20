//
//  XMSendCodeRequest.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/26.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMSendCodeRequest.h"
#import "AFNetworking.h"

@implementation XMSendCodeRequest

- (NSString *)requestUrl
{
    return @"api/users/phoneLogin/getLoginRandomCode";
}

//- (YTKRequestMethod)requestMethod
//{
//    return YTKRequestMethodPOST;
//}

- (id)requestArgument
{
    return @{@"phone":self.phone};
}

//- (AFConstructingBlock)constructingBodyBlock {
//    return ^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFormData:[kFormat(@"%@", self.phone) dataUsingEncoding:NSUTF8StringEncoding] name:@"phone"];
//    };
//}




@end
