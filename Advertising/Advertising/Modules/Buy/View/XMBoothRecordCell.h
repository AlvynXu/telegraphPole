//
//  XMBoothRecordCell.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/5.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMRecordsModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ClickTapBlock)(NSInteger index);

@interface XMBoothRecordCell : UITableViewCell

@property(nonatomic, assign)NSInteger index;

@property(nonatomic, copy)ClickTapBlock tapBlock;

@property(nonatomic, strong)XMBoothRecordsItemModel *itemModel;

@end

NS_ASSUME_NONNULL_END
