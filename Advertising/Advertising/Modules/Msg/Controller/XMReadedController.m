//
//  XMReadedController.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/1.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMReadedController.h"
#import "XMMsgRequest.h"
#import "XMMsgCell.h"

@interface XMReadedController ()

@property(nonatomic, strong)XMMsgPageRequest *msgPageRequest;

@property(nonatomic, strong)NSMutableArray *dataSource;

@end

static NSString *const msgNoCell_ID = @"msgNoCell_ID";

@implementation XMReadedController

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
    [self.tableView registerClass:[XMMsgCell class] forCellReuseIdentifier:msgNoCell_ID];
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
    XMMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:msgNoCell_ID forIndexPath:indexPath];
    cell.noRead = NO;
    cell.msgItemModel = self.dataSource[indexPath.section];
    return cell;
}




- (XMMsgPageRequest *)msgPageRequest
{
    if (!_msgPageRequest) {
        _msgPageRequest = [XMMsgPageRequest request];
        _msgPageRequest.status = YES;
    }
    return _msgPageRequest;
}




@end
