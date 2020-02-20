//
//  XMCodeLoginRequest.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/26.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMCodeLoginRequest : XMBaseRequest

@property(nonatomic, copy)NSString *phone;

@property(nonatomic, copy)NSString *password;

@end

NS_ASSUME_NONNULL_END
