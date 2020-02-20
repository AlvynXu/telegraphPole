//
//  XMCollectModel.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/31.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//XMCollectModel

@interface XMCollectItemModel : NSObject

@property(nonatomic, copy)NSString *desc;   // 描述

@property(nonatomic, assign)NSInteger status;   // 状态   -1未审核  0审核中 1发布中 2未发布

@property(nonatomic, copy)NSString *Id;  // ID

@property(nonatomic, copy)NSString *addressDetail;

@property(nonatomic, strong)UIColor *statusColor;

@property(nonatomic, assign)BOOL collect;



@end

@interface XMCollectModel : NSObject

@property(nonatomic, strong)NSArray<XMCollectItemModel *> *records;   // 数组

@end

NS_ASSUME_NONNULL_END
