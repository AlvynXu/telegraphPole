//
//  XMSelectCanStreetView.h
//  Advertising
//
//  Created by dingqiankun on 2020/1/2.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMRentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMSelectCanStreetView : UIView

@property(nonatomic, assign)NSInteger day; // 天

@property(nonatomic, assign)NSInteger orderId;

@property(nonatomic, assign)NSInteger count;  // 个数

@property(nonatomic, strong)NSArray *dataSource;  // 数据源

@property(nonatomic, strong)RACSubject *sureBuySubject;

- (void)show;

- (void)hinde;

@end

NS_ASSUME_NONNULL_END
