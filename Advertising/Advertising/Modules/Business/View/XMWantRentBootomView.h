//
//  XMWantRentBootomView.h
//  Advertising
//
//  Created by dingqiankun on 2020/1/6.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMWantRentBootomView : UIView

@property(nonatomic, strong)UITextField *unitPriceTxt;  //单价

@property(nonatomic, strong)UITextField *totalDayTxt;  //总天数

@property(nonatomic, strong)UILabel *selectNumLbl;  // 选择数量

@property(nonatomic, strong)UILabel *priceLbl;  // 价格

@property(nonatomic, strong)UIButton *payAndPublishBtn;  //支付并发布

@end

NS_ASSUME_NONNULL_END
