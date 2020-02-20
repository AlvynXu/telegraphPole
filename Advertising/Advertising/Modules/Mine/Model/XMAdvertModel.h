//
//  XMAdvertModel.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMAdvertItemModel : NSObject

@property(nonatomic, copy)NSString *desc;   // 描述

@property(nonatomic, assign)NSInteger status;   // 状态   -1未审核  0审核中 3发布中 2未发布

@property(nonatomic, copy)NSString *Id;  // ID

@property(nonatomic, copy)NSString *statusStr;

@property(nonatomic, strong)UIColor *statusColor;

@end

@interface XMAdvertModel : NSObject

@property(nonatomic, strong)NSArray<XMAdvertItemModel *> *records;   // 数组

@end

NS_ASSUME_NONNULL_END
