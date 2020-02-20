//
//  XMProjectDetailController.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/18.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseTableController.h"

typedef NS_ENUM(NSUInteger, XMBlockType) {
    XMBlockTypeDown = 0,
    XMBlockTypeCollect
};

NS_ASSUME_NONNULL_BEGIN

@interface XMProjectDetailController : XMBaseTableController

@property(nonatomic, assign)BOOL isEdit;

@property(nonatomic, assign)NSInteger itemId;  // 项目ID

@property(nonatomic, assign)NSInteger status;  // // 状态   -1未审核  0审核中 1发布中 2未发布

@property(nonatomic, strong)RACSubject *subject;  // 下架成功后回调  取消收藏后回调

@end

NS_ASSUME_NONNULL_END
