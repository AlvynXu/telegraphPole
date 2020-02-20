//
//  XMGalleryModel.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/17.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMGalleryModel.h"

@implementation XMGalleryCateItemModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id":@"id"};
}

@end

@implementation XMGalleryCateModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"data":@"XMGalleryCateItemModel"};
}

@end

@implementation XMGallerySelectModel

@end



@implementation XMCategoryListItemModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"desc":@"description", @"Id":@"id"};
}


@end

@implementation XMCategoryListModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"records":@"XMHeadLineItemModel"};
}



@end



