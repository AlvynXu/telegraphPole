//
//  XMBuyLandlordRequest.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/29.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseRequest.h"
#import "XMLandlordModel.h"
#import "XMBuyOrder.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMLandlordListRequest : XMBasePageRequest

@property(nonatomic, assign)NSInteger type;   // 0是未售  1是以售

@property(nonatomic, copy)NSString *areaCode;  // 110000

@property(nonatomic, assign)NSInteger areaType; // 1 街道 2区  3市  4省

@end

// 获取市区编码  api/street/getCityCode

@interface XMGetCityCodeRequest : XMBaseRequest

@property(nonatomic, copy)NSString *cityName;  //市区名称

@end


/*************   支付宝支付  **********************/

//生成街道订单 支付宝
@interface XMGenerateOrderRequest : XMBaseRequest

@property(nonatomic, assign)NSInteger streetId;  // 生成街道订单

@end

/*************   微信支付  **********************/
//生成街道订单
@interface XMWeixinOrderStreetRequest : XMBaseRequest

@property(nonatomic, assign)NSInteger streetId;  // 生成街道订单

@end


// 生成展位订单
@interface XMWeixinOrderBoothRequest : XMBaseRequest

@property(nonatomic, assign)NSInteger boothId;  // 生成展位订单

@end

@interface XMWeixinCancelOrderRequest : XMBaseRequest

@property(nonatomic, assign)NSInteger orderId;  // 订单ID

@property(nonatomic, assign)NSInteger type; // 0vip  1展位  2街道

@end






NS_ASSUME_NONNULL_END
