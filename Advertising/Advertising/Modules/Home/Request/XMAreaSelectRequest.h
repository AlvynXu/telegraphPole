//
//  XMAreaSelectRequest.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/29.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseRequest.h"
#import "XMAreaSelectModel.h"

NS_ASSUME_NONNULL_BEGIN

// 省
@interface XMParentRequest : XMBaseRequest


@end


// 城市
@interface XMCityRequest : XMBaseRequest

@property(nonatomic, copy)NSString *code;

@end

// 县
@interface XMCountyRequest : XMBaseRequest

@property(nonatomic, copy)NSString *code;

@end

//街道
@interface XMStreetRequest : XMBaseRequest

@property(nonatomic, copy)NSString *code;

@end


NS_ASSUME_NONNULL_END
