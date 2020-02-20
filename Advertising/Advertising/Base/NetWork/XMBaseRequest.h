//
//  RKBaseRequest.h
//  Refactoring
//
//  Created by dingqiankun on 2019/3/22.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "YTKRequest.h"

NS_ASSUME_NONNULL_BEGIN

@class XMBaseRequest;

// 请求完成回调
typedef void (^RequestCompleteBlock)(__kindof XMBaseRequest *request,NSError *error);

@interface XMBaseRequest : YTKRequest

@property(nonatomic, strong, readonly)RACSignal *requestSignal;

/***
 *   响应业务信息
 */
@property(nonatomic, assign, readonly)BOOL businessSuccess; // 响应业务是否成功(包含判断 网络、接口格式是否正确)

@property(nonatomic, assign, readonly)NSInteger businessCode;  // 响应业务接口状态：code

@property(nonatomic, copy, readonly)NSString *businessMessage;  // 响应业务接口信息


/***
 *   响应业务数据
 */
@property(nonatomic, strong, readonly)id businessModel;  // 响应业务数据转换为模型 根据接口生成的对象模型  id 指向modelClass指针

@property(nonatomic, strong, readonly)id businessData;   // 响应业务数据 并非NSData类型。

// 请求信号
+(RACSignal *)requestSignal;

+ (instancetype)request;

// 模型类
- (Class)modelClass;

// 发起请求
- (void)startWithCompletion:(RequestCompleteBlock)completeBlock;

@end

NS_ASSUME_NONNULL_END
