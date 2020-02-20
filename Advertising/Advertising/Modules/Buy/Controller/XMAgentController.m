//
//  XMAgentController.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/29.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMAgentController.h"
#import "XMAgentView.h"
#import "XMAgentRequest.h"
#import "XMPayWayView.h"
#import "XMHomeRequest.h"
#import "XMHomeMsgModel.h"
#import <AlipaySDK/AlipaySDK.h>
#import "XMBuyStateController.h"
#import "XMPayUtil.h"
#import "XMBuyStateController.h"
#import "XMGetUserInfo.h"
#import "XMBuyLandlordRequest.h"
#import "XMSuccessController.h"

@interface XMAgentController ()

@property(nonatomic, strong)XMAgentView *agentV;

@property(nonatomic, strong)XMAgentRequest *aLiPayRequest;

@property(nonatomic, strong)XMPayWayView *payWayV;

@property(nonatomic, strong)XMHomeMsgRequest *msgRequest; // 头部数据

@property(nonatomic, strong)XMHomeMsgModel *msgModel;  // 信息model

@property(nonatomic, strong)XMAgentWeiXinPayRequest *wxPayRequest;  // 微信支付

@property(nonatomic, strong)XMGetUserInfoRequest *userInfoRequest;  // 用户信息
@property(nonatomic, strong)XMWeixinCancelOrderRequest *cancelOrderRequest; // 取消订单

@end

@implementation XMAgentController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getUserInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    self.navigationItem.title = @"会员授权";
    [self loadData];
    [self getUserInfo];
    
    @weakify(self)
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kWeiXinNotiFication_OrderOK object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        // 读取一下用户信息
        XMSuccessController *successVC = [XMSuccessController new];
        successVC.type = XMSuccessTypePayAgent;
        [self.navigationController pushViewController:successVC animated:YES];
    }];
    
    //  取消支付
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kWeiXinNotiFication_OrderCancel object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        self.cancelOrderRequest.orderId = [kLoginManager.uid integerValue];
        self.cancelOrderRequest.type = 0;
        [self.cancelOrderRequest startWithCompletion:^(__kindof XMWeixinCancelOrderRequest * _Nonnull request, NSError * _Nonnull error) {
            if (request.businessSuccess) {
                [XMHUD showText:@"已取消订单"];
            }else{
                [XMHUD showText:request.businessMessage];
            }
        }];
    }];
}

- (void)setup
{
    [self.agentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.safeEqualToTop(self.view);
        make.bottom.safeEqualToBottom(self.view);;
    }];
    
    @weakify(self)
    // 选择支付方式回调
    [self.payWayV.selectBlockSub subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        NSInteger index = [x integerValue];
        [self loaddataWith:index];
    }];
    
    [[self.agentV.agentBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
         self.payWayV.payType = PageAgent;
        self.payWayV.numLbl.text = kFormat(@"￥%.2lf", self.msgModel.vipPrice);
        [self.payWayV show];
    }];
}

- (void)loadData
{
    [self.view showLoading];
    @weakify(self)
    // 信息数据
    [self.msgRequest startWithCompletion:^(__kindof XMHomeMsgRequest * _Nonnull request, NSError * _Nonnull error) {
        [self.view hideLoading];
        @strongify(self)
        if (request.businessSuccess) {
            self.msgModel = request.businessModel;
             self.agentV.currentMoneyLbl.text = kFormat(@"￥%.2lf", self.msgModel.vipPrice);
        }
    }];
}

// 获取用户信息 用来判断该用户是否是代理
- (void)getUserInfo
{
    @weakify(self)
    [self.userInfoRequest startWithCompletion:^(__kindof XMGetUserInfoRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        [self.agentV.agentBtn setEnabled:YES];
        if (request.businessSuccess) {
            XMCurrentUserInfo *info = request.businessModel;
            self.agentV.agentBtn.enabled = !info.isVip;
            if (!self.agentV.agentBtn.enabled) {
                [self.agentV.agentBtn setTitle:@"已是会员" forState:UIControlStateNormal];
                [self.agentV.agentBtn setBackgroundColor:kHexColor(0x999999)];
            }
        }
    }];
}

#pragma mark  ------------------   第三方支付
// 唤起第三方支付
- (void)weakThreePayWith:(NSString *)order and:(NSInteger)type
{
    if (type == 3) {
        // 唤起支付宝
        [[AlipaySDK defaultService] payOrder:order fromScheme:@"xiangmu_aliPay" callback:^(NSDictionary *resultDic) {
            NSNumber *resultStatus = resultDic[@"resultStatus"];
            if ([resultStatus integerValue] ==  9000) {
            }else{
                
            }
        }];
    }
}

// 加载数据
- (void)loaddataWith:(NSInteger)type
{
    if (type == 3) {
        [XMHUD showText:@"暂不支持该支付方式"];
    }else if(type == 2){
        [self.wxPayRequest startWithCompletion:^(__kindof XMAgentWeiXinPayRequest * _Nonnull request, NSError * _Nonnull error) {
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
        [XMHUD showText:@"暂不支持该支付方式"];
    }
}

- (XMAgentView *)agentV
{
    if (!_agentV) {
        _agentV = [[XMAgentView alloc] init];
        [self.view addSubview:_agentV];
    }
    return _agentV;
}

- (XMAgentRequest *)agentRequest
{
    if (!_aLiPayRequest) {
        _aLiPayRequest = [XMAgentRequest request];
    }
    return _aLiPayRequest;
}

- (XMPayWayView *)payWayV
{
    if (!_payWayV) {
        _payWayV = [[XMPayWayView alloc] initWithFrame:kWindow.bounds];
    }
    return _payWayV;
}

- (XMHomeMsgRequest *)msgRequest
{
    if (!_msgRequest) {
        _msgRequest = [XMHomeMsgRequest request];
    }
    return _msgRequest;
}

- (XMAgentWeiXinPayRequest *)wxPayRequest
{
    if (!_wxPayRequest) {
        _wxPayRequest = [XMAgentWeiXinPayRequest request];
    }
    return _wxPayRequest;
}

- (XMGetUserInfoRequest *)userInfoRequest
{
    if (!_userInfoRequest) {
        _userInfoRequest = [XMGetUserInfoRequest request];
    }
    return _userInfoRequest;
}

- (XMWeixinCancelOrderRequest *)cancelOrderRequest
{
    if (!_cancelOrderRequest) {
        _cancelOrderRequest = [XMWeixinCancelOrderRequest request];
    }
    return _cancelOrderRequest;
}

@end
