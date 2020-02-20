//
//  XMProjectDetailCell.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/18.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMProjectDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMProjectDetailCell : UITableViewCell

@property(nonatomic,strong)XMProjectListItemModel *itemModel;

@property(nonatomic, strong)UIButton *playBtn;  // 播放按钮

@end

NS_ASSUME_NONNULL_END
