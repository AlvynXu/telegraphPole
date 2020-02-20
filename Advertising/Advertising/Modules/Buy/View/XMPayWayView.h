//
//  XMPayWayView.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/27.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, PayType) {
    PayTypeAgent  = 0,   // 代理
    PayTypeLanlord,   //地主
    PayTypeBoot   // 展位
};


@interface XMPayWayView : UIView

@property(nonatomic, assign)PayType payType;  // 判断是否是展位还是地主

@property(nonatomic, assign)NSInteger Id;  // ID

@property(nonatomic, strong)UILabel *fullNameAddressLbl;  // 地址全称

@property(nonatomic, strong)UILabel *buyAddressLbl;  //购买地址

@property(nonatomic, strong)UILabel *numLbl;  // 支付金额

@property(nonatomic, strong)RACSubject *selectBlockSub; // 回调



- (void)show;

- (void)hinde;

@end

NS_ASSUME_NONNULL_END
