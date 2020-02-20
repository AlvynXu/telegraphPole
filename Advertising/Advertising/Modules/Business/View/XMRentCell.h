//
//  XMRentView.h
//  Advertising
//
//  Created by dingqiankun on 2020/1/2.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMRentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMRentCell : UITableViewCell

@property(nonatomic, strong)UIButton *sallBtn;  // 出售

@property(nonatomic, strong)XMMyRentItemModel *myRentModel;

@property(nonatomic, strong)XMRentItemModel *itemModel;

@end

NS_ASSUME_NONNULL_END
