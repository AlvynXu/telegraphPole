//
//  XMTeamCell.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/27.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMTeamModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface XMTeamCell : UITableViewCell

@property(nonatomic, assign)BOOL team;

@property(nonatomic, strong)XMTeamPageItemModel *teamModel;

@property(nonatomic, strong)XMProfitPageItemModel *profitItemModel;

@end

NS_ASSUME_NONNULL_END
