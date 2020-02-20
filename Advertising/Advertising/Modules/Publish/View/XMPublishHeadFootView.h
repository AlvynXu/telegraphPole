//
//  XMPublishHeadFootView.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/15.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMPublishHeadFootView : UITableViewHeaderFooterView

@property(nonatomic, strong)UIButton *txtBtn;

@property(nonatomic, strong)UIButton *movieBtn;

@property(nonatomic, strong)UIButton *imageBtn;

+ (instancetype)headerFooterViewWithTabelView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
