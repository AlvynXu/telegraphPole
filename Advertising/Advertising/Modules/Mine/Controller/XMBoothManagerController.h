//
//  XMBoothManagerController.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseTableController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMBoothManagerController : XMBaseTableController

@property(nonatomic, assign)NSInteger itemId;

@property(nonatomic, strong)RACSubject *subject;

@end

NS_ASSUME_NONNULL_END
