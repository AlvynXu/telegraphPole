//
//  XMSuggestRequest.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/3.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMSuggestRequest.h"

@implementation XMSuggestRequest

- (id)requestArgument
{
    return @{@"content":self.content};
}

- (NSString *)requestUrl
{
    return @"api/feedback/saveFeedBack";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

@end
