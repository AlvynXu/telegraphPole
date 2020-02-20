//
//  XMMyCollectController.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/30.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMMyCollectController.h"
#import "XMMyCollectViewCell.h"
#import "XMAdvertRequest.h"
#import "XMProjectDetailController.h"

@interface XMMyCollectController ()

@property(nonatomic, strong)NSMutableArray *dataSource;

@property(nonatomic, strong)XMCollectRequest *collectRequest;

@end

static NSString *const collectcell_id = @"XMMyCollectViewCell_cellId";

@implementation XMMyCollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self addRefresh];
    [self loadData:YES];
}

// 初始化
- (void)setup
{
    self.navigationItem.title = @"我的收藏";
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.safeEqualToTop(self.view);
        make.bottom.safeEqualToBottom(self.view);
    }];
    
    [self.tableView registerClass:[XMMyCollectViewCell class] forCellReuseIdentifier:collectcell_id];
}

// 加载数据
- (void)loadData:(BOOL)show
{
    if (show) {
        [self.tableView showLoading];
    }
    [self.collectRequest startWithCompletion:^(__kindof XMCollectRequest * _Nonnull request, NSError * _Nonnull error) {
        if (request.businessSuccess) {
            self.dataSource = request.businessModelArray;
        }
        [self.tableView hideLoadingWithRequest:request];
        [self.tableView.emptyView setDetail:@"暂无收藏~" forState:EmptySateEmptyData];
    }];
}

// 刷新
- (void)addRefresh
{
    @weakify(self)
    [self.tableView addHeaderWithCallback:^{
        @strongify(self)
        self.collectRequest.needRefresh = YES;
        [self loadData:NO];
    }];
    [self.tableView addFooterWithCallback:^{
        @strongify(self)
        self.collectRequest.needRefresh = NO;
        [self loadData:NO];
    }];
}

#pragma mark ------ TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMMyCollectViewCell *cell = [tableView dequeueReusableCellWithIdentifier:collectcell_id forIndexPath:indexPath];
    cell.itemModel = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMCollectItemModel *itemModel = self.dataSource[indexPath.row];
    XMProjectDetailController *projectDetailVC = [XMProjectDetailController new];
    @weakify(self)
    [projectDetailVC.subject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        if ([x integerValue] == XMBlockTypeCollect) {
            [self.tableView headerBeginRefreshing];
        }
        
    }];
    projectDetailVC.itemId = itemModel.Id.integerValue;
    [self.navigationController pushViewController:projectDetailVC animated:YES];
}


- (XMCollectRequest *)collectRequest
{
    if (!_collectRequest) {
        _collectRequest = [XMCollectRequest request];
    }
    return _collectRequest;
}



@end
