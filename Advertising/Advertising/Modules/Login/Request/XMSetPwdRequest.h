//
//  XMSetPwdRequest.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/26.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMSetPwdRequest : XMBaseRequest
// phone

@property(nonatomic, copy)NSString *phone;

@property(nonatomic, copy)NSString *password;

@property(nonatomic, copy)AFConstructingBlock formData;

@property(nonatomic, copy)NSString *userId;
//

@end

NS_ASSUME_NONNULL_END
