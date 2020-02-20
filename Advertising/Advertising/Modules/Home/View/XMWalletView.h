//
//  XMWalletView.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/17.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMWalletView : UIView

@property(nonatomic, strong)UIButton *rechargeBtn;  // 充值

@property(nonatomic, strong)UIButton *withdrawBtn;  // 提现

@property(nonatomic, strong)UILabel *balanceLbl;  // 余额

@end

NS_ASSUME_NONNULL_END
