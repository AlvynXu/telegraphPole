//
//  UIView+Loading.h
//  Refactoring
//
//  Created by dingqiankun on 2019/3/29.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMEmptyView.h"
#import "XMBaseRequest.h"
#import "XMBasePageRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Loading)

@property(nonatomic, strong, readonly)XMEmptyView *emptyView; // 各种状态的空视图



/**
   显示加载框 ----》 适用提交表单
 */
- (void)showLoading;

/**
   页面显示加载框 ----》 适用页面加载
 */
- (void)showPageLoading;

// 显示带有字体的加载框
- (void)showLoadigWith:(NSString *)message;

/*
    隐藏加载框  ----》 适用无分页请求
 */
- (void)hideLoading;

/*
    隐藏Loading加载框 并根据request判断显示各种状态 ----》 适用分页请求
 */
- (void)hideLoadingWithRequest:(XMBaseRequest *)request;

// 可以手动调整空视图在父视图的位置
- (void)hideLoadingWithRequest:(XMBaseRequest *)request rect:(CGRect)rect;

// 隐藏加载框并且 结束刷新
- (void)hideLoadingAndEndRefreshNoTipsEmpty:(XMBaseRequest *)request;

@end

NS_ASSUME_NONNULL_END
