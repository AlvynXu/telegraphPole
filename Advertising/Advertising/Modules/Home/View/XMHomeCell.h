//
//  XMHomeCell.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/16.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHeadLineModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHomeCell : UITableViewCell

@property(nonatomic, strong)XMHeadLineItemModel *itemModel;

@property(nonatomic, strong)UIView *lineV;

@property(nonatomic, assign)BOOL isEmptyData;

@end

NS_ASSUME_NONNULL_END
