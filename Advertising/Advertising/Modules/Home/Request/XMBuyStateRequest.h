//
//  XMBuyStateRequest.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/4.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMBuyStateModel : NSObject

@property(nonatomic, copy)NSString *city;  // 市

@property(nonatomic, copy)NSString *code; // 编码

@property(nonatomic, copy)NSString *district;  // 区/县

@property(nonatomic, copy)NSString *province;  // 省

@property(nonatomic, copy)NSString *street;  // 街道

@property(nonatomic, assign)NSInteger type;

@property(nonatomic, copy)NSString *time;  //时间

@end

@interface XMBuyStateRequest : XMBaseRequest

@property(nonatomic, assign)NSInteger type;  // 1 展位  2 地主

@property(nonatomic, assign)NSInteger Id;

@end

NS_ASSUME_NONNULL_END
