//
//  XMGalleryRequest.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/17.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMGalleryRequest.h"

@implementation XMGalleryCategoryRequest


- (NSString *)requestUrl
{
    return @"api/mallItemCategory/getList";
}

- (Class)modelClass
{
    return XMGalleryCateModel.class;
}

@end

//

@implementation XMGalleryListRequest


- (NSString *)requestUrl
{
    return @"api/mallItemInfo/pageList";
}

- (id)requestArgument
{
    NSMutableDictionary *dictM = [super requestArgument];
    [dictM addEntriesFromDictionary:@{@"areaCode":self.areaCode, @"areaType":@(self.areaType),@"categoryId":@(self.categoryId)}];
    return dictM;
}


- (Class)modelInArray
{
    return XMCategoryListItemModel.class;
}

- (NSString *)keyForArray
{
    return @"records";
}


- (Class)modelClass
{
    return XMCategoryListModel.class;
}

@end
