//
//  XMAPPShareUtil.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/4.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMAPPShareUtil.h"


@implementation XMAPPShareModel

@end


@implementation XMAPPShareRequest

- (NSString *)requestUrl
{
    return @"api/users/getAppShare";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (Class)modelClass
{
    return XMAPPShareModel.class;
}

@end
