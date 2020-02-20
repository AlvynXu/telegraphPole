//
//  XMMoveImgV.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/15.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMMoveImgV : UIView

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NSIndexPath *indexPath;

@property(nonatomic, strong)NSMutableArray *dataSource;

@end

NS_ASSUME_NONNULL_END
