//
//  XMMyAdvertController.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMMyAdvertController.h"
#import "XMMyAdvertCell.h"
#import "XMAdvertRequest.h"
#import "XMBoothManagerController.h"
#import "XMPublishController.h"
#import "XMProjectDetailController.h"

@interface XMMyAdvertController ()

@property(nonatomic, strong)NSArray *dataSource;  // 数据源

@property(nonatomic, strong)UIButton *addProjectBtn; // 新增项目

@property(nonatomic, strong)XMAdvertRequest *advertRequest; //

@end

static NSString *const advertCellId = @"XMMyAdvertCell_cellId";

@implementation XMMyAdvertController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.advertRequest.needRefresh = YES;
    [self loadData:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self addRefresh];
}

- (void)addRefresh
{
    @weakify(self)
    [self.tableView addHeaderWithCallback:^{
        @strongify(self)
        self.advertRequest.needRefresh = YES;
        [self loadData:NO];
    }];
    
    [self.tableView addFooterWithCallback:^{
        @strongify(self)
        self.advertRequest.needRefresh = NO;
        [self loadData:NO];
    }];
}

// 加载数据
- (void)loadData:(BOOL)show
{
    show?[self.tableView showLoading]:@"";
    @weakify(self)
    [self.advertRequest startWithCompletion:^(__kindof XMAdvertRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            self.dataSource = request.businessModelArray;
        }
        [self.tableView hideLoadingWithRequest:request];
    }];
}

// 初始化
- (void)setup
{
    self.navigationItem.title = @"我的推广";
    self.view.backgroundColor = UIColor.whiteColor;
    [self.addProjectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.equalTo(@44);
        make.width.equalTo(@260);
        make.bottom.safeEqualToBottom(self.view).offset(-20);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.safeEqualToTop(self.view);
        make.bottom.equalTo(self.addProjectBtn.mas_top).offset(-15);
    }];
    [self.tableView registerClass:[XMMyAdvertCell class] forCellReuseIdentifier:advertCellId];
    
    // 新增项目
    @weakify(self)
    [[self.addProjectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        XMPublishController *VC = [XMPublishController new];
        [self.navigationController pushViewController:VC animated:YES];
    }];
}

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
    XMMyAdvertCell *cell = [tableView dequeueReusableCellWithIdentifier:advertCellId forIndexPath:indexPath];
    XMAdvertItemModel *itemModel = self.dataSource[indexPath.row];
    cell.itemModel = itemModel;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMProjectDetailController *detailVC = [XMProjectDetailController new];
    XMAdvertItemModel *itemModel = self.dataSource[indexPath.row];
    detailVC.itemId = itemModel.Id.integerValue;
    detailVC.status = itemModel.status;
    detailVC.isEdit = YES;
    [detailVC.subject subscribeNext:^(id  _Nullable x) {
    }];
    [self.navigationController pushViewController:detailVC animated:YES];
}


- (UIButton *)addProjectBtn
{
    if (!_addProjectBtn) {
        _addProjectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addProjectBtn setTitle:@"新增项目" forState:UIControlStateNormal];
        [_addProjectBtn setTitleColor:kHexColor(0x101010) forState:UIControlStateNormal];
        _addProjectBtn.titleLabel.font = kSysFont(16);
        [_addProjectBtn setBackgroundImage:kGetImage(@"landlord_base") forState:UIControlStateNormal];
        [self.view addSubview:_addProjectBtn];
    }
    return _addProjectBtn;
}



- (XMAdvertRequest *)advertRequest
{
    if (!_advertRequest) {
        _advertRequest = [XMAdvertRequest request];
    }
    return _advertRequest;
}



@end
