//
//  XMHomeMsgModel.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/28.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHomeMsgModel : NSObject

@property (nonatomic, copy) NSString *message;  //未读消息

@property (nonatomic, assign) CGFloat profit; //受益

@property(nonatomic, assign)CGFloat balance;  // 余额

@property (nonatomic, copy) NSString *team;//团队

@property(nonatomic, copy)NSString *totalMessage;  // 总消息

@property(nonatomic, assign)CGFloat vipPrice;  // vip价格

@end


// 展位和地主共用同一个模型
@interface XMHomeBootModel : NSObject

@property (nonatomic, copy) NSString *soldCount;  // 已售

@property (nonatomic, copy) NSString *totalCount;  // 总数

@property (nonatomic, copy) NSString *noSoldCount;  //未售

@end


NS_ASSUME_NONNULL_END
