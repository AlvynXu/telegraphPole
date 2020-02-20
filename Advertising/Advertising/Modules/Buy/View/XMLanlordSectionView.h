//
//  XMLanlordSectionView.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/27.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMSelectCircleView.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMLanlordSectionView : UIView

@property(nonatomic, assign)CGSize intrinsicContentSize; // 解决titleView无法点击的问题

@property(nonatomic, strong)XMSelectCircleView *citySelectV; // 城市选择

@property(nonatomic, strong)XMSelectCircleView *stateSelectV; // 状态选择

@end

NS_ASSUME_NONNULL_END
