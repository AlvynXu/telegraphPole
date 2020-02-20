//
//  XMAgentView.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/29.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMAgentView : UIView

@property(nonatomic, strong)UILabel *headNumLbl;  // 名额

@property(nonatomic, strong)UILabel *balanceNumLbl;  //余额

@property(nonatomic, strong)UILabel *oldMoneyLbl;  // 原价

@property(nonatomic, strong)UILabel *currentMoneyLbl;  // 现价

@property(nonatomic, strong)UIButton *agentBtn;  //代理

@end

NS_ASSUME_NONNULL_END
