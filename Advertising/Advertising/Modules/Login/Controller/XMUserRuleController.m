//
//  XMUserRuleController.m
//  Advertising
//
//  Created by dingqiankun on 2020/1/4.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import "XMUserRuleController.h"
#import "XMLoginRequest.h"

@interface XMUserRuleController ()

@property(nonatomic, strong)UILabel *userRuleLbl; // 用户协议

@property(nonatomic, strong)UITextView *textV;

@property(nonatomic, strong)XMUserRuleRequest *userRuleRequest;

@end

@implementation XMUserRuleController


- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"用户协议";
    [self.textV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.safeEqualToTop(self.view).offset(0);
        make.bottom.safeEqualToBottom(self.view);
        make.left.right.equalTo(self.view);
    }];
    
    [self loadData];
}


// 加载数据
- (void)loadData
{
    [self.view showLoading];
    @weakify(self)
    [self.userRuleRequest startWithCompletion:^(__kindof XMUserRuleRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        [self.view hideLoading];
        if (request.businessSuccess) {
            XMUserRuleModel *userRuleModel = request.businessModel;
            self.textV.text = userRuleModel.text;
        }else{
            [XMHUD showFail:request.businessMessage];
        }
    }];
}



- (UILabel *)userRuleLbl
{
    if (!_userRuleLbl) {
        _userRuleLbl = [UILabel new];
        _userRuleLbl.numberOfLines = 0;
        _userRuleLbl.font = kSysFont(14);
        _userRuleLbl.textColor = kHexColor(0xFF333333);
        [self.view addSubview:_userRuleLbl];
    }
    return _userRuleLbl;
}

- (XMUserRuleRequest *)userRuleRequest
{
    if (!_userRuleRequest) {
        _userRuleRequest = [XMUserRuleRequest request];
    }
    return _userRuleRequest;
}


- (UITextView *)textV
{
    if (!_textV) {
        _textV = [UITextView new];
        [_textV setEditable:NO];
        [self.view addSubview:_textV];
    }
    return _textV;
}


@end
