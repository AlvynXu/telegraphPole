//
//  XMRechargeView.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/17.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMMoneyModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMWithdrawView : UIView

@property(nonatomic, strong)UILabel *canMoneyLbl;  // 可提现

@property(nonatomic, strong)UITextField *numTxt;  // 金额

@property(nonatomic, strong)UIButton *rechargeBtn;  // 提现

@property(nonatomic, strong)UIButton *allRechargeBtn;  // 全部提出

@property(nonatomic, strong)XMMoneyModel *moneyModel;

@end

NS_ASSUME_NONNULL_END
