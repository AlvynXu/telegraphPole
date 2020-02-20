//
//  XMMsgCell.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/1.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMMsgModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMMsgCell : UITableViewCell

@property(nonatomic, strong)XMMsgItemModel *msgItemModel;

@property(nonatomic, assign)BOOL noRead;

@end

NS_ASSUME_NONNULL_END
