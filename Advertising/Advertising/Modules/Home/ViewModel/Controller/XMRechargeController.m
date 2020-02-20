//
//  XMRechargeController.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/17.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMRechargeController.h"
#import "XMRechargeView.h"
#import "XMWalletRequest.h"
#import "XMPayUtil.h"
#import "XMProfitController.h"

@interface XMRechargeController ()<UITextFieldDelegate>

@property(nonatomic, strong)XMRechargeView *rechargeV;

@property(nonatomic, strong)XMRechargeRequest *rechargeRequest;

@end

@implementation XMRechargeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    // 微信支付c成功后回调
    @weakify(self)
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kWeiXinNotiFication_OrderOK object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        [XMHUD showSuccess:@"充值成功"];
        XMProfitController *profitVC = [XMProfitController new];
        [self.navigationController pushViewController:profitVC animated:YES];
    }];
}

// 初始化
- (void)setup
{
    self.navigationItem.title = @"充值";
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    @weakify(self)
    [self.rechargeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.safeEqualToTop(self.view);
        make.bottom.safeEqualToBottom(self.view);
        make.left.right.equalTo(self.view);
    }];
    
    
    self.rechargeV.numTxt.delegate = self;
    
    // 充值
    [[self.rechargeV.rechargeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        
        if ([self.rechargeV.numTxt.text isEmpty]) {
            [XMHUD showText:@"请输入金额"];
            return ;
        }
        if ([self.rechargeV.numTxt.text floatValue]<=0) {
            [XMHUD showText:@"金额不能为0"];
            return ;
        }
        if ([self.rechargeV.numTxt.text floatValue] > 50000) {
            [XMHUD showText:@"单笔充值最高金额为5万元"];
            return ;
        }
        NSDecimalNumber *decimalNumber = [[NSDecimalNumber alloc] initWithString:self.rechargeV.numTxt.text];
        self.rechargeRequest.amount = decimalNumber;
        [self.view showLoading];
        [self.rechargeV.rechargeBtn setEnabled:NO];
        [self.rechargeRequest startWithCompletion:^(__kindof XMRechargeRequest * _Nonnull request, NSError * _Nonnull error) {
            @strongify(self)
            [self.rechargeV.rechargeBtn setEnabled:YES];
            [self.view hideLoading];
            if (request.businessSuccess) {
                [XMPayUtil weiXinPay:request.businessData comple:^(BOOL success) {
                    if (success) {
                    }
                }];
            }else{
                [XMHUD showFail:request.businessMessage];
            }
        }];
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
    // 整数不能超过5位
    if (textField.text.length >= 5 && ![textField.text containsString:@"."]) {
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

- (XMRechargeView *)rechargeV
{
    if (!_rechargeV) {
        _rechargeV=[XMRechargeView new];
        [self.view addSubview:_rechargeV];
    }
    return _rechargeV;
}

- (XMRechargeRequest *)rechargeRequest
{
    if (!_rechargeRequest) {
        _rechargeRequest = [XMRechargeRequest request];
    }
    return _rechargeRequest;
}

- (void)dealloc
{
    NSLog(@"=============");
}


@end
