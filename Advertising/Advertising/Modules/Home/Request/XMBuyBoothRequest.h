//
//  XMBuyBoothRequest.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/29.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseRequest.h"
#import "XMBoothModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMBoothDataRequest : XMBasePageRequest

@property(nonatomic, assign)NSInteger type; // 0未出售 1已出售

@property(nonatomic, copy)NSString *areaCode;  // 区域code

@property(nonatomic, assign)NSInteger areaType;  //区域  1 街道 2 区  3市  4 省

@end

//生成街道订单
@interface XMGenerateBoothOrderRequest : XMBaseRequest

@property(nonatomic, assign)NSInteger boothId;  // 生成街道订单

@end


// 免费解锁
@interface XMBoothFreeRequest : XMBaseRequest

@property(nonatomic, assign)NSInteger boothId;  // 生成街道订单

@end



NS_ASSUME_NONNULL_END
