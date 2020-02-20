//
//  XMSuccessController.h
//  Advertising
//
//  Created by dingqiankun on 2020/1/4.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import "XMBaseController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, XMSuccessType) {
    XMSuccessTypePayLanlord  = 0,  // 地主支付成功
    XMSuccessTypePayBooth,  // 展位支付成功
    XMSuccessTypePayAgent,  // 代理支付成功
    XMSuccessTypePublish,   // 发布成功
    XMSuccessTypeRent  // 出租发布
};

@interface XMSuccessController : XMBaseController

@property(nonatomic, assign)XMSuccessType type;

@end

NS_ASSUME_NONNULL_END
