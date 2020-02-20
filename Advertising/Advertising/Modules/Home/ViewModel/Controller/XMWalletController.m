//
//  XMWalletController.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/17.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMWalletController.h"
#import "XMWalletView.h"
#import "XMWithdrawController.h"
#import "XMRechargeController.h"
#import "XMProfitController.h"
#import "XMGetUserInfo.h"

@interface XMWalletController()

@property(nonatomic, strong)XMWalletView *walletV;

@property(nonatomic, strong)XMGetUserInfoRequest *userInfoRequest;

@end

@implementation XMWalletController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    
}

// 初始化
- (void)setup
{
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"钱包";
    [self.walletV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.safeEqualToTop(self.view);
        make.bottom.safeEqualToBottom(self.view);
        make.left.right.equalTo(self.view);
    }];
    
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitle:@"收支明细" forState:UIControlStateNormal];
    [titleBtn setTitleColor:kHexColor(0xB1B1B1) forState:UIControlStateNormal];
    titleBtn.titleLabel.font = kSysFont(14);
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:titleBtn];
    self.navigationItem.rightBarButtonItem = barItem;
    // 收支明细
    @weakify(self)
    [[titleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        XMProfitController *profitVC = [XMProfitController new];
        [self.navigationController pushViewController:profitVC animated:YES];
    }];
    
    [[self.walletV.rechargeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        XMRechargeController *rechargeVC = [XMRechargeController new];
        
        [self.navigationController pushViewController:rechargeVC animated:YES];
    }];
    
    [[self.walletV.withdrawBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        XMWithdrawController *widthdrawVC = [XMWithdrawController new];
        [self.navigationController pushViewController:widthdrawVC animated:YES];
    }];
}

// 加载数据
- (void)loadData
{
//    [self.view showLoading];
    // 获取用户余额
    @weakify(self)
    [self.userInfoRequest startWithCompletion:^(__kindof XMGetUserInfoRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
//        [self.view hideLoading];
        XMCurrentUserInfo *userInfo = request.businessModel;
        self.walletV.balanceLbl.text = kFormat(@"%.2lf", userInfo.balance);
    }];
}



- (XMWalletView *)walletV
{
    if (!_walletV) {
        _walletV = [XMWalletView new];
        [self.view addSubview:_walletV];
    }
    return _walletV;
}

- (XMGetUserInfoRequest *)userInfoRequest
{
    if (!_userInfoRequest) {
        _userInfoRequest = [XMGetUserInfoRequest request];
    }
    return _userInfoRequest;
}


@end
