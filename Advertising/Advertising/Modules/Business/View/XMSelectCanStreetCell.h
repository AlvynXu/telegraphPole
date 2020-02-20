//
//  XMSelectCanStreetCell.h
//  Advertising
//
//  Created by dingqiankun on 2020/1/2.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMRentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMSelectCanStreetCell : UITableViewCell

@property(nonatomic, strong)XMRentCanStreetItemModel *itemModel;

@property(nonatomic, strong)UIButton *selectBtn;

@end

NS_ASSUME_NONNULL_END
