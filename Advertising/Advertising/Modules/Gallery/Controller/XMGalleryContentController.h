//
//  XMGalleryContentController.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/18.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseTableController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMGalleryContentController : XMBaseTableController

@property(nonatomic, assign)NSInteger categoryId;   // 分类ID

@property(nonatomic, copy)NSString *areaCode;  // 地区编码

@property(nonatomic, assign)NSInteger areaType;  // 地区类型

@end

NS_ASSUME_NONNULL_END
