//
//  XMAllCityRequest.h
//  Advertising
//
//  Created by dingqiankun on 2020/1/3.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import "XMBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMAllCityItemModel : NSObject

@property(nonatomic, copy)NSString *code;

@property(nonatomic, assign)NSInteger Id;

@property(nonatomic, assign)NSInteger level;

@property(nonatomic, copy)NSString *name;

@property(nonatomic, copy)NSString *parentCode;

@property(nonatomic, assign)CGFloat price;

@end

@interface XMAllCityModel : NSObject

@property(nonatomic,strong)NSArray <XMAllCityItemModel *>*data;

@end

@interface XMAllCityRequest : XMBaseRequest


@end

NS_ASSUME_NONNULL_END
