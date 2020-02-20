//
//  XMProjectBootomView.h
//  Advertising
//
//  Created by dingqiankun on 2020/1/14.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMProjectBootomView : UIView

@property(nonatomic, assign)NSInteger status;

@property(nonatomic, strong)UIButton *deleteBtn;  // 删除

@property(nonatomic, strong)UIButton *addBtn;  // 追加

@property(nonatomic, strong)UIButton *editBtn;  // 编辑

@property(nonatomic, strong)UIButton *statusBtn;  // 状态

@end

NS_ASSUME_NONNULL_END
