//
//  XMBuyStateController.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/28.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBuyStateController.h"
#import "XMBuyStateView.h"
#import "XMBuyStateRequest.h"

@interface XMBuyStateController ()

@property(nonatomic, strong)XMBuyStateView *buyStateV;

@property(nonatomic, strong)XMBuyStateRequest *buyStateRequest;

@property(nonatomic, strong)XMBuyStateModel *stateModel;

@end

@implementation XMBuyStateController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"购买情况";
    self.view.backgroundColor = UIColor.whiteColor;
    [self setup];
}

- (void)setup
{
    [self.view addSubview:self.buyStateV];
    [self.buyStateV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.safeEqualToTop(self.view);
        make.bottom.safeEqualToBottom(self.view);
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@(kScreenHeight));
    }];

    @weakify(self)
    [[self.buyStateV.goBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

// 加载数据
- (void)loadData:(Page)pageStatus
{
    
    if (pageStatus == PageLanlord) {
    }else if (pageStatus == PageBoot) {
    }else{
        self.buyStateV.line3.hidden = YES;
        [self.buyStateV agentView];
        return;
    }
    
    self.buyStateV.titleLbl.text = _page ==PageBoot?@"恭喜您，成功购买了一个展位":@"恭喜您，成功购买了一块地";
    // 隐藏一部分信息
    [self.buyStateV hideSomeView];
}

- (void)setPage:(Page)page
{
    _page = page;
    [self loadData:page];
}

- (void)viewWithModel:(XMBuyStateModel *)model
{
    self.buyStateV.titleLbl.text = _page ==PageBoot?@"恭喜您，成功购买了一个展位":@"恭喜您，成功购买了一块地";
}


- (XMBuyStateView *)buyStateV
{
    if (!_buyStateV) {
        _buyStateV = [[XMBuyStateView alloc] init];
    }
    return _buyStateV;
}

- (XMBuyStateRequest *)buyStateRequest
{
    if (!_buyStateRequest) {
        _buyStateRequest = [XMBuyStateRequest request];
    }
    return _buyStateRequest;
}


@end
