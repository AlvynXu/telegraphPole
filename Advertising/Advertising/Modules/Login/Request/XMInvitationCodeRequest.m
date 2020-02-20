//
//  XMInvitationCodeRequest.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/28.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMInvitationCodeRequest.h"

@implementation XMInvitationCodeRequest

- (NSString *)requestUrl
{
    return @"api/users/phoneLogin/setPromoter";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (id)requestArgument
{
    return @{@"promoterId":self.promoterId, @"userId":self.userId};
}

@end
