//
//  XMRechargeView.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/17.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMWithdrawView.h"

@interface XMWithdrawView()

@property(nonatomic, strong)UIImageView *baseImgV;

@property(nonatomic, strong)UILabel *titleLbl;  // 标题

@property(nonatomic, strong)UILabel *limitLbl;  // 限制

@property(nonatomic, strong)UILabel *symbolLbl;  // 符号

@property(nonatomic, strong)UILabel *chargeLbl;  // 手续费

@property(nonatomic, strong)UILabel *tipsLb;  // 提示

@property(nonatomic, strong)UIImageView *tipsImgV;

@end

@implementation XMWithdrawView

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
    [self.baseImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@360);
        make.height.equalTo(@278);
        make.centerX.equalTo(self);
        make.top.equalTo(@40);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.baseImgV);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
        make.top.equalTo(@35);
    }];
    
    [self.limitLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.baseImgV);
        make.width.equalTo(@150);
        make.height.equalTo(@17);
        make.top.equalTo(self.titleLbl.mas_bottom).offset(8);
    }];
    
    UIView *lineV = [[UIView alloc] init];
    lineV.backgroundColor = kHexColor(0x939393);
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@267);
        make.height.equalTo(@1);
        make.top.equalTo(self.limitLbl.mas_bottom).offset(80);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.symbolLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineV);
        make.bottom.equalTo(lineV.mas_top).offset(-10);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    [self.numTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.symbolLbl.mas_right).offset(10);
        make.centerY.equalTo(self.symbolLbl);
        make.height.equalTo(@30);
        make.right.equalTo(lineV);
    }];
    
    [self.canMoneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineV);
        make.top.equalTo(lineV.mas_bottom).offset(20);
        make.height.equalTo(@15);
    }];
    
    [self.allRechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lineV);
        make.height.equalTo(@20);
        make.width.equalTo(@65);
        make.centerY.equalTo(self.canMoneyLbl.mas_centerY);
    }];
    
    UIView *lineV1 = [[UIView alloc] init];
    lineV1.hidden = YES;
    lineV1.backgroundColor = kHexColor(0xFBCB3E);
    [self.baseImgV addSubview:lineV1];
    [lineV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.allRechargeBtn.mas_centerX);
        make.width.equalTo(@60);
        make.top.equalTo(self.allRechargeBtn.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [self.chargeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.canMoneyLbl);
        make.height.right.equalTo(self.canMoneyLbl);
        make.top.equalTo(self.canMoneyLbl.mas_bottom).offset(7);
    }];
    
    [self.tipsImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineV);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
         make.top.equalTo(self.baseImgV.mas_bottom).offset(20);
    }];
    
    [self.tipsLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lineV);
        make.left.equalTo(self.tipsImgV.mas_right).offset(10);
        make.top.equalTo(self.baseImgV.mas_bottom).offset(20);
    }];
    
    [self.rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-40);
        make.height.equalTo(@53);
        make.width.equalTo(@181);
        make.centerX.equalTo(self.mas_centerX);
    }];
}

- (void)setMoneyModel:(XMMoneyModel *)moneyModel
{
    _moneyModel = moneyModel;
    self.limitLbl.text = kFormat(@"每笔提现须≥%.2lf元", moneyModel.min);
    self.chargeLbl.text =  kFormat(@"提现手续费： %zd%%", (NSInteger)(moneyModel.rate * 100));
    _tipsLb.text = kFormat(@"提示：提现微信七个工作日内到账\n单笔提现封顶：%.2lf元", moneyModel.max);
}


- (UIImageView *)baseImgV
{
    if (!_baseImgV) {
        _baseImgV = [[UIImageView alloc] init];
        _baseImgV.userInteractionEnabled = YES;
        _baseImgV.image = kGetImage(@"wallet_widthdraw_base");
        [self addSubview:_baseImgV];
    }
    return _baseImgV;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.text = @"提现";
        _titleLbl.font = kBoldFont(24);
        _titleLbl.textColor = kHexColor(0x464646);
        [self.baseImgV addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UILabel *)limitLbl
{
    if (!_limitLbl) {
        _limitLbl = [[UILabel alloc] init];
        _limitLbl.textAlignment = NSTextAlignmentCenter;
        _limitLbl.font = kSysFont(14);
        _limitLbl.textColor = kHexColor(0x464646);
        [self.baseImgV addSubview:_limitLbl];
    }
    return _limitLbl;
}

- (UILabel *)symbolLbl
{
    if (!_symbolLbl) {
        _symbolLbl = [[UILabel alloc] init];
        _symbolLbl.text = @"￥";
        _symbolLbl.font = kBoldFont(24);
        _symbolLbl.textColor = kHexColor(0x242424);
        [self.baseImgV addSubview:_symbolLbl];
    }
    return _symbolLbl;
}

- (UITextField *)numTxt
{
    if (!_numTxt) {
        _numTxt = [[UITextField alloc] init];
        _numTxt.placeholder = @"请输入金额";
//        _numTxt.keyboardType = UIKeyboardTypeDecimalPad;
        _numTxt.keyboardType = UIKeyboardTypeNumberPad;
        _numTxt.font = kBoldFont(24);
        _numTxt.textColor = kHexColor(0x242424);
        [self.baseImgV addSubview:_numTxt];
    }
    return _numTxt;
}

- (UILabel *)canMoneyLbl
{
    if (!_canMoneyLbl) {
        _canMoneyLbl = [[UILabel alloc] init];
        _canMoneyLbl.text = @"可提现金额";
        _canMoneyLbl.font = kSysFont(14);
        _canMoneyLbl.textColor = kHexColor(0x464646);
        [self.baseImgV addSubview:_canMoneyLbl];
    }
    return _canMoneyLbl;
}

- (UIButton *)allRechargeBtn
{
    if (!_allRechargeBtn) {
        _allRechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _allRechargeBtn.hidden = YES;
        [_allRechargeBtn setTitle:@"全部提出" forState:UIControlStateNormal];
        _allRechargeBtn.titleLabel.font = kSysFont(14);
        [_allRechargeBtn setTitleColor:kHexColor(0xFBCB3E) forState:UIControlStateNormal];
        [self.baseImgV addSubview:_allRechargeBtn];
    }
    return _allRechargeBtn;
}

- (UILabel *)chargeLbl
{
    if (!_chargeLbl) {
        _chargeLbl = [[UILabel alloc] init];
        _chargeLbl.font = kSysFont(14);
        _chargeLbl.textColor = kHexColor(0x464646);
        [self addSubview:_chargeLbl];
    }
    return _chargeLbl;
}

- (UILabel *)tipsLb
{
    if (!_tipsLb) {
        _tipsLb = [[UILabel alloc] init];
        _tipsLb.numberOfLines = 0;
        _tipsLb.font = kSysFont(14);
        _tipsLb.textColor = kHexColor(0x88CC69);
        [self addSubview:_tipsLb];
    }
    return _tipsLb;
}


- (UIButton *)rechargeBtn
{
    if (!_rechargeBtn) {
        _rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rechargeBtn setTitle:@"提现" forState:UIControlStateNormal];
        _rechargeBtn.backgroundColor = kHexColor(0x8BC34A);
        _rechargeBtn.titleLabel.font = kSysFont(20);
        _rechargeBtn.layer.cornerRadius = 26.5;
        [_rechargeBtn setTitleColor:kHexColor(0xffffff) forState:UIControlStateNormal];
        [self addSubview:_rechargeBtn];
    }
    return _rechargeBtn;
}

- (UIImageView *)tipsImgV
{
    if (!_tipsImgV) {
        _tipsImgV = [[UIImageView alloc] init];
        _tipsImgV.image = kGetImage(@"wallert_widthdraw_tips");
        [self addSubview:_tipsImgV];
    }
    return _tipsImgV;
}



@end
