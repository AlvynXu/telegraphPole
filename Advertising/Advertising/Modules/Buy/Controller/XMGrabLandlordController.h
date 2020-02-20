//
//  XMGrabLandlordController.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/27.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseTableController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMGrabLandlordController : XMBaseTableController

@property(nonatomic, copy)NSString *localCity;

@property(nonatomic, assign)BOOL isLandlord;

@property(nonatomic, assign)BOOL isfirst;  // 在viewWilapper中判断是否需要更新

@end

NS_ASSUME_NONNULL_END
