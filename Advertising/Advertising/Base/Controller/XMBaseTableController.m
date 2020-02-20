//
//  GXBaseTableController.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseTableController.h"

@interface XMBaseTableController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation XMBaseTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.view.backgroundColor = kMainBackGroundColor;
}

// 初始化
- (void)initialize
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}


#pragma mark   --------  UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.000f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark ----- 懒加载
- (UITableView *)tableView
{
    if (!_tableView) {        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle?:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


@end
