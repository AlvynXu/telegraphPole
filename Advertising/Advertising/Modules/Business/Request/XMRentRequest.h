//
//  XMRentRequest.h
//  Advertising
//
//  Created by dingqiankun on 2020/1/2.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMRentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMRentListRequest : XMBasePageRequest

//@property(nonatomic, assign)NSInteger type;  // 类型

@property(nonatomic, assign)NSInteger areaCode;  // 区域码

@end

@interface XMRentMyRentRequest : XMBaseRequest

//@property(nonatomic, assign)NSInteger type;  // 类型

@property(nonatomic, assign)NSInteger areaCode;  // 区域码

@end

@interface XMRentOtherRequest : XMBaseRequest

@property(nonatomic, assign)NSInteger orderId;  // 类型

@property(nonatomic, assign)NSInteger areaCode;  // 区域码

@end

@interface XMRentCanStreetRequest : XMBaseRequest

@property(nonatomic, assign)NSInteger orderId;  // 类型

@end

// 租给其他人
@interface XMRentOtherPersonRequest : XMBaseRequest

@property(nonatomic, assign)NSInteger orderId;  // 类型

@property(nonatomic, strong)NSArray *streetCodes; //

@end


// 支付并发布
@interface XMWantRentPayRequest : XMBaseRequest

@property(nonatomic, strong)NSArray *areaCodes;  // 街道编码

@property(nonatomic, copy)NSString *cityCode;  // 城市编码

@property(nonatomic, assign)NSInteger count;  // 个数

@property(nonatomic, assign)NSInteger days;

@property(nonatomic, assign)CGFloat price;

@end



NS_ASSUME_NONNULL_END
