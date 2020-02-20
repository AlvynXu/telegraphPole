//
//  XMLoginController.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/30.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMLoginController.h"
#import "XMNLoginView.h"
#import "XMNInvitationController.h"
#import "XMSendCodeRequest.h"
#import "XMCodeLoginRequest.h"
#import "XMBaseTabBarController.h"
#import "XMNInvitationController.h"
#import "XMUserRuleController.h"

@interface XMLoginController ()

@property(nonatomic, strong)XMNLoginView *loginV;

@property(nonatomic, strong)RACSignal *signal;  // 信号

@property(nonatomic, assign)NSInteger totalSeconds;  // 计时

@property(nonatomic, strong)XMSendCodeRequest *sendCodeRequest;  // 发送验证码

@property(nonatomic, strong)XMCodeLoginRequest *codeLoginRequest;  // 验证码登录

@property(nonatomic, assign)BOOL sendCodeing;   // 判断是否发送验证码中

@end

@implementation XMLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self bind];
}

- (void)bind
{
    @weakify(self)
    // 验证码
//    RAC(self.loginV.senderCodeBtn, enabled) = [self.loginV.phoneTxt.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
//        @strongify(self)
//        return @(self.loginV.phoneTxt.text.validateMobile && !self.sendCodeing);
//    }];
    
    RAC(self.loginV.loginIconBtn, selected) = [self.loginV.phoneTxt.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        @strongify(self)
        return @(self.loginV.phoneTxt.text.validateMobile);
    }];
    
    // 登录按钮
    RACSignal *phoneSignal = [self.loginV.phoneTxt.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @(value.validateMobile);
    }];
    
    RACSignal *valiCodeSigbal = [self.loginV.valieCodeTxt.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @(value.length == 4);
    }];
    
    [[self.loginV.selectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        UIButton *ruleBtn = (UIButton *)x;
        [ruleBtn setSelected:!ruleBtn.isSelected];
    }];
    
    RACSignal *ruleSelctSignal = [RACObserve(self.loginV.selectBtn, selected) map:^id _Nullable(id  _Nullable value) {
        return @(self.loginV.selectBtn.isSelected);
    }];
    
    // 按钮状态
    RAC(self.loginV.sureBtn, enabled) = [[RACSignal combineLatest:@[phoneSignal, valiCodeSigbal, ruleSelctSignal]] map:^id _Nullable(RACTuple * _Nullable value) {
        RACTupleUnpack(NSNumber *phoneVlid, NSNumber *valiCode, NSNumber *ruleSelct)= value;
        return @([phoneVlid boolValue]&&[valiCode boolValue]&&[ruleSelct boolValue]);
    }];
    //更换背景色
    [RACObserve(self.loginV.sureBtn, enabled) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.loginV.sureBtn setBackgroundColor: [x boolValue] ? kMainColor : kHexColor(0xFFDBDBDB)];
    }];
    
    // 发送验证码
    [[self.loginV.senderCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (!self.loginV.phoneTxt.text.validateMobile) {
            [XMHUD showText:@"手机号格式不正确"];
            return;
        }
        [self sendSmsCodeRequest];
         [self downTime];
    }];
    
    // 登录按钮事件
    [[self.loginV.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self loginRequest];
    }];
    
    
    [[self.loginV.readRuleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.navigationController pushViewController:[XMUserRuleController new] animated:YES];
    }];
}


// 初始化
- (void)setup
{
    [self.loginV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.safeEqualToTop(self.view);
        make.bottom.safeEqualToBottom(self.view);
        make.left.right.equalTo(self.view);
    }];
}

#pragma mark  -------  登录
// 登录
- (void)loginRequest
{
    [self.view showLoading];
    self.codeLoginRequest.phone = self.loginV.phoneTxt.text;
    self.codeLoginRequest.password = self.loginV.valieCodeTxt.text;
    self.loginV.sureBtn.enabled = NO;
    @weakify(self)
    [self.codeLoginRequest startWithCompletion:^(__kindof XMCodeLoginRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        [self.view hideLoading];
        self.loginV.sureBtn.enabled = YES;
        if (request.businessSuccess) {
            // 进入设置密码  新用户
            NSString *promoterId = request.businessData[@"user"][@"promoterId"];
            if (promoterId.integerValue == 0) {
                // 没有邀请码 设置邀请码
                NSString *userid = request.businessData[@"user"][@"id"];
                [self joinInvitation:userid];
            }else{
                // 用户有token 判断是否有邀请码  登录成功回调储存tokne
                [kLoginManager storageUserTokenWithDict:self.codeLoginRequest.businessData];
                [self joinAppHome];
            }
        }else{
            [XMHUD showText:request.businessMessage];
        }
    }];
}

#pragma makr ----- 进入邀请码
- (void)joinInvitation:(NSString *)userId
{
    XMNInvitationController *invitationVC = [XMNInvitationController new];
    [invitationVC.blockSubject subscribeNext:^(id  _Nullable x) {
        // 用户有token 判断是否有邀请码  登录成功回调储存tokne
        [kLoginManager storageUserTokenWithDict:self.codeLoginRequest.businessData];
    }];
    invitationVC.userid = userId;
    [self.navigationController pushViewController:invitationVC animated:YES];
}

#pragma mark  --- 进入首页
- (void)joinAppHome
{
    [self.view endEditing:YES];
    kWindow.rootViewController = [XMBaseTabBarController new];
}


#pragma mark  ------ 发送验证码
// 发送验证码
- (void)sendSmsCodeRequest
{
    self.sendCodeRequest.phone = self.loginV.phoneTxt.text;
    [self.sendCodeRequest startWithCompletion:^(__kindof XMSendCodeRequest * _Nonnull request, NSError * _Nonnull error) {
        if (request.businessSuccess) {
            [XMHUD showText:@"已发送"];
        }else{
            [XMHUD showFail:request.businessMessage];
            // 重置倒计时
            [self resetTime];
        }
    }];
}

// 开始倒计时
- (void)downTime
{
    self.sendCodeing = YES;
    [self.loginV.senderCodeBtn setEnabled:NO];
    self.totalSeconds = 60;
    // 开始倒计时
    @weakify(self)
    self.signal = [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] takeUntilBlock:^BOOL(id x) {
        @strongify(self)
        if (self.totalSeconds == 0) {
            return YES;
        }
        return NO;
    }];
    [self.signal subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.totalSeconds--;
        [self.loginV.senderCodeBtn setTitle:kFormat(@"再次发送(%zd)", self.totalSeconds) forState:UIControlStateDisabled];
        if (self.totalSeconds == 0) {
            [self resetTime];
        }
    }];
}

// 重置倒计时
- (void)resetTime
{
    self.signal = nil;
    self.sendCodeing = NO;
    [self.loginV.senderCodeBtn setEnabled:YES];
    [self.loginV.senderCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
}


- (XMNLoginView *)loginV
{
    if (!_loginV) {
        _loginV = [XMNLoginView new];
        [self.view addSubview:_loginV];
    }
    return _loginV;
}

- (XMSendCodeRequest *)sendCodeRequest
{
    if (!_sendCodeRequest) {
        _sendCodeRequest = [XMSendCodeRequest request];
    }
    return _sendCodeRequest;
}

- (XMCodeLoginRequest *)codeLoginRequest
{
    if (!_codeLoginRequest) {
        _codeLoginRequest = [XMCodeLoginRequest request];
    }
    return _codeLoginRequest;
}



@end
