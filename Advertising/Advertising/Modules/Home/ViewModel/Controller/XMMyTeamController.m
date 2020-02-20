//
//  XMMyTeamController.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/27.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMMyTeamController.h"
#import "XMMyTeamHeadView.h"
#import "XMTeamCell.h"
#import "XMMyTeamRequest.h"
#import "XMShareController.h"



@interface XMMyTeamController ()

@property(nonatomic, strong)XMMyTeamHeadView *myTeamHeadView;

@property(nonatomic, strong)NSArray *dataSource;

@property(nonatomic, strong)XMMyTeamRequest *teamRequest;

@property(nonatomic, strong)XMMyTeamPageRequest *myteamPageRequest;

@end

@implementation XMMyTeamController

static NSString *const myteamCell_id = @"myteamCell_id";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self loadHeadData];
    [self loadPageRequest:YES];
    [self addRefresh];
}


// 添加刷新
- (void)addRefresh
{
    @weakify(self)
    [self.tableView addHeaderWithCallback:^{
        @strongify(self)
        self.myteamPageRequest.needRefresh = YES;
        [self loadPageRequest:NO];
        [self loadHeadData];
    }];
    
    [self.tableView addFooterWithCallback:^{
        @strongify(self)
        self.myteamPageRequest.needRefresh = NO;
        [self loadPageRequest:NO];
    }];
}

// 加载头部信息
- (void)loadHeadData
{
    @weakify(self)
    [self.teamRequest startWithCompletion:^(__kindof XMMyTeamRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            self.myTeamHeadView.teamModel = request.businessModel;
        }
    }];
}

- (void)loadPageRequest:(BOOL)show
{
    if (show) {
         [self.tableView showLoading];
    }
    @weakify(self)
    [self.myteamPageRequest startWithCompletion:^(__kindof XMMyTeamPageRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            self.dataSource = request.businessModelArray;
        }
        [self.tableView hideLoadingWithRequest:request];
        [self.tableView.emptyView setDetail:@"暂无团队" forState:EmptySateEmptyData];
    }];
}

- (void)setup
{
    self.view.backgroundColor = kHexColor(0xFFFFFFFF);
    self.navigationItem.title = @"我的团队";
    self.myTeamHeadView.team = YES;
    [self.myTeamHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(85));
        make.top.safeEqualToTop(self.view).offset(10);
    }];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[XMTeamCell class] forCellReuseIdentifier:myteamCell_id];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.myTeamHeadView.mas_bottom).offset(10);
        make.bottom.safeEqualToBottom(self.view);
    }];
    
    UITapGestureRecognizer *goShareTap = [[UITapGestureRecognizer alloc] init];
    @weakify(self)
    [[goShareTap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self)
        XMShareController *shareVC = [XMShareController new];
        [self.navigationController pushViewController:shareVC animated:YES];
    }];
    
    [self.myTeamHeadView.goShareImgV addGestureRecognizer:goShareTap];
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
    XMTeamCell *teamCell = [tableView dequeueReusableCellWithIdentifier:myteamCell_id forIndexPath:indexPath];
    teamCell.team = YES;
    teamCell.teamModel = self.dataSource[indexPath.row];
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


- (XMMyTeamRequest *)teamRequest
{
    if (!_teamRequest) {
        _teamRequest = [XMMyTeamRequest request];
    }
    return _teamRequest;
}

- (XMMyTeamPageRequest *)myteamPageRequest
{
    if (!_myteamPageRequest) {
        _myteamPageRequest = [XMMyTeamPageRequest request];
    }
    return _myteamPageRequest;
}

- (void)dealloc
{
    NSLog(@"===============");
}

@end
