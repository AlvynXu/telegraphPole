//
//  XMNoReadController.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/1.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMNoReadController.h"
#import "XMMsgCell.h"
#import "XMMsgRequest.h"

@interface XMNoReadController ()

@property(nonatomic, strong)XMMsgPageRequest *msgPageRequest;

@property(nonatomic, strong)XMMsgSetReadRequest *setReadRequest;

@property(nonatomic, strong)NSMutableArray *dataSource;

@end

static NSString *const msgCell_ID = @"msgCell_ID";

@implementation XMNoReadController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self loadData:YES];
    [self addRefresh];

}

// 添加刷新
- (void)addRefresh
{
    @weakify(self)
    [self.tableView addHeaderWithCallback:^{
        @strongify(self)
        self.msgPageRequest.needRefresh = YES;
        [self loadData:NO];
    }];
    
    [self.tableView addFooterWithCallback:^{
        @strongify(self)
        self.msgPageRequest.needRefresh = NO;
        [self loadData:NO];
    }];
}

// 加载数据
- (void)loadData:(BOOL)show
{
    if (show) {
        [self.tableView showLoading];
    }
    @weakify(self)
    [self.msgPageRequest startWithCompletion:^(__kindof XMMsgPageRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        [self.tableView hideLoading];
        if (request.businessSuccess) {
            self.dataSource = request.businessModelArray;
        }
        [self.tableView hideLoadingWithRequest:request];
        [self.tableView.emptyView setDetail:@"您还没有消息记录哦" forState:EmptySateEmptyData];
    }];
}

// 初始化
 -(void)setup
{
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[XMMsgCell class] forCellReuseIdentifier:msgCell_ID];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.safeEqualToTop(self.view);
        make.bottom.safeEqualToBottom(self.view);
        make.left.right.equalTo(self.view);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;//自动尺寸
}

//预估行高
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:msgCell_ID forIndexPath:indexPath];
    cell.noRead = YES;
    cell.msgItemModel = self.dataSource[indexPath.section];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMMsgItemModel *itemModel = self.dataSource[indexPath.section];
    self.setReadRequest.Id = itemModel.Id;
    @weakify(self)
    [self.setReadRequest startWithCompletion:^(__kindof XMMsgSetReadRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            [XMHUD showText:@"已至已读"];
            [self.dataSource removeObjectAtIndex:indexPath.section];
            NSIndexSet *set = [NSIndexSet indexSetWithIndex:indexPath.section];
            [self.tableView deleteSections:set withRowAnimation:UITableViewRowAnimationLeft];
            if (self.dataSource.count == 0) {
                // 手动调用刷新
                [self.tableView.mj_header beginRefreshing];
            }
        }
    }];
}


- (XMMsgPageRequest *)msgPageRequest
{
    if (!_msgPageRequest) {
        _msgPageRequest = [XMMsgPageRequest request];
        _msgPageRequest.status = NO;
    }
    return _msgPageRequest;
}

- (XMMsgSetReadRequest *)setReadRequest
{
    if (!_setReadRequest) {
        _setReadRequest = [XMMsgSetReadRequest request];
    }
    return _setReadRequest;
}


@end
