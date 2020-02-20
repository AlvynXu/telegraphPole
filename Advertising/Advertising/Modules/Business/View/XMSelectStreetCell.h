//
//  XMSelectStreetCell.h
//  Advertising
//
//  Created by dingqiankun on 2020/1/7.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMAreaSelectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMSelectStreetCell : UITableViewCell

@property(nonatomic, strong)UIButton *selectBtn;

@property(nonatomic, strong)XMStreetItemModel *streetItemModel;

@end

NS_ASSUME_NONNULL_END
