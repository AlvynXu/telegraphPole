//
//  XMPublishCell.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/15.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMMoveImgV.h"
#import "XMPublishItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMPublishCell : UITableViewCell

@property(nonatomic, strong)UIButton *delBtn;  // 删除按钮

@property(nonatomic, strong)SZTextView *contentTxt;  // 内容

@property(nonatomic, strong)UIButton *playBtn;  // 播放

@property(nonatomic, strong)UIButton *selectImgBtn;  // 选择图片

@property(nonatomic, strong)XMPublishItemModel *itemModel; 


@end

NS_ASSUME_NONNULL_END
