//
//  XMBoothRecordController.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/5.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBoothRecordController.h"
#import "XMBoothRecordApi.h"
#import "XMBoothRecordCell.h"
#import "XMGrabLandlordController.h"
#import "XMProjectDetailController.h"


@interface XMBoothRecordController ()

@property(nonatomic, strong)NSArray *dataSource;

@property(nonatomic, strong)XMBoothRecordApi *api;

@property(nonatomic, strong)UIButton *btn;

@property(nonatomic, strong)UILabel *totalLbl;  // 总数

@end

static NSString *boothRecord_Id = @"boothRecord_Id";

@implementation XMBoothRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self loadData:YES];
    [self addRefresh];
}

- (void)addRefresh
{
    @weakify(self)
    [self.tableView addHeaderWithCallback:^{
        @strongify(self)
        self.api.needRefresh = YES;
        [self loadData:NO];
    }];
    
    [self.tableView addFooterWithCallback:^{
        @strongify(self)
        self.api.needRefresh = NO;
        [self loadData:NO];
    }];
}

- (void)loadData:(BOOL)show
{
    if (show) {
        [self.tableView showPageLoading];
    }
    @weakify(self)
    [self.api startWithCompletion:^(__kindof XMBoothRecordApi * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            self.dataSource = request.businessModelArray;
            XMBoothRecordModel *model = request.businessModel;
            self.totalLbl.text = kFormat(@"当前有%zd个展位", model.total);
            [self.totalLbl changeStr:kFormat(@"%zd", model.total) color:kHexColor(0xFFF85F53) font:kSysFont(14)];
        }
        [self.tableView hideLoadingWithRequest:request];
        [self.tableView.emptyView setDetail:@"您还没有展位~" forState:EmptySateEmptyData];
    }];
}


// 初始化
- (void)setup
{
    self.navigationItem.title = @"我的展位";
    self.navigationController.navigationBar.barTintColor = UIColor.whiteColor;
    [self.totalLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.safeEqualToTop(self.view);
        make.right.equalTo(self.view);
        make.left.equalTo(@15);
        make.height.equalTo(@44);
    }];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[XMBoothRecordCell class] forCellReuseIdentifier:boothRecord_Id];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.totalLbl.mas_bottom);
        make.bottom.equalTo(self.btn.mas_top).offset(-10);
    }];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.safeEqualToBottom(self.view).offset(-10);
        make.height.equalTo(@50);
        make.width.equalTo(@(kScreenWidth - 55 * 2));
        make.centerX.equalTo(self.view);
    }];
    
    @weakify(self)
    [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (self.isPush) {
            XMGrabLandlordController *VC = [XMGrabLandlordController new];
            [self.navigationController pushViewController:VC animated:YES];
        }else{
            NSArray *viewControllers = self.navigationController.viewControllers;
            for (UIViewController *vc in viewControllers) {
                if ([vc isMemberOfClass:[XMGrabLandlordController class]]) {
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMBoothRecordsItemModel *itemModel = self.dataSource[indexPath.section];
    return itemModel.cellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMBoothRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:boothRecord_Id forIndexPath:indexPath];
    cell.index = indexPath.section;
    @weakify(self)
    cell.tapBlock = ^(NSInteger index) {
        @strongify(self)
        XMBoothRecordsItemModel *itemModel = self.dataSource[index];
        // 跳转到详情页
        XMProjectDetailController *projectDetailVC = [XMProjectDetailController new];
        projectDetailVC.itemId = itemModel.itemId;
        [self.navigationController pushViewController:projectDetailVC animated:YES];
    };
    XMBoothRecordsItemModel *itemModel = self.dataSource[indexPath.section];
    cell.itemModel = itemModel;
    return cell;
}

- (XMBoothRecordApi *)api
{
    if (!_api) {
        _api = [XMBoothRecordApi request];
    }
    return _api;
}

- (UIButton *)btn
{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = kMainColor;
        [_btn setTitle:@"去抢展位" forState:UIControlStateNormal];
        _btn.titleLabel.font = kBoldFont(18);
        _btn.layer.cornerRadius = 25;
        _btn.layer.masksToBounds = YES;
        [self.view addSubview:_btn];
    }
    return _btn;
}

- (UILabel *)totalLbl
{
    if (!_totalLbl) {
        _totalLbl = [UILabel new];
        _totalLbl.text = @"当前有多少个展位";
        _totalLbl.textColor = kHexColor(0xFF000000);
        _totalLbl.font = kSysFont(14);
        [self.view addSubview:_totalLbl];
    }
    return _totalLbl;
}



@end
