//
//  XMHomeView.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/26.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHomeHeadLbl.h"
#import "XMHomeMsgModel.h"
#import "XMPlaceholderWealthView.h"
#import "SDCycleScrollView.h"
#import "XMBuyCardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHomeView : UIView

@property(nonatomic, copy)NSString *benefitStr;  //

@property(nonatomic, copy)NSString *teamStr;

@property(nonatomic, copy)NSString *msgStr;

@property(nonatomic, strong)XMBuyCardView *buyLanlordImgV;  // 抢地主

@property(nonatomic, strong)XMBuyCardView *buyBoothImagv;  // 抢展位

@property(nonatomic, strong)XMPlaceholderWealthView *placeholderWealthV;  // 代理

@property(nonatomic, strong)SDCycleScrollView *cycleScrollView;  // 轮播图

@property(nonatomic, assign)int noRead;

@property(nonatomic, assign)BOOL booth; // 展位

@property(nonatomic, strong)XMHomeHeadLbl *benefitLbl;  // 受益

@property(nonatomic, strong)XMHomeHeadLbl *teamLbl;  // 团队

@property(nonatomic, strong)XMHomeHeadLbl *msgLbl;  // 消息

@property(nonatomic, strong)XMHomeBootModel *commonModel; // 展位地主信息模型共用

@end

NS_ASSUME_NONNULL_END
