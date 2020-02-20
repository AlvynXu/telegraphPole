//
//  XMBoothManagerCell.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMBoothMangerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMBoothManagerCell : UITableViewCell

@property(nonatomic, strong)XMBoothMangerItemModel *itemModel;

@property(nonatomic, strong)UIButton *selectBtn; // 选择

@end

NS_ASSUME_NONNULL_END
