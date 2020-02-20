//
//  XMLanlordRecordController.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/5.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMLanlordRecordController.h"
#import "XMLanlordRecordCell.h"
#import "XMLandlordRecordApi.h"
#import "XMGrabLandlordController.h"
#import "XMLandlordHeadInfoView.h"
#import "XMGrabLandlordController.h"
#import "XMGrabLandlordController.h"


@interface XMLanlordRecordController ()

@property(nonatomic, strong)XMLandlordRecordApi *api;

@property(nonatomic, strong)XMLandlordGetNumApi *getNumApi;

@property(nonatomic, strong)NSArray *dataSource;

@property(nonatomic, strong)UIButton *btn;

@property(nonatomic, strong)XMBoothRecordGetNumModel *numModel;

@property(nonatomic, assign)NSInteger totalBoothNum;

@end

static NSString *const landlordRecord_Id = @"landlordRecord_Id";

@implementation XMLanlordRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的地主";
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
    [self.api startWithCompletion:^(__kindof XMLandlordRecordApi * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            XMLanlordRecordModel *model = request.businessModel;
            self.totalBoothNum = model.total;
            self.dataSource = request.businessModelArray;
        }
        [self.tableView hideLoadingWithRequest:request rect:CGRectMake(0, kScreenHeight/2, kScreenWidth, 100)];
        [self.tableView.emptyView setDetail:@"您还没有土地~" forState:EmptySateEmptyData];
    }];
    
    [self.getNumApi startWithCompletion:^(__kindof XMLandlordGetNumApi * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            self.numModel = request.businessModel;
        }
        [self.tableView reloadData];
    }];
}

// 初始化
- (void)setup
{
    self.view.backgroundColor = UIColor.whiteColor;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[XMLanlordRecordCell class] forCellReuseIdentifier:landlordRecord_Id];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.safeEqualToTop(self.view).offset(10);
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
            VC.isLandlord = YES;
            VC.isfirst = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }else{
            
            NSArray *viewControllers = self.navigationController.viewControllers;
            for (UIViewController *vc in viewControllers) {
                if ([vc isMemberOfClass:[XMGrabLandlordController class]]) {
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
            
//            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    XMLandlordHeadInfoView *headInfoV = [[XMLandlordHeadInfoView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    [headInfoV.goBlockBtn addTarget:self action:@selector(handGoLockAction) forControlEvents:UIControlEventTouchUpInside];
    headInfoV.total = self.totalBoothNum;
    headInfoV.getNumModel = self.numModel;
    return headInfoV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMLanlordRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:landlordRecord_Id forIndexPath:indexPath];
    XMLanlordRecordsItemModel *itemModel = self.dataSource[indexPath.row];
    cell.itemModel = itemModel;
    return cell;
}


#pragma mark  ---- 去解锁
- (void)handGoLockAction
{
    XMGrabLandlordController *banlandVc = [XMGrabLandlordController new];
    banlandVc.isLandlord = NO;
    banlandVc.isfirst = YES;
    [self.navigationController pushViewController:banlandVc animated:YES];
}


- (XMLandlordRecordApi *)api
{
    if (!_api) {
        _api = [XMLandlordRecordApi request];
    }
    return _api;
}

- (UIButton *)btn
{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = kMainColor;
        [_btn setTitle:@"去抢土地" forState:UIControlStateNormal];
        _btn.titleLabel.font = kBoldFont(18);
        _btn.layer.cornerRadius = 25;
        _btn.layer.masksToBounds = YES;
        [self.view addSubview:_btn];
    }
    return _btn;
}

- (XMLandlordGetNumApi *)getNumApi
{
    if (!_getNumApi) {
        _getNumApi = [XMLandlordGetNumApi request];
    }
    return _getNumApi;
}


@end
