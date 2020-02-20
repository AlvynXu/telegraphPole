//
//  XMGrabLandlordController.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/27.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMGrabLandlordController.h"
#import "XMLandlordBuyCell.h"
#import "XMPayWayView.h"
#import "XMLanlordSectionView.h"
#import "XMMoneyNumCell.h"
#import "XMSelectCityView.h"
#import "XMSaleStateView.h"
#import "UIButton+ImageTitleSpacing.h"
#import <AlipaySDK/AlipaySDK.h>
#import "XMOrder.h"
#import "XMBuyLandlordRequest.h"
#import "XMHomeRequest.h"
#import "XMHomeMsgModel.h"
#import "XMBuyBoothRequest.h"
#import "XMHomeRequest.h"
#import "YTKBatchRequest.h"
#import "LYLocationUtil.h"
#import "XMBuyStateController.h"
#import "XMLanlordRecordController.h"
#import "XMBoothRecordController.h"
#import "XMBuyLandlordRequest.h"
#import "XMPayUtil.h"
#import "XMSuccessController.h"


@interface XMGrabLandlordController ()<UIScrollViewDelegate>

@property(nonatomic, strong)NSArray *dataSource;

@property(nonatomic, strong)XMPayWayView *payWayV;

@property(nonatomic, assign)CGFloat headerFloat;

@property(nonatomic, strong)XMSelectCityView *selectCityV;

@property(nonatomic, strong)XMSaleStateView *stateV;

@property(nonatomic, strong)XMLanlordSectionView *sectionHeader;

@property(nonatomic, strong)UIView *loadDownView;


// 获取默认城市 编码
@property(nonatomic, strong)XMGetCityCodeRequest *cityCodeRequest;


///  地主信息
@property(nonatomic, strong)XMLandlordListRequest *getLanlordRequest; // 获取地主列表
@property(nonatomic, strong)XMHomeLandlordRequest *landlordInfoRequest;  // 获取地主信息
@property(nonatomic, strong)XMHomeBootModel *landlordModel;  // 地主信息模型
@property(nonatomic, strong)XMGenerateOrderRequest *landlordOrderRequest; // 生成街道订单


// 展位-----》获取展位信息
@property(nonatomic, strong)XMBoothDataRequest *boothDataRequest;  // 获取展位列表
@property(nonatomic, strong)XMHomeRequest *boothInfoRequest; // 展位信息
@property(nonatomic, strong)XMGenerateBoothOrderRequest *boothOrderRequest; //生成展位订单
@property(nonatomic, strong)XMBoothFreeRequest *freeRequest;


//  用来跳转到成功状态页面
@property(nonatomic, strong)XMLandlordRecordsModel *selectLanlordModel;  // 选中支付的地主模型
@property(nonatomic, strong)XMBoothRecordsModel *selectBoothModel;  // 选中支付的展位模型


//  ---------------  微信支付
@property(nonatomic, strong)XMWeixinOrderStreetRequest *wxStrretOrderRequest; // 生成街道订单

@property(nonatomic, strong)XMWeixinOrderBoothRequest *wxBoothOrderRequest;  // 生成展位订单

@property(nonatomic, strong)XMWeixinCancelOrderRequest *cancelOrderRequest; // 取消订单


@end

#define kCityLocalNotivation = "city_local_notivation"

static NSString *const landlordCellId = @"landlordCellId";
static NSString *const moneyNumCellId = @"moneyNumCellId";

@implementation XMGrabLandlordController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_isfirst) {
        self.isfirst = NO;
    }else{
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    // 地位获取通知
    [self getNotivation];
    [self loadDefaultCityCode];
    // 添加刷新
    [self addRefresh];
    
    
    // 微信支付c成功后回调
    @weakify(self)
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kWeiXinNotiFication_OrderOK object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        [XMHUD showSuccess:@"购买成功"];
        if (self.isLandlord) {
            XMSuccessController *successVC = [XMSuccessController new];
            successVC.type = XMSuccessTypePayLanlord;
            [self.navigationController pushViewController:successVC animated:YES];
//            // 地主购买成功跳转到我的地主地主
        }else{
            XMSuccessController *successVC = [XMSuccessController new];
            successVC.type = XMSuccessTypePayBooth;
            [self.navigationController pushViewController:successVC animated:YES];
        }
    }];
    
    //  取消支付
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kWeiXinNotiFication_OrderCancel object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        self.cancelOrderRequest.type = self.isLandlord?2:1;
        self.cancelOrderRequest.orderId = self.isLandlord?self.wxStrretOrderRequest.streetId:self.wxBoothOrderRequest.boothId;
        [self.cancelOrderRequest startWithCompletion:^(__kindof XMWeixinCancelOrderRequest * _Nonnull request, NSError * _Nonnull error) {
            if (request.businessSuccess) {
                [XMHUD showText:@"订单已取消"];
            }else{
                [XMHUD showText:request.businessMessage];
            }
        }];
    }];
}

// 添加刷新
- (void)addRefresh
{
    @weakify(self)
    [self.tableView addHeaderWithCallback:^{
        @strongify(self)
        if (self.isLandlord) {
            self.getLanlordRequest.needRefresh = YES;
            [self sendRequest:NO];
        }else{
            self.boothDataRequest.needRefresh = YES;
            [self sendRequest:NO];
        }
    }];
    [self.tableView addFooterWithCallback:^{
        @strongify(self)
        if (self.isLandlord) {
            self.getLanlordRequest.needRefresh = NO;
            [self loadDataDefault:NO];
        }else{
            self.boothDataRequest.needRefresh = NO;
            [self loadDataDefaultBooth:NO];
        }
    }];
}
// 发送请求
- (void)sendRequest:(BOOL)isShow
{
    if (_isLandlord) {
        // 获取地主默认城市列表
        [self loadDataDefault:isShow];
        // 获取地主信息
        [self getLandInfoData:isShow];
    }else{
        [self loadDataDefaultBooth:isShow];
        [self getBoothInfo:isShow];
    }
}

- (void)setup
{
    self.navigationItem.title = _isLandlord ? @"地主交易" : @"展位交易";
    self.localCity = [LYLocationUtil getLocalCity];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[XMLandlordBuyCell class] forCellReuseIdentifier:landlordCellId];
    [self.tableView registerClass:[XMMoneyNumCell class] forCellReuseIdentifier:moneyNumCellId];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.safeEqualToBottom(self.view);
        make.left.right.equalTo(self.view);
        make.top.safeEqualToTop(self.view);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 20);
    [btn setTitle:_isLandlord?@"我的街道":@"我的展位" forState:UIControlStateNormal];
    [btn setTitleColor:kMainColor forState:UIControlStateNormal];
    btn.titleLabel.font = kSysFont(13);
//    [btn setImage:kGetImage(@"record") forState:UIControlStateNormal];
//    [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    @weakify(self)
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        self.isfirst = YES;
        if (self.isLandlord) {
            XMLanlordRecordController *landlordRecordVC = [XMLanlordRecordController new];
            [self.navigationController pushViewController:landlordRecordVC animated:YES];
        }else{
            XMBoothRecordController *boothRecordVC = [XMBoothRecordController new];
            [self.navigationController pushViewController:boothRecordVC animated:YES];
        }
    }];
    // 选择支付方式回调
    [self.payWayV.selectBlockSub subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        if (self.isLandlord) {
            // 地主
            [self generateOrderLandlordWith:[x integerValue]];
        }else{
            // 展位
            [self generateBoothOrderWith:[x integerValue]];
        }
    }];
    // 选择城市回调
    [self.selectCityV.subject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        NSDictionary *dict = (NSDictionary *)x;
        NSString *code = dict[@"code"];
        NSString *name = dict[@"name"];
        NSInteger index = [dict[@"index"] integerValue];
            self.localCity = name;
            if (self.isLandlord) {
                self.getLanlordRequest.areaCode = code;
                self.getLanlordRequest.areaType = labs(index - 4);
            }else{
                self.boothDataRequest.areaCode = code;
                self.boothDataRequest.areaType = labs(index - 4);
            }
            [self.tableView.mj_header beginRefreshing];
    }];
}

#pragma mark  ------------------   第三方支付
// 唤起第三方支付
- (void)weakThreePayWith:(NSString *)order and:(NSInteger)type
{
    if (type == 3) {
        // 唤起支付宝
//        [[AlipaySDK defaultService] payOrder:order fromScheme:@"xiangmu_aliPay" callback:^(NSDictionary *resultDic) {
//            NSNumber *resultStatus = resultDic[@"resultStatus"];
//            if ([resultStatus integerValue] ==  9000) {
//                [self goSuccessState];
//                NSLog(@"支付成功");
//            }else{
//
//            }
//        }];
    }
    if (type == 2) {
        // 唤起微信
//        [XMPayUtil weiXinPay:nil];
    }
    if (type == 1) {
        // 余额支付
    }
}

- (void)goSuccessState:(NSInteger)Id
{
    XMBuyStateController *buyStateVC = [XMBuyStateController new];
    buyStateVC.Id = Id;
    buyStateVC.page = self.isLandlord ? PageLanlord : PageBoot;
    [self.navigationController pushViewController:buyStateVC animated:YES];
}

#pragma mark  ------------------   定位
// 通知：获取定位后发送请求
- (void)getNotivation
{
    @weakify(self)
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"city_local_notivation" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        self.localCity = x.userInfo[@"local"];
        self.cityCodeRequest.cityName = self.localCity;
        [self loadDefaultCityCode];
    }];
}
// 获取默认城市编码
- (void)loadDefaultCityCode
{
    if ([self.localCity isEmpty]) {
        [self.tableView showLoadigWith:@"正在获取定位...."];
        return;
    }else{
        [self.tableView showLoading];
    }
    @weakify(self)
    [self.cityCodeRequest startWithCompletion:^(__kindof XMGetCityCodeRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        // 成功之后 获取默认定位列表
        if (request.businessSuccess) {
            // 获取当前定位城市编码
            XMCityCodeModel *codeModel = request.businessModel;
            if (self.isLandlord) {
                self.getLanlordRequest.areaCode = codeModel.code;
                self.getLanlordRequest.areaType = 3;  // 默认市级
                self.getLanlordRequest.needRefresh = YES;
            }else{
                self.boothDataRequest.areaCode = codeModel.code;
                self.boothDataRequest.areaType = 3;   // 默认市级
                self.getLanlordRequest.needRefresh = YES;
            }
            [self sendRequest:YES];
        }
    }];
}

#pragma mark  ------------------   展位
// 生成展位订单
- (void)generateBoothOrderWith:(NSInteger)type
{
    if (type == 3) {
//        @weakify(self)
//        [self.view showLoading];
//        [self.boothOrderRequest startWithCompletion:^(__kindof XMGenerateBoothOrderRequest * _Nonnull request, NSError * _Nonnull error) {
//            @strongify(self)
//            [self.view hideLoading];
//            if (request.businessSuccess) {
//                // 唤起第三方支付
//                XMBuyBoothOrder *order = request.businessModel;
//                [self weakThreePayWith:order.orderInfo and:type];
//            }
//        }];
    }else if (type == 2){
        // 微信
        [self.view showLoading];
        [self.wxBoothOrderRequest startWithCompletion:^(__kindof XMWeixinOrderBoothRequest * _Nonnull request, NSError * _Nonnull error) {
            [self.view hideLoading];
            if (request.businessSuccess) {
                [XMPayUtil weiXinPay:request.businessData comple:^(BOOL success) {
                    if (success) {
                        
                    }
                }];
            }else{
                [XMHUD showText:request.businessMessage];
            }
        }];
        
    }else{
        // 余额
        
    }
    
}

// 展位 获取默认定位列表
- (void)loadDataDefaultBooth:(BOOL)isShow
{
    @weakify(self)
    if ([self.boothDataRequest.areaCode isEmpty] || !self.boothDataRequest.areaCode) {
        return;
    }
    [self.boothDataRequest startWithCompletion:^(__kindof XMBoothDataRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            self.dataSource = request.businessModelArray;
        }
        [self.tableView hideLoadingWithRequest:request rect:CGRectMake(0, kScreenHeight - kScaleH(370), kScreenWidth, kScaleH(200))];
    }];
}

// 加载展位信息
- (void)getBoothInfo:(BOOL)isShow
{
    @weakify(self)
    [self.boothInfoRequest startWithCompletion:^(__kindof XMHomeRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            XMHomeBootModel *bootModel = request.businessModel;
            self.landlordModel = bootModel;
            [self.tableView reloadData];
        }
    }];
}


#pragma mark  --------------  地主
// 生成街道订单
- (void)generateOrderLandlordWith:(NSInteger)type
{
    if (type == 3) {
//        [self.view showLoading];
//        @weakify(self)
//        [self.landlordOrderRequest startWithCompletion:^(__kindof XMGenerateOrderRequest * _Nonnull request, NSError * _Nonnull error) {
//            @strongify(self)
//            [self.view hideLoading];
//            if (request.businessSuccess) {
//                XMBuyOrder *order = request.businessModel;
//                [self weakThreePayWith:order.data and:type];
//            }else{
//                [XMHUD showFail:request.businessMessage];
//            }
//        }];
    }else if (type == 2) {
        // 微信支付
        [self.view showLoading];
        [self.wxStrretOrderRequest startWithCompletion:^(__kindof XMWeixinOrderStreetRequest * _Nonnull request, NSError * _Nonnull error) {
            [self.view hideLoading];
            if (request.businessSuccess) {
                [XMPayUtil weiXinPay:request.businessData comple:^(BOOL success) {
                    if (success) {
                        
                    }
                }];
            }else{
                [XMHUD showText:request.businessMessage];
            }
        }];
    }else{
        
    }
}


// 地主 获取默认定位列表
-(void)loadDataDefault:(BOOL)isShow
{
    if ([self.getLanlordRequest.areaCode isEmpty] || !self.getLanlordRequest.areaCode) {
        return;
    }
    @weakify(self)
    [self.getLanlordRequest startWithCompletion:^(__kindof XMLandlordListRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            self.dataSource = request.businessModelArray;
        }
        [self.tableView hideLoadingWithRequest:request rect:CGRectMake(0, kScreenHeight - kScaleH(300), kScreenWidth, kScaleH(200))];
    }];
}

// 加载地主信息
- (void)getLandInfoData:(BOOL)isShow
{
    @weakify(self)
    [self.landlordInfoRequest startWithCompletion:^(__kindof XMHomeLandlordRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            XMHomeBootModel *bootModel = request.businessModel;
            self.landlordModel = bootModel;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark  -----  UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取 navigationBar的高度和status的高度
    CGFloat navigationBarAndStatusBarHeight = self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
//    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    
    CGFloat floatPoint = 213 - scrollView.contentOffset.y;
    if (floatPoint < 0) {
        // 头部已经悬浮在顶部
        _headerFloat = navigationBarAndStatusBarHeight + 60 - 9;
    }else{
        _headerFloat = navigationBarAndStatusBarHeight + floatPoint + 60 - 9;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.0;
    }
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return self.dataSource.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    XMLanlordSectionView *sectionHeader =  [[XMLanlordSectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    self.sectionHeader = sectionHeader;
    @weakify(self)
    // 选择城市
    UITapGestureRecognizer *cityTap = [[UITapGestureRecognizer alloc] init];
    [[cityTap rac_gestureSignal] subscribeNext:^(id x) {
        @strongify(self)
        
        [self.selectCityV show];

    }];
    // 选择状态
    UITapGestureRecognizer *stateTap = [[UITapGestureRecognizer alloc] init];
    [[stateTap rac_gestureSignal] subscribeNext:^(id x) {
        @strongify(self)
        [self.stateV show];
        
    }];
    // 城市和状态
    sectionHeader.citySelectV.titleLbl.text = self.localCity;
    [sectionHeader.stateSelectV addGestureRecognizer:stateTap];
    [sectionHeader.citySelectV addGestureRecognizer:cityTap];
    
    return sectionHeader;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        XMMoneyNumCell *cell = [tableView dequeueReusableCellWithIdentifier:moneyNumCellId forIndexPath:indexPath];
        cell.isLandlord = self.isLandlord;
        cell.landlordModle = self.landlordModel;
        return cell;
    }else{
        XMLandlordBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:landlordCellId forIndexPath:indexPath];
        if (_isLandlord) {
            // 地主
            cell.landlordModel = self.dataSource[indexPath.row];
        }else{
            // 展位
            cell.boothModel = self.dataSource[indexPath.row];
        }
        // 点击购买
        [cell.buyBtn addTarget:self action:@selector(buyClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}

- (void)buyClick:(UIButton *)x
{
    UIButton* button = (UIButton*) x;
    UITableViewCell *cell = (UITableViewCell*)button.superview;
    NSIndexPath *currentIndexPath = [self.tableView indexPathForCell:cell];
    // 地主
    if (self.isLandlord) {
        self.payWayV.payType = PageLanlord;
        XMLandlordRecordsModel *recordModel = self.dataSource[currentIndexPath.row];
        self.selectLanlordModel = recordModel;
        self.landlordOrderRequest.streetId = recordModel.Id;  // 支付宝
        self.wxStrretOrderRequest.streetId = recordModel.Id;  // 微信
        self.payWayV.Id = recordModel.Id;  // 获取订单信息
        self.payWayV.numLbl.text = kFormat(@"￥%.2f", recordModel.price);
        [self.payWayV show];
    }else{
        // 地主展位免费解锁
        XMBoothRecordsModel *boothModel = self.dataSource[currentIndexPath.row];
        if (boothModel.saved) {
            self.freeRequest.boothId = boothModel.Id;
            [self.freeRequest startWithCompletion:^(__kindof XMBaseRequest * _Nonnull request, NSError * _Nonnull error) {
                if (request.businessSuccess) {
                    // 免费解锁成功  之后跳转到列表
                    [XMHUD showSuccess:@"解锁成功"];
                    XMBoothRecordController *bootVC = [XMBoothRecordController new];
                    [self.navigationController pushViewController:bootVC animated:YES];
                    
                }else{
                    [XMHUD showFail:request.businessMessage];
                }
            }];
        }else{
            // 普通展位购买
            self.payWayV.payType = PageBoot;
            self.selectBoothModel = boothModel;
            self.boothOrderRequest.boothId = boothModel.Id;  // 支付宝
            self.wxBoothOrderRequest.boothId = boothModel.Id;  // 微信
            self.payWayV.Id = boothModel.Id;  // 获取订单信息
            self.payWayV.numLbl.text = kFormat(@"￥%.2lf", boothModel.price);
            [self.payWayV show];
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 213;
    }
    return 95;
}


- (XMPayWayView *)payWayV
{
    if (!_payWayV) {
        _payWayV = [[XMPayWayView alloc] initWithFrame:kWindow.bounds];;
    }
    return _payWayV;
}

- (XMSelectCityView *)selectCityV
{
    if (!_selectCityV) {
        _selectCityV = [[XMSelectCityView alloc] initWithFrame:kWindow.bounds];
        _selectCityV.level = self.isLandlord?XMLevelThree:XMLevelFour;
    }
    return _selectCityV;
}

- (XMSaleStateView *)stateV
{
    if (!_stateV) {
        _stateV = [[XMSaleStateView alloc] initWithFrame:kWindow.bounds];
    }
    return _stateV;
}

- (XMLandlordListRequest *)getLanlordRequest
{
    if (!_getLanlordRequest) {
        _getLanlordRequest = [XMLandlordListRequest request];
//        _getLanlordRequest.areaType = 2;  // 默认
        _getLanlordRequest.type = 0;
    }
    return _getLanlordRequest;
}

- (XMHomeLandlordRequest *)landlordInfoRequest
{
    if (!_landlordInfoRequest) {
        _landlordInfoRequest = [XMHomeLandlordRequest request];
    }
    return _landlordInfoRequest;
}

- (XMGetCityCodeRequest *)cityCodeRequest
{
    if (!_cityCodeRequest) {
        _cityCodeRequest = [XMGetCityCodeRequest request];
        _cityCodeRequest.cityName = self.localCity;
    }
    return _cityCodeRequest;
}

- (XMGenerateOrderRequest *)landlordOrderRequest
{
    if (!_landlordOrderRequest) {
        _landlordOrderRequest = [XMGenerateOrderRequest request];
    }
    return _landlordOrderRequest;
}


- (XMBoothDataRequest *)boothDataRequest
{
    if (!_boothDataRequest) {
        _boothDataRequest = [XMBoothDataRequest request];
//        _boothDataRequest.areaType = 2;   // 默认y区域类型
        _boothDataRequest.type = 0;  //默认状态
    }
    return _boothDataRequest;
}

- (XMHomeRequest *)boothInfoRequest
{
    if (!_boothInfoRequest) {
        _boothInfoRequest = [XMHomeRequest request];
    }
    return _boothInfoRequest;
}

- (XMGenerateBoothOrderRequest *)boothOrderRequest
{
    if (!_boothOrderRequest) {
        _boothOrderRequest = [XMGenerateBoothOrderRequest request];
    }
    return _boothOrderRequest;
}

- (XMWeixinOrderBoothRequest *)wxBoothOrderRequest
{
    if (!_wxBoothOrderRequest) {
        _wxBoothOrderRequest = [XMWeixinOrderBoothRequest request];
    }
    return _wxBoothOrderRequest;
}

- (XMWeixinOrderStreetRequest *)wxStrretOrderRequest
{
    if (!_wxStrretOrderRequest) {
        _wxStrretOrderRequest = [XMWeixinOrderStreetRequest request];
    }
    return _wxStrretOrderRequest;
}

- (XMBoothFreeRequest *)freeRequest
{
    if (!_freeRequest) {
        _freeRequest = [XMBoothFreeRequest request];
    }
    return _freeRequest;
}

- (XMWeixinCancelOrderRequest *)cancelOrderRequest
{
    if (!_cancelOrderRequest) {
        _cancelOrderRequest = [XMWeixinCancelOrderRequest request];
    }
    return _cancelOrderRequest;
}




- (void)dealloc
{
    NSLog(@"================");
}


@end
