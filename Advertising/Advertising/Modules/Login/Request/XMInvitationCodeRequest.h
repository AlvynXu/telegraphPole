//
//  XMInvitationCodeRequest.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/28.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMInvitationCodeRequest : XMBaseRequest

@property(nonatomic, copy)NSString *promoterId;  // 邀请码

@property(nonatomic, copy)NSString *userId; // 用户ID

@end

NS_ASSUME_NONNULL_END
