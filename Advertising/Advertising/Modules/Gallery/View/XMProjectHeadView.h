//
//  XMProjectHeadView.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/18.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMProjectDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMProjectHeadView : UIView

@property(nonatomic, assign)CGFloat totalHeight;

@property(nonatomic, copy)XMProjectDetailModel *detailModel;

@property(nonatomic, strong)UIButton *reportBtn;  // 举报


@end

NS_ASSUME_NONNULL_END
