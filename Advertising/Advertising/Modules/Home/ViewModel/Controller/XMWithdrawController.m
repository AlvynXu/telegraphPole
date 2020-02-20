//
//  XMRechargeController.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/17.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMWithdrawController.h"
#import "XMWithdrawView.h"
#import "XMWalletRequest.h"
#import "XMGetUserInfo.h"
#import "XMProfitController.h"

@interface XMWithdrawController ()<UITextFieldDelegate>

@property(nonatomic, strong)XMWithdrawView *rechargeV;

@property(nonatomic, strong)XMWithdrawRequest *chargeRequest;

@property(nonatomic, strong)XMGetUserInfoRequest *userInfoRequest;

@property(nonatomic, strong)XMWithdrawLimitRequest *limitNumRequest; // 限制

@property(nonatomic, strong)XMMoneyModel *moneyModel;  //金额

@end

@implementation XMWithdrawController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self loadData];
}

// 初始化
- (void)setup
{
    self.navigationItem.title = @"提现";
    
    self.view.backgroundColor = UIColor.whiteColor;
    // 历史收益
    @weakify(self)
    [self.rechargeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.safeEqualToTop(self.view);
        make.bottom.safeEqualToBottom(self.view);
        make.left.right.equalTo(self.view);
    }];
    self.rechargeV.numTxt.delegate = self;
    // 提现
    [[self.rechargeV.rechargeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if ([self.rechargeV.numTxt.text isEmpty]) {
            [XMHUD showText:@"请输入提现金额"];
            return;
        }
        if (self.rechargeV.numTxt.text.floatValue > self.moneyModel.max || self.rechargeV.numTxt.text.floatValue<self.moneyModel.min ) {
            [XMHUD showText:kFormat(@"提现金额在%.2lf~%.2lf之间", self.moneyModel.min, self.moneyModel.max)];
            return;
        }
        NSString *subNum = self.rechargeV.numTxt.text;
        if ([self.rechargeV.numTxt.text hasPrefix:@"0"] && self.rechargeV.numTxt.text.length > 1) {
            subNum = [self.rechargeV.numTxt.text substringFromIndex:1];
        }
        
        // 提现
        NSDecimalNumber *decimalNumber = [[NSDecimalNumber alloc] initWithString:subNum];
        self.chargeRequest.amount = decimalNumber;
        [self.view showLoading];
        [self.rechargeV.rechargeBtn setEnabled:NO];
        [self.chargeRequest startWithCompletion:^(__kindof XMWithdrawRequest * _Nonnull request, NSError * _Nonnull error) {
            @strongify(self)
            [self.rechargeV.rechargeBtn setEnabled:YES];
            [self.view hideLoading];
            if (request.businessSuccess) {
                [XMHUD showSuccess:@"提现成功"];
                // 提现成功 清空
                self.rechargeV.numTxt.text=@"";
                // 刷新余额
                [self loadData];
                XMProfitController *profitVC = [XMProfitController new];
                [self.navigationController pushViewController:profitVC animated:YES];
                
            }else{
                [XMHUD showFail:request.businessMessage];
            }
        }];
    }];
    
    // 全部提出
    [[self.rechargeV.allRechargeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
       @strongify(self)
       XMCurrentUserInfo *userInfo = self.userInfoRequest.businessModel;
        self.rechargeV.numTxt.text = kFormat(@"%.2lf", userInfo.balance);
    }];
}

#pragma mark -------- 文本框代理校验金额

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (range.length >= 1) { // 删除数据, 都允许删除
        return YES;
    }
    if (![self checkDecimal:[textField.text stringByAppendingString:string]]){
        
        if (textField.text.length > 0 && [string isEqualToString:@"."] && ![textField.text containsString:@"."]) {
            return YES;
        }
        
        return NO;
        
    }
    return YES;
}


#pragma mark - 正则表达式

/**
 判断是否是两位小数
 
 @param str 字符串
 @return yes/no
 */
- (BOOL)checkDecimal:(NSString *)str
{
    NSString *regex = @"^[0-9]+(\\.[0-9]{1,2})?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if([pred evaluateWithObject: str])
    {
        return YES;
    }else{
        return NO;
    }
}
// 加载数据
- (void)loadData
{
    [self.view showLoading];
    // 获取用户余额
    @weakify(self)
    [self.userInfoRequest startWithCompletion:^(__kindof XMGetUserInfoRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        [self.view hideLoading];
        XMCurrentUserInfo *userInfo = request.businessModel;
        self.rechargeV.canMoneyLbl.text = kFormat(@"可提现金额：%.2lf", userInfo.balance);
    }];
    
    // 获取限制最大金额
    [self.limitNumRequest startWithCompletion:^(__kindof XMBaseRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            self.moneyModel = request.businessModel;
            self.rechargeV.moneyModel = self.moneyModel;
        }
    }];
}



- (XMWithdrawView *)rechargeV
{
    if (!_rechargeV) {
        _rechargeV = [XMWithdrawView new];
        [self.view addSubview:_rechargeV];
    }
    return _rechargeV;
}

- (XMWithdrawRequest *)chargeRequest
{
    if (!_chargeRequest) {
        _chargeRequest = [XMWithdrawRequest request];
    }
    return _chargeRequest;
}


- (XMGetUserInfoRequest *)userInfoRequest
{
    if (!_userInfoRequest) {
        _userInfoRequest = [XMGetUserInfoRequest request];
    }
    return _userInfoRequest;
}

- (XMWithdrawLimitRequest *)limitNumRequest
{
    if (!_limitNumRequest) {
        _limitNumRequest = [XMWithdrawLimitRequest request];
    }
    return _limitNumRequest;
}


@end
