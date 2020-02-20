//
//  GXBaseTableController.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMBaseController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMBaseTableController : XMBaseController

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, assign)UITableViewStyle tableViewStyle;  //


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;


@end

NS_ASSUME_NONNULL_END
