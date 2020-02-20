//
//  XMWantRentController.m
//  Advertising
//
//  Created by dingqiankun on 2020/1/6.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import "XMWantRentController.h"
#import "XMWantRentBootomView.h"
#import "XMAllAreaaCell.h"
#import "UIButton+ImageTitleSpacing.h"
#import "XMSelectStreetView.h"
#import "XMLanlordSectionView.h"
#import "XMBuyLandlordRequest.h"
#import "XMSelectAllCityView.h"
#import "LYLocationUtil.h"
#import "XMAreaSelectRequest.h"
#import "XMRentRequest.h"
#import "XMSuccessController.h"
#import "XMPayUtil.h"
#import "XMSelectCityView.h"

@interface XMWantRentController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong)XMLanlordSectionView *sectionHeader;  // 城市选择

@property(nonatomic, strong)XMGetCityCodeRequest *cityCodeRequest;  // 获取默认城市编码

@property(nonatomic, strong)UIView *topBaseV;  // 顶部视图

@property(nonatomic, strong)UIButton *allSelectBtn;  // 全选

@property(nonatomic, strong)UICollectionView *collectView;  // 全选

@property(nonatomic, strong)UIScrollView *scrollView;

@property(nonatomic, strong)XMWantRentBootomView *wantRentV;  // 底部视图

@property(nonatomic, strong)NSArray *dataSource;

//@property(nonatomic, strong)XMSelectAllCityView *citySelectV;  // 选择城市
@property(nonatomic, strong)XMSelectCityView *selectCityV;  // 选择城市

@property(nonatomic, copy)NSString *localCity;  // 当前定位城市

@property(nonatomic, strong)XMCountyRequest *countryRequest; // 获取所有区

@property(nonatomic, assign)BOOL isAllSelect;  // 全选

@property(nonatomic, assign)NSInteger selectRow;  // 当前选中的区域

@property(nonatomic, strong)XMWantRentPayRequest *wantRentPayRequest;  // 支付并发布

@end

static NSString *const allAreaaCell_identifer = @"XMAllAreaaCell_cellId";

@implementation XMWantRentController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self loadAllArea];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self setup];
    [self initCity];  // 头部选择城市回调
    [self loadDefaultCityCode];
}

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
    self.navigationItem.titleView = sectionHeader;
    @weakify(self)
    // 选择城市
    UITapGestureRecognizer *cityTap = [[UITapGestureRecognizer alloc] init];
    [[cityTap rac_gestureSignal] subscribeNext:^(id x) {
        @strongify(self)
        [self.selectCityV show];
    }];
    [sectionHeader.citySelectV addGestureRecognizer:cityTap];
    self.navigationItem.titleView = sectionHeader;
    
    
    [self.selectCityV.subject subscribeNext:^(id  _Nullable x) {
        NSString *code = x[@"code"];
        NSString *name = x[@"name"];
        self.sectionHeader.citySelectV.titleLbl.text = name;
        self.countryRequest.code = code;
        self.wantRentPayRequest.cityCode = code;
        [self loadAllArea];
    }];
}

// 重置数据
- (void)resetData
{
    // 区域滚动到第一个cell
    dispatch_async(dispatch_get_main_queue(), ^{
         self.collectView.contentOffset=CGPointMake(0, 0);
    });
    
    // 已选重置为0
    [self caculeAllSelectNum];
}
#pragma mark ------- 加载数据

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
            self.countryRequest.code =  codeModel.code;
            self.wantRentPayRequest.cityCode = codeModel.code;
            [self loadAllArea];
        }
    }];
}


// 初始化
- (void)setup
{
    [self.wantRentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@232);
        make.bottom.safeEqualToBottom(self.view);
    }];
    
    @weakify(self)
    // 微信支付c成功后回调
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kWeiXinNotiFication_OrderOK object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        [XMHUD showSuccess:@"成功"];
        XMSuccessController *successVC = [XMSuccessController new];
        successVC.type = XMSuccessTypeRent;
        [self.navigationController pushViewController:successVC animated:YES];
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kWeiXinNotiFication_OrderCancel object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        [XMHUD showText:@"订单已取消"];
    }];
    
    
    // 改变单价
    [self.wantRentV.unitPriceTxt.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        [self caculeAllSelectPrice];
        // 单价
        self.wantRentPayRequest.price = x.floatValue;
    }];
    
    // 改变天数
    [self.wantRentV.totalDayTxt.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        [self caculeAllSelectPrice];
        // 租期
        self.wantRentPayRequest.days = x.integerValue;
    }];
    
    [self.topBaseV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.safeEqualToTop(self.view).offset(1);
        make.right.left.equalTo(self.view);
        make.height.equalTo(@53);
    }];
    
    [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.safeEqualToTop(self.view).offset(1);
        make.right.equalTo(self.view);
        make.height.equalTo(@53);
        make.left.equalTo(@86);
    }];
    [self.collectView registerClass:[XMAllAreaaCell class] forCellWithReuseIdentifier:allAreaaCell_identifer];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBaseV.mas_bottom);
        make.left.equalTo(self.view);
        make.width.equalTo(@(kScreenWidth));
        make.bottom.equalTo(self.wantRentV.mas_top).offset(-15);
    }];
    
    [self.allSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.centerY.equalTo(self.collectView);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    [self.allSelectBtn setTitle:@"全选" forState:UIControlStateNormal];
    [self.allSelectBtn setImage:kGetImage(@"business_all_normal") forState:UIControlStateNormal];
    [self.allSelectBtn setImage:kGetImage(@"business_all_select") forState:UIControlStateSelected];
    [self.allSelectBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:7];
    
    // 全选
    [[self.allSelectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [x setSelected:!x.isSelected];
        self.isAllSelect = x.isSelected;
        [self caculeAllSelectPrice];
        [self caculeAllSelectNum];
    }];
    
    // 支付并发布
    [[self.wantRentV.payAndPublishBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (!self.wantRentPayRequest.areaCodes.count) {
            [XMHUD showText:@"请先选择街道"];
            return ;
        }
        [self.view showLoading];
        [self.wantRentPayRequest startWithCompletion:^(__kindof XMWantRentPayRequest * _Nonnull request, NSError * _Nonnull error) {
            [self.view hideLoading];
            if (request.businessSuccess) {
                // 微信支付
                [XMPayUtil weiXinPay:request.businessData comple:^(BOOL success) {
                    
                }];
            }else{
                [XMHUD showFail:request.businessMessage];
            }

        }];
    }];
}

#pragma mark   ----------- 获取所有区

- (void)loadAllArea
{
    @weakify(self)
    [self.countryRequest startWithCompletion:^(__kindof XMCountyRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            XMAreaCommonModel *areaCommonModel = request.businessModel;
            self.dataSource = areaCommonModel.data;
            [self removeAllSubviewForScrollView];
            [self loadSource];
        }
        [self.collectView reloadData];
        // 默认第一个cell 被选中
        dispatch_async(dispatch_get_main_queue(), ^{
            self.selectRow = 0;
            [self collectionView:self.collectView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        });
    }];
}

// 切换新的城市删除所有子视图
- (void)removeAllSubviewForScrollView
{
    [self.allSelectBtn setSelected:NO];  // 初始化全选状态
    for (UIView *view in self.scrollView.subviews) {
        if ([view isKindOfClass:XMSelectStreetView.class]) {
            [view removeFromSuperview];
        }
    }
}

// 加载街道
- (void)loadSource
{
    for (int i = 0; i < self.dataSource.count; i++) {
        XMAreaItemModel *itemModel = self.dataSource[i];
        XMSelectStreetView *selectStreetView = [[XMSelectStreetView alloc] init];
        selectStreetView.collectionV = self.collectView;
        selectStreetView.itemModel = itemModel;
        [self.scrollView addSubview:selectStreetView];
        [selectStreetView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(i*kScreenWidth));
            make.width.equalTo(@(kScreenWidth));
            make.top.equalTo(self.scrollView.mas_top);
            make.height.equalTo(self.scrollView.mas_height);
        }];
        // 监听全选按钮
        [RACObserve(self, isAllSelect) subscribeNext:^(id  _Nullable x) {
            if ([x boolValue]) {
                [selectStreetView allReloadSelct];
            }else{
                [selectStreetView cancelAllSelect];
            }
        }];
        
        // 取消全选按钮
        [RACObserve(selectStreetView, cancelSelect) subscribeNext:^(id  _Nullable x) {
            if ([x boolValue]) {
                [self.allSelectBtn setSelected:NO];
            }
        }];
        
        // 选择街道回调
        @weakify(self)
        [selectStreetView.subject subscribeNext:^(id  _Nullable x) {
            @strongify(self)
            [self caculeAllSelectNum];
        }];
    }
    [self resetData];
}

#pragma mark ------- 计算
// 计算总数
- (NSInteger )caculeTotalNum
{
    NSInteger totalNum = 0;
    for (UIView *view in self.scrollView.subviews) {
        if ([view isKindOfClass:XMSelectStreetView.class]) {
            XMSelectStreetView *streetView = (XMSelectStreetView *)view;
            totalNum += streetView.dataSource.count;
        }
    }
    return totalNum;
}

// 计算所有选择的数量
- (void)caculeAllSelectNum
{
    NSInteger totalNum = 0;
    NSMutableArray *selectStreetCodeArrayM = [NSMutableArray array];
    for (UIView *view in self.scrollView.subviews) {
        if ([view isKindOfClass:XMSelectStreetView.class]) {
            XMSelectStreetView *streetView = (XMSelectStreetView *)view;
            for (XMStreetItemModel *itemModel in streetView.dataSource) {
                if (itemModel.select) {
                    totalNum++;
                    [selectStreetCodeArrayM addObject:itemModel.code];
                }
            }
        }
    }
    // 如果选中的数量等于总数量 全选被选中状态
    if (totalNum == [self caculeTotalNum] && totalNum!= 0) {
        [self.allSelectBtn setSelected:YES];
    }
    self.wantRentV.selectNumLbl.text = kFormat(@"%zd", totalNum);
    [self caculeAllSelectPrice];
    
    // 选择的街道
    self.wantRentPayRequest.areaCodes = selectStreetCodeArrayM;
    // 选择的街道总数
    self.wantRentPayRequest.count = totalNum;
}

// 计算所有选择的价格
- (void)caculeAllSelectPrice
{
    // 选择总数
    NSInteger totalNum = self.wantRentV.selectNumLbl.text.integerValue;
    CGFloat price = self.wantRentV.unitPriceTxt.text.floatValue;
    NSInteger day = self.wantRentV.totalDayTxt.text.integerValue;
    CGFloat totalPrice = totalNum *price*day;
    self.wantRentV.priceLbl.text = kFormat(@"%.2lf", totalPrice);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XMAllAreaaCell *areaCell = [collectionView dequeueReusableCellWithReuseIdentifier:allAreaaCell_identifer forIndexPath:indexPath];
    XMAreaItemModel *itemModel = self.dataSource[indexPath.row];
    if (indexPath.row == _selectRow) {
        itemModel.select = YES;
    }else{
        itemModel.select = NO;
    }
    areaCell.itemModel = itemModel;
    return areaCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _selectRow = indexPath.row;
    [collectionView reloadData];
    [self.scrollView setContentOffset:CGPointMake(indexPath.row * kScreenWidth, 0) animated:YES];
}

- (UIButton *)allSelectBtn
{
    if (!_allSelectBtn) {
        _allSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allSelectBtn setTitleColor:kHexColor(0xFF333333) forState:UIControlStateNormal];
        _allSelectBtn.titleLabel.font = kSysFont(14);
        [self.view addSubview:_allSelectBtn];
    }
    return _allSelectBtn;
}

- (UICollectionView *)collectView
{
    if (!_collectView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing = 20;
        flowLayout.itemSize = CGSizeMake(88, 35);
        _collectView  = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectView.delegate = self;
        _collectView.dataSource = self;
        _collectView.backgroundColor = UIColor.whiteColor;
        _collectView.alwaysBounceHorizontal = YES;
        _collectView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_collectView];
    }
    return _collectView;
}


- (XMWantRentBootomView *)wantRentV
{
    if (!_wantRentV) {
        _wantRentV = [XMWantRentBootomView new];
        [self.view addSubview:_wantRentV];
    }
    return _wantRentV;
}

- (UIView *)topBaseV
{
    if (!_topBaseV) {
        _topBaseV = [UIView new];
        _topBaseV.backgroundColor = UIColor.whiteColor;
        [self.view addSubview:_topBaseV];
    }
    return _topBaseV;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = UIColor.whiteColor;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollEnabled = NO;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}


- (XMSelectCityView *)selectCityV
{
    if (!_selectCityV) {
        _selectCityV = [[XMSelectCityView alloc] initWithFrame:kWindow.bounds];
        _selectCityV.level = XMLevelTwo;
    }
    return _selectCityV;
}

- (XMGetCityCodeRequest *)cityCodeRequest
{
    if (!_cityCodeRequest) {
        _cityCodeRequest = [XMGetCityCodeRequest request];
        _cityCodeRequest.cityName = self.localCity;
    }
    return _cityCodeRequest;
}

- (XMCountyRequest *)countryRequest
{
    if (!_countryRequest) {
        _countryRequest = [XMCountyRequest request];
    }
    return _countryRequest;
}

- (XMWantRentPayRequest *)wantRentPayRequest
{
    if (!_wantRentPayRequest) {
        _wantRentPayRequest = [XMWantRentPayRequest request];
    }
    return _wantRentPayRequest;
}





@end
