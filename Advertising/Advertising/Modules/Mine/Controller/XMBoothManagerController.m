//
//  XMBoothManagerController.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBoothManagerController.h"
#import "XMBoothManagerCell.h"
#import "XMBoothMangerRequest.h"
#import "XMGrabLandlordController.h"

@interface XMBoothManagerController ()

@property(nonatomic, strong)NSArray *dataSource;  // 数据源

@property(nonatomic, strong)UIButton *selectBtn;  // 选择展位

@property(nonatomic, strong)XMBoothMangerRequest *boothMangerRequest; // 列表

@property(nonatomic, strong)XMBoothMangerSureRequest *sureRequest; // 挂上展位

@end

@implementation XMBoothManagerController

static NSString *const managerCellId = @"managerCellId_cellId";

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
        self.boothMangerRequest.needRefresh = YES;
        [self loadData:NO];
    }];
    
    [self.tableView addFooterWithCallback:^{
        @strongify(self)
        self.boothMangerRequest.needRefresh = NO;
        [self loadData:NO];
    }];
}

// 初始化
- (void)setup
{
    self.view.backgroundColor = UIColor.whiteColor;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@25);
        make.right.equalTo(self.view.mas_right).offset(-25);
        make.height.equalTo(@54);
        make.top.safeEqualToTop(self.view).offset(15);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.selectBtn.mas_bottom).offset(10);
        make.bottom.safeEqualToBottom(self.view).offset(0);
        make.left.right.equalTo(self.view);
    }];
    
    self.navigationItem.title = @"展位管理";
    [self.tableView registerClass:[XMBoothManagerCell class] forCellReuseIdentifier:managerCellId];
    
    UIButton *buyBoothBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBoothBtn.titleLabel.font = kSysFont(14);
    [buyBoothBtn setTitle:@"购买展位" forState:UIControlStateNormal];
    [buyBoothBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:buyBoothBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

    
    // 购买展位
    @weakify(self)
    [[buyBoothBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        XMGrabLandlordController *banlandVc = [XMGrabLandlordController new];
        banlandVc.isLandlord = NO;
        banlandVc.isfirst = YES;
        [self.navigationController pushViewController:banlandVc animated:YES];
    }];
    
    // 确认投放
    [[self.selectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        self.sureRequest.boothIds = [self sureSelectModel];
        self.sureRequest.itemId = self.itemId;
        [self.sureRequest startWithCompletion:^(__kindof XMBoothMangerSureRequest * _Nonnull request, NSError * _Nonnull error) {
            if (request.businessSuccess) {
                [XMHUD showSuccess:@"成功"];
                [self.subject sendNext:@(YES)];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [XMHUD showFail:request.businessMessage];
            }
        }];
        
    }];
}

- (void)loadData:(BOOL)show
{
    show?[self.tableView showLoading]:"";
    @weakify(self)
    [self.boothMangerRequest startWithCompletion:^(__kindof XMBoothMangerRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            self.dataSource = request.businessModelArray;
        }
        [self reloadSelectNumData];
        [self.tableView hideLoadingWithRequest:request];
        [self.tableView.emptyView setDetail:@"您还没有购买展位" forState:EmptySateEmptyData];        
    }];
}

- (NSArray *)sureSelectModel
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (XMBoothMangerItemModel *itemModel in self.dataSource) {
        if (itemModel.select) {
            [tempArray addObject:@(itemModel.Id)];
        }
    }
    return tempArray;
}


// 刷新被选中的数量
- (void)reloadSelectNumData
{
    NSInteger count = 0;
    for (XMBoothMangerItemModel *itemModel in self.dataSource) {
        if (itemModel.select) {
            count++;
        }
    }
    if (count) {
        [self.selectBtn setTitle:kFormat(@"确认投放 (%zd)", count) forState:UIControlStateNormal];
        [self selectBtnEnableState];
    }else{
        [self.selectBtn setTitle:@"* 请选择展位 *" forState:UIControlStateNormal];
        [self selectBtnNoEnableState];
    }
}

// 选择按钮
- (void)handleSelectAction:(UIButton *)sender
{
    NSInteger row = sender.tag - 2019;
    XMBoothMangerItemModel *itemModel = self.dataSource[row];
    [sender setSelected:!sender.selected];
    itemModel.select = sender.isSelected;
    [self reloadSelectNumData];
}

// 不可用状态
- (void)selectBtnNoEnableState
{
    _selectBtn.layer.borderWidth = 1;
    _selectBtn.enabled = NO;
    _selectBtn.layer.borderColor = kHexColor(0xBBBBBB).CGColor;
    _selectBtn.backgroundColor = kHexColor(0xffffff);
    [_selectBtn setTitleColor:kHexColor(0xff4d4d) forState:UIControlStateNormal];
}
// 可用状态
- (void)selectBtnEnableState
{
    _selectBtn.layer.borderWidth = 0;
    _selectBtn.enabled = YES;
    _selectBtn.backgroundColor = kHexColor(0x88CC69);
    _selectBtn.layer.borderColor = UIColor.clearColor.CGColor;
    [_selectBtn setTitleColor:kHexColor(0xffffff) forState:UIControlStateNormal];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMBoothManagerCell *managerCell = [tableView dequeueReusableCellWithIdentifier:managerCellId forIndexPath:indexPath];
    XMBoothMangerItemModel *itemModel = self.dataSource[indexPath.row];
    managerCell.itemModel = itemModel;
    managerCell.selectBtn.tag = 2019+indexPath.row;
    [managerCell.selectBtn addTarget:self action:@selector(handleSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    return managerCell;
}



- (UIButton *)selectBtn
{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.layer.masksToBounds = YES;
        _selectBtn.layer.cornerRadius = 6;
        _selectBtn.titleLabel.font = kSysFont(16);
        [_selectBtn setTitle:@"* 请选择展位 *" forState:UIControlStateNormal];
        [self selectBtnNoEnableState];
        [self.view addSubview:_selectBtn];
    }
    return _selectBtn;
}

- (XMBoothMangerRequest *)boothMangerRequest
{
    if (!_boothMangerRequest) {
        _boothMangerRequest = [XMBoothMangerRequest request];
    }
    return _boothMangerRequest;
}

- (XMBoothMangerSureRequest *)sureRequest
{
    if (!_sureRequest) {
        _sureRequest = [XMBoothMangerSureRequest request];
    }
    return _sureRequest;
}

- (RACSubject *)subject
{
    if (!_subject) {
        _subject = [RACSubject subject];
    }
    return _subject;
}




@end
