//
//  XMNLoginView.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/30.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMNLoginView : UIView

@property(nonatomic, strong)UIButton *sureBtn;  // 确定

@property(nonatomic, strong)UITextField *phoneTxt;

@property(nonatomic, strong)UITextField *valieCodeTxt;

@property(nonatomic, strong)UIButton *senderCodeBtn;

@property(nonatomic, strong)UIButton *loginIconBtn;

@property(nonatomic, strong)UIButton *selectBtn;  // 选择阅读协议

@property(nonatomic, strong)UIButton *readRuleBtn;   // 阅读规则

@end

NS_ASSUME_NONNULL_END
