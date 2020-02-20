//
//  XMShopController.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/22.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBusinessController.h"
#import "XMLanlordSectionView.h"
#import "XMRentCell.h"
#import "LYLocationUtil.h"
#import "XMRentRequest.h"
#import "XMBuyLandlordRequest.h"
#import "XMSelectCanStreetView.h"
#import "XMSelectAllCityView.h"
#import "XMWantRentController.h"
#import "XMSelectCityView.h"


@interface XMBusinessController ()

@property(nonatomic, strong)XMLanlordSectionView *sectionHeader;  // 城市选择

@property(nonatomic, strong)XMRentListRequest *rentListRequest;  // 他人求租

@property(nonatomic, strong)XMGetCityCodeRequest *cityCodeRequest;  // 获取默认城市编码

@property(nonatomic, strong)XMRentMyRentRequest *myRentRequest;   // 我的求租

@property(nonatomic,strong)XMRentCanStreetRequest *canRentRequest;  //可用求租街道

@property(nonatomic, strong)XMRentOtherPersonRequest *rentOtherRequest;  // 租给他人

@property(nonatomic, copy)NSString *localCity;  // 当前定位城市

@property(nonatomic, strong)NSMutableArray *dataSource;  // 他人求租

@property(nonatomic, strong)NSArray *myRentDataSource;  // 我的求租

@property(nonatomic, strong)XMSelectCanStreetView *selectStreetView;  // 选择街道

@property(nonatomic, strong)XMSelectCityView *selectCityV;  // 选择城市

@end

static NSString *const rentcell_id = @"XMRentCell_cellId";

@implementation XMBusinessController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self initCity];
    [self loadDefaultCityCode];
    [self addRefresh];
}

// 刷新
- (void)addRefresh
{
    @weakify(self)
    [self.tableView addHeaderWithCallback:^{
        @strongify(self)
        self.rentListRequest.needRefresh = YES;
        [self loadData];
    }];
    
    [self.tableView addFooterWithCallback:^{
        @strongify(self)
        self.rentListRequest.needRefresh = NO;
        [self loadData];
    }];
}


// 城市
- (void)initCity
{
    self.localCity = [LYLocationUtil getLocalCity];
    // 城市选择
    XMLanlordSectionView *sectionHeader =  [[XMLanlordSectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 200, 60)];
    sectionHeader.backgroundColor = UIColor.clearColor;
    sectionHeader.intrinsicContentSize = CGSizeMake(kScreenWidth-160, 60);
    sectionHeader.citySelectV.layer.borderWidth = 0;
    self.sectionHeader = sectionHeader;
    sectionHeader.citySelectV.titleLbl.text = kFormat(@"%@",[LYLocationUtil getLocalCity]);
    @weakify(self)
    // 选择城市
    UITapGestureRecognizer *cityTap = [[UITapGestureRecognizer alloc] init];
    [[cityTap rac_gestureSignal] subscribeNext:^(id x) {
        @strongify(self)
        [self.selectCityV show];
//        [self.citySelectV show];
    }];
    [sectionHeader.citySelectV addGestureRecognizer:cityTap];
    self.navigationItem.titleView = sectionHeader;
    
    // 城市选择回调
    [self.selectCityV.subject subscribeNext:^(id  _Nullable x) {
        NSString *code = x[@"code"];
        self.sectionHeader.citySelectV.titleLbl.text = x[@"name"];
        self.rentListRequest.areaCode = code.integerValue; // 城市编码
        self.myRentRequest.areaCode = code.integerValue;
        
        [self.tableView headerBeginRefreshing];
    }];
    
//    [self.citySelectV.subject subscribeNext:^(id  _Nullable x) {
//
//    }];
}


// 获取默认城市编码
- (void)loadDefaultCityCode
{
    self.localCity = [LYLocationUtil getLocalCity];
    if ([self.localCity isEmpty]) {
        [self.view showLoadigWith:@"正在获取定位...."];
        return;
    }else{
        [self.view showLoading];
    }
    @weakify(self)
    [self.cityCodeRequest startWithCompletion:^(__kindof XMGetCityCodeRequest * _Nonnull request, NSError * _Nonnull error) {
        [self.view hideLoading];
        @strongify(self)
        // 成功之后 获取默认定位列表
        if (request.businessSuccess) {
            // 获取当前定位城市编码
            XMCityCodeModel *codeModel = request.businessModel;
            self.rentListRequest.areaCode = codeModel.code.integerValue; // 城市编码
            self.myRentRequest.areaCode = codeModel.code.integerValue;
            [self loadData];
        }
    }];
}


// 初始化
- (void)setup
{
    // 通知
    @weakify(self)
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kRentNotiFication_PaySuccessRefresh object:nil] subscribeNext:^(id x) {
        @strongify(self)
        [self.tableView headerBeginRefreshing];
    }];
    
    self.navigationController.navigationBar.barTintColor = UIColor.whiteColor;
    self.navigationController.navigationBar.backgroundColor = UIColor.whiteColor;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.safeEqualToTop(self.view).offset(1.5);
        make.bottom.safeEqualToBottom(self.view);
        make.left.right.equalTo(self.view);
    }];
    
    self.tableView.backgroundColor = UIColor.whiteColor;
    
    [self.tableView registerClass:[XMRentCell class] forCellReuseIdentifier:rentcell_id];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    UIButton *rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthBtn.frame = CGRectMake(0, 0, 65, 30);
    [rigthBtn setTitle:@"我要求租" forState:UIControlStateNormal];
    rigthBtn.titleLabel.font = kSysFont(16);
    [rigthBtn setTitleColor:kHexColor(0xFFF85F53) forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //租给他
    [self.selectStreetView.sureBuySubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        NSNumber *orderId = x[@"orderId"];
        NSArray *areaCodes = x[@"areaCode"];
        @weakify(self)
        self.rentOtherRequest.orderId = orderId.integerValue;
        self.rentOtherRequest.streetCodes = areaCodes;
        [self.rentOtherRequest startWithCompletion:^(__kindof XMRentOtherPersonRequest * _Nonnull request, NSError * _Nonnull error) {
            @strongify(self)
            if (request.businessSuccess) {
                [self.selectStreetView hinde];
                [XMHUD showSuccess:@"成功"];
            }else{
                [XMHUD showFail:@"成功"];
            }
        }];
    }];
    
    [[rigthBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
       @strongify(self)
        XMWantRentController *VC = [XMWantRentController new];
        [self.navigationController pushViewController:VC animated:YES];
    }];
    
}

// 加载数据
- (void)loadData
{
    @weakify(self)
    [self.myRentRequest startWithCompletion:^(__kindof XMRentMyRentRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            XMMyRentModel *model = request.businessModel;
            self.myRentDataSource = model.data;
        }
        [self loadListData];
    }];
}
// 加载列表数据
- (void)loadListData
{
    @weakify(self)
    [self.rentListRequest startWithCompletion:^(__kindof XMRentListRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            self.dataSource = request.businessModelArray;
        }
        if (self.myRentDataSource.count&&self.dataSource.count) {
            [self.tableView hideLoadingWithRequest:self.rentListRequest];
            return ;
        }
        if (self.dataSource.count) {
            [self.tableView hideLoadingWithRequest:self.rentListRequest];
            return;
        }
        
        if (!self.dataSource.count && !self.myRentDataSource.count) {
            [self.tableView hideLoadingWithRequest:self.rentListRequest];
            return;
        }
        
        if (self.myRentDataSource.count) {
            [self.tableView hideLoadingWithRequest:self.myRentRequest];
            return ;
        }
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count + self.myRentDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMRentCell *cell = [tableView dequeueReusableCellWithIdentifier:rentcell_id forIndexPath:indexPath];
    if (indexPath.section<self.myRentDataSource.count) {
        cell.myRentModel = self.myRentDataSource[indexPath.section];
    }else{
        // 当前模型减去我的模型数据
        cell.itemModel = self.dataSource[indexPath.section - self.myRentDataSource.count];
        [cell.sallBtn addTarget:self action:@selector(handSallAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.sallBtn.tag = kButton_tag + indexPath.section;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 20;
    }else{
        return 0;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


// 出售
- (void)handSallAction:(UIButton *)sender
{
    NSInteger tag = sender.tag - kButton_tag;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:tag];
    XMRentItemModel *itemModel = self.dataSource[indexPath.section - self.myRentDataSource.count];
    self.canRentRequest.orderId = itemModel.Id;
    [self.tableView showLoading];
    @weakify(self)
    [self.canRentRequest startWithCompletion:^(__kindof XMRentCanStreetRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        [self.tableView hideLoading];
        if (request.businessSuccess) {
            self.selectStreetView.day = itemModel.days;
            [self.selectStreetView show];
            XMRentCanStreetModel *streetModel = request.businessModel;
            self.selectStreetView.count = streetModel.count;
            self.selectStreetView.orderId = itemModel.Id;
            self.selectStreetView.dataSource = streetModel.userStreetDTOList;
        }
    }];
}


- (XMRentListRequest *)rentListRequest
{
    if (!_rentListRequest) {
        _rentListRequest = [XMRentListRequest request];
    }
    return _rentListRequest;
}


- (XMGetCityCodeRequest *)cityCodeRequest
{
    if (!_cityCodeRequest) {
        _cityCodeRequest = [XMGetCityCodeRequest request];
        _cityCodeRequest.cityName = self.localCity;
    }
    return _cityCodeRequest;
}

- (XMRentMyRentRequest *)myRentRequest
{
    if (!_myRentRequest) {
        _myRentRequest = [XMRentMyRentRequest request];
    }
    return _myRentRequest;
}

- (XMRentCanStreetRequest *)canRentRequest
{
    if (!_canRentRequest) {
        _canRentRequest = [XMRentCanStreetRequest request];
    }
    return _canRentRequest;
}

- (XMSelectCanStreetView *)selectStreetView
{
    if (!_selectStreetView) {
        _selectStreetView = [[XMSelectCanStreetView alloc] initWithFrame:kWindow.bounds];
    }
    return _selectStreetView;
}

- (XMSelectCityView *)selectCityV
{
    if (!_selectCityV) {
        _selectCityV = [[XMSelectCityView alloc] initWithFrame:kWindow.bounds];
        _selectCityV.level = XMLevelTwo;
    }
    return _selectCityV;
}


- (XMRentOtherPersonRequest *)rentOtherRequest
{
    if (!_rentOtherRequest) {
        _rentOtherRequest = [XMRentOtherPersonRequest request];
    }
    return _rentOtherRequest;
}



@end
