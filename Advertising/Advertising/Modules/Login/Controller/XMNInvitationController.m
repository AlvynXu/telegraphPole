//
//  XMNInvitationController.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/30.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMNInvitationController.h"
#import "XMNinvitationView.h"
#import "XMInvitationCodeRequest.h"
#import "XMBaseTabBarController.h"

@interface XMNInvitationController ()

@property(nonatomic, strong)XMNinvitationView *invitationV;

@property(nonatomic, copy)NSString *invitationStr;

@property(nonatomic, strong)XMInvitationCodeRequest *invitationRequest;  // 邀请

@end

@implementation XMNInvitationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self bind];
}


// 绑定
- (void)bind
{
    @weakify(self)
    self.invitationV.invitationTxt.passwordDidChangeBlock = ^(NSString *password) {
        @strongify(self)
        self.invitationStr = password;
        self.invitationV.sureBtn.enabled = self.invitationStr.length == 6;
    };
    
    //更换背景色
    [RACObserve(self.invitationV.sureBtn, enabled) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.invitationV.sureBtn setBackgroundColor: [x boolValue] ? kMainColor : kHexColor(0xFFDBDBDB)];
    }];
    
    [[self.invitationV.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self loadData];
    }];
    
    [[self.invitationV.backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)loadData
{
    [self.view showLoading];
    self.invitationRequest.promoterId = self.invitationStr;
    self.invitationV.sureBtn.enabled = NO;
    self.invitationRequest.userId = self.userid;
    @weakify(self)
    [self.invitationRequest startWithCompletion:^(__kindof XMInvitationCodeRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        self.invitationV.sureBtn.enabled = YES;
        [self.view hideLoading];
        if (request.businessSuccess) {
            // 储存token
            [self.blockSubject sendNext:@""];
            // 进入首页
            [self joinAppHome];
        }else{
            [XMHUD showText:request.businessMessage];
        }
    }];
}

// 进入首页
- (void)joinAppHome
{
    kWindow.rootViewController = [XMBaseTabBarController new];
}

- (void)setup
{
    [self.invitationV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.safeEqualToTop(self.view);
        make.bottom.safeEqualToBottom(self.view);
        make.left.right.equalTo(self.view);
    }];
}

- (XMNinvitationView *)invitationV
{
    if (!_invitationV) {
        _invitationV = [XMNinvitationView new];
        [self.view addSubview:_invitationV];
    }
    return _invitationV;
}

- (RACSubject *)blockSubject
{
    if (!_blockSubject) {
        _blockSubject = [RACSubject subject];
    }
    return _blockSubject;
}

- (XMInvitationCodeRequest *)invitationRequest
{
    if (!_invitationRequest) {
        _invitationRequest = [XMInvitationCodeRequest request];
    }
    return _invitationRequest;
}




@end
