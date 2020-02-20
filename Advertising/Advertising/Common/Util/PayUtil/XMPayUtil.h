//
//  XMPayUtil.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/3.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WeiXinPayBlock)(BOOL success);

@interface XMPayUtil : NSObject

+ (NSString *)weiXinPay:(NSDictionary *)dict comple:(WeiXinPayBlock)payblcok;

@end

NS_ASSUME_NONNULL_END
