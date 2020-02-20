//
//  XMMessageBoardCell.h
//  Advertising
//
//  Created by dingqiankun on 2020/1/15.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMProjectDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMMessageBoardCell : UITableViewCell

@property(nonatomic, strong)XMProjectMessageItemModel *itemModel;

@property(nonatomic, assign)BOOL isEmptyData; // 空数据

@end

NS_ASSUME_NONNULL_END
