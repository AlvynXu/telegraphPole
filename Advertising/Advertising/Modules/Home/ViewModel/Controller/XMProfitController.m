//
//  XMProfitController.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/2.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMProfitController.h"
#import "XMMyTeamHeadView.h"
#import "XMTeamCell.h"
#import "XMMyTeamRequest.h"
#import "XMHomeRequest.h"

@interface XMProfitController ()

@property(nonatomic, strong)XMMyTeamHeadView *myTeamHeadView;

@property(nonatomic, strong)NSArray *dataSource;

@property(nonatomic, strong)XMMyProfitPageRequest *profitRequest;  //

@property(nonatomic, strong)XMHomeMsgRequest *msgRequest; // 头部数据

@end

static NSString *const myProfitCell_id = @"myProfitCell_id";

@implementation XMProfitController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self loadPageData:YES];
    [self loadData];
    [self addResresh];
}

- (void)addResresh
{
    @weakify(self)
    [self.tableView addHeaderWithCallback:^{
        @strongify(self)
        self.profitRequest.needRefresh = YES;
        [self loadPageData:NO];
        [self loadData];
    }];
    
    [self.tableView addFooterWithCallback:^{
        @strongify(self)
        self.profitRequest.needRefresh = NO;
        [self loadPageData:NO];
    }];
}

- (void)setup
{
    self.view.backgroundColor = kHexColor(0xFFFFFFFF);
    self.navigationItem.title = @"收支明细";
    self.myTeamHeadView.team = NO;
    self.myTeamHeadView.hidden = YES;
//    [self.myTeamHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@(0));
//        make.right.equalTo(self.view.mas_right);
//        make.height.equalTo(@(85));
//        make.top.safeEqualToTop(self.view).offset(10);
//    }];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[XMTeamCell class] forCellReuseIdentifier:myProfitCell_id];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.safeEqualToTop(self.view).offset(10);
        make.bottom.safeEqualToBottom(self.view);
    }];
}

// 加载头部
- (void)loadData
{
    @weakify(self)
    [self.msgRequest startWithCompletion:^(__kindof XMHomeMsgRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            self.myTeamHeadView.homeMSgModel = request.businessModel;
        }
    }];
}

// 加载分页
- (void)loadPageData:(BOOL)show
{
    if (show) {
        [self.tableView showLoading];
    }
    
    @weakify(self)
    [self.profitRequest startWithCompletion:^(__kindof XMMyProfitPageRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            self.dataSource = request.businessModelArray;
        }
        [self.tableView hideLoadingWithRequest:request];
        [self.tableView.emptyView setDetail:@"暂无明细" forState:EmptySateEmptyData];
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMTeamCell *teamCell = [tableView dequeueReusableCellWithIdentifier:myProfitCell_id forIndexPath:indexPath];
    teamCell.profitItemModel = self.dataSource[indexPath.row];
    return teamCell;
}


- (XMMyTeamHeadView *)myTeamHeadView
{
    if (!_myTeamHeadView) {
        _myTeamHeadView = [XMMyTeamHeadView new];
        [self.view addSubview:_myTeamHeadView];
    }
    return _myTeamHeadView;
}

- (XMMyProfitPageRequest *)profitRequest
{
    if (!_profitRequest) {
        _profitRequest = [XMMyProfitPageRequest request];
    }
    return _profitRequest;
}

- (XMHomeMsgRequest *)msgRequest
{
    if (!_msgRequest) {
        _msgRequest = [XMHomeMsgRequest request];
    }
    return _msgRequest;
}




@end
