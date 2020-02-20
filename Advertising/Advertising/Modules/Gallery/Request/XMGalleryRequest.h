//
//  XMGalleryRequest.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/17.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseRequest.h"
#import "XMGalleryModel.h"

NS_ASSUME_NONNULL_BEGIN

// 商品分类
@interface XMGalleryCategoryRequest : XMBaseRequest

@end


// 商品列表
@interface XMGalleryListRequest : XMBasePageRequest

@property(nonatomic, copy)NSString *areaCode;  // 地区编码

@property(nonatomic, assign)NSInteger areaType;  // 地区类型

@property(nonatomic, assign)NSInteger categoryId;  // 分类ID

@end

NS_ASSUME_NONNULL_END
