//
//  RKEmptyView.h
//  Refactoring
//
//  Created by dingqiankun on 2019/5/23.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, EmptySate) {
    EmptySateNormal, // 正常状态下
    EmptySateNetWorkError,  // 网络错误
    EmptySateServerError,  // 服务器错误
    EmptySateEmptyData   // 空数据
};

@interface XMEmptyView : UIView

/**
 以下所有方法实现放到隐藏视图后(即EmptyView视图创建成功后才可调用)
 
 例如：
     // 隐藏加载框视图，并同时创建空视图
     [self.tableView hideLoadingWithRequest:request];
     // 手动改变空视图内容
     [self.tableView.emptyView setDetail:@"暂无受益" forState:EmptySateEmptyData];
 
 */

// 显示默认状态下的空视图
- (void)showWith:(EmptySate)state;

// 设置不同状态下显示的图片
- (void)setImage:(NSString *)name forState:(EmptySate)state;

// 设置不同状态下显示的标题
- (void)setTitile:(NSString *)titile forState:(EmptySate)state;

// 设置不同状态下显示的详情标题
- (void)setDetail:(NSString *)titile forState:(EmptySate)state;

// 设置不同状态下显示的按钮标题
- (void)setBtnTitle:(NSString *)titile forState:(EmptySate)state;

// 正常状态下 不显示提示
- (void)setStateWithNormal;

@end

NS_ASSUME_NONNULL_END
