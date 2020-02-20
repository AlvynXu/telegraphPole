//
//  XMHomeRequest.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/28.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMBannerModel.h"
#import "XMHeadLineModel.h"

NS_ASSUME_NONNULL_BEGIN

// 展位
@interface XMHomeRequest : XMBaseRequest

@end

// 信息
@interface XMHomeMsgRequest : XMBaseRequest

@end

// 地主
@interface XMHomeLandlordRequest : XMBaseRequest

@end


// 获取轮播图
@interface XMHomeGetBannerRequest : XMBaseRequest

@property(nonatomic, copy)NSString *areaCode;  // 地区编码

@property(nonatomic, copy)NSString *categoryId;  // 分类ID

//

@end

// 获取头条
@interface XMHomeHeadLineRequest : XMBasePageRequest

//@property(nonatomic, assign)NSInteger areaType;

@end

//  



NS_ASSUME_NONNULL_END
