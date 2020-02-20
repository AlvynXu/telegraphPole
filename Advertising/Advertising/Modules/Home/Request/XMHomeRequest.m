//
//  XMHomeRequest.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/28.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMHomeRequest.h"
#import "XMHomeMsgModel.h"

@implementation XMHomeRequest

- (NSString *)requestUrl
{
    return @"api/booth/getBootCountMessage";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (Class)modelClass
{
    return XMHomeBootModel.class;
}


@end


@implementation XMHomeLandlordRequest

- (NSString *)requestUrl
{
    return @"api/street/getCountMessage";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (Class)modelClass
{
    return XMHomeBootModel.class;
}


@end


@implementation XMHomeMsgRequest

- (NSString *)requestUrl
{
    return @"api/users/getMessage";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (Class)modelClass
{
    return XMHomeMsgModel.class;
}

@end



@implementation XMHomeGetBannerRequest

- (NSString *)requestUrl
{
    return @"api/mallBanner/getBanner";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (id)requestArgument
{
    if ([NSString isEmpty:self.categoryId]) {
        return @{@"areaCode":self.areaCode};
    }else{
        
        return @{@"areaCode":self.areaCode, @"categoryId":self.categoryId};
    }
    
}

- (Class)modelClass
{
    return XMBannerModel.class;
}

@end


@implementation XMHomeHeadLineRequest

- (NSString *)requestUrl
{
    return @"api/headlines/pageList";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (id)requestArgument
{
    
    NSMutableDictionary *dictM = [super requestArgument];
    [dictM addEntriesFromDictionary:@{@"areaType":@(4)}];
    return dictM;
}

- (Class)modelInArray
{
    return XMHeadLineItemModel.class;
}

- (NSString *)keyForArray
{
    return @"records";
}

- (Class)modelClass
{
    return XMHeadLineModel.class;
}

@end

