//
//  XMLoginRequest.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/25.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseRequest.h"
#import "XMLoginModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMLoginRequest : XMBaseRequest

@property(nonatomic, copy)NSString *phone;

@property(nonatomic, copy)NSString *password;

@end

@interface XMUserRuleRequest : XMBaseRequest


@end



NS_ASSUME_NONNULL_END
