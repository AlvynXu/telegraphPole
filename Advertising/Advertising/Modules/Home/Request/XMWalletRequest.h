//
//  XMWalletRequest.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/17.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseRequest.h"
#import "XMMoneyModel.h"

NS_ASSUME_NONNULL_BEGIN


// 提现
@interface XMWithdrawRequest : XMBaseRequest

@property(nonatomic, strong)NSDecimalNumber *amount;

@end

// 提现限制
@interface XMWithdrawLimitRequest : XMBaseRequest


@end


// 充值
@interface XMRechargeRequest : XMBaseRequest

@property(nonatomic, strong)NSDecimalNumber *amount;

@end



NS_ASSUME_NONNULL_END
