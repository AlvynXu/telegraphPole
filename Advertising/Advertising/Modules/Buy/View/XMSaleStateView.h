//
//  XMSaleStateView.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/28.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMSaleStateView : UIView

@property(nonatomic, strong)RACSubject *selectBlockSub; // 回调

- (void)show;

- (void)hinde;

@end

NS_ASSUME_NONNULL_END
