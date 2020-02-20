//
//  RKBasePageRequest.h
//  Refactoring
//
//  Created by dingqiankun on 2019/4/1.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMBasePageRequest : XMBaseRequest


@property(nonatomic, assign, readonly)NSInteger page;  // 页数

@property(nonatomic, assign, readonly)NSInteger size;  // 页数展示大小

@property(nonatomic, assign, readonly)BOOL hasNextPage;  // 判断是否还有更多数据

@property(nonatomic, strong, readonly)NSMutableArray *businessModelArray;  // 业务模型数组

@property(nonatomic, assign)BOOL needRefresh; // 刷新


// 删除数组中的某个元素
- (void)removeObjectAtIndex:(NSInteger)index;

// 返回数据中指向数组的key名字
- (NSString *)keyForArray;

// 数组内模型的Model
- (Class)modelInArray;



@end

NS_ASSUME_NONNULL_END

