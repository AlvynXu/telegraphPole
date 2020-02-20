//
//  XMWalletView.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/17.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMWalletView.h"

@interface XMWalletView()

@property(nonatomic, strong)UIImageView *logoImgV;  // logo

@property(nonatomic, strong)UILabel *tipsLbl;  // 提示

@end

@implementation XMWalletView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

// 初始化
- (void)setup
{
    [self.logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@81);
        make.height.equalTo(@88);
        make.top.equalTo(@120);
    }];
    
    [self.tipsLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@200);
        make.height.equalTo(@20);
        make.top.equalTo(self.logoImgV.mas_bottom).offset(5);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.balanceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@36);
        make.top.equalTo(self.tipsLbl.mas_bottom).offset(10);
        make.width.equalTo(@(kScreenWidth - 30));
    }];
    
    [self.rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@156);
        make.height.equalTo(@45);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.balanceLbl.mas_bottom).offset(30);
    }];
    [self.withdrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.centerX.equalTo(self.rechargeBtn);
        make.top.equalTo(self.rechargeBtn.mas_bottom).offset(20);
    }];
}

- (UIImageView *)logoImgV
{
    if (!_logoImgV) {
        _logoImgV = [[UIImageView alloc] init];
        _logoImgV.image = kGetImage(@"wallet_logo");
        [self addSubview:_logoImgV];
    }
    return _logoImgV;
}

- (UILabel *)tipsLbl
{
    if (!_tipsLbl) {
        _tipsLbl = [[UILabel alloc] init];
        _tipsLbl.text = @"可用余额";
        _tipsLbl.textColor = kHexColor(0x464646);
        _tipsLbl.font = kSysFont(16);
        _tipsLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tipsLbl];
    }
    return _tipsLbl;
}

- (UILabel *)balanceLbl
{
    if (!_balanceLbl) {
        _balanceLbl = [[UILabel alloc] init];
        _balanceLbl.textColor = kHexColor(0x242424);
        _balanceLbl.font = kBoldFont(36);
        _balanceLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_balanceLbl];
    }
    return _balanceLbl;
}

- (UIButton *)rechargeBtn
{
    if (!_rechargeBtn) {
        _rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
        [_rechargeBtn setTitleColor:kHexColor(0xffffff) forState:UIControlStateNormal];
        _rechargeBtn.titleLabel.font = kSysFont(20);
        _rechargeBtn.backgroundColor = kHexColor(0x8BC34A);
        _rechargeBtn.layer.cornerRadius = 22.5;
        [self addSubview:_rechargeBtn];
    }
    return _rechargeBtn;
}

- (UIButton *)withdrawBtn
{
    if (!_withdrawBtn) {
        _withdrawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_withdrawBtn setTitle:@"提现" forState:UIControlStateNormal];
        [_withdrawBtn setTitleColor:kHexColor(0xffffff) forState:UIControlStateNormal];
        _withdrawBtn.titleLabel.font = kSysFont(20);
        _withdrawBtn.backgroundColor = kHexColor(0xFFAF2B);
        _withdrawBtn.layer.cornerRadius = 22.5;
        [self addSubview:_withdrawBtn];
    }
    return _withdrawBtn;
}



@end
