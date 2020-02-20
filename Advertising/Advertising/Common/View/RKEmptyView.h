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

- (void)showWith:(EmptySate)state;

- (void)setImage:(NSString *)name forState:(EmptySate)state;

- (void)setTitile:(NSString *)titile forState:(EmptySate)state;

- (void)setDetail:(NSString *)titile forState:(EmptySate)state;

- (void)setBtnTitle:(NSString *)titile forState:(EmptySate)state;

// 正常状态下 不显示提示
- (void)setStateWithNormal;

@end

NS_ASSUME_NONNULL_END
