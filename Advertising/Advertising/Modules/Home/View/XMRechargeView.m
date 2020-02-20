//
//  XMRechargeView.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/17.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMRechargeView.h"

@interface XMRechargeView()

@property(nonatomic, strong)UIImageView *baseImgV;

@property(nonatomic, strong)UILabel *titleLbl;

@property(nonatomic, strong)UILabel *symbolLbl;  // 符号


@property(nonatomic, strong)UILabel *payStyleLbl;  // 支付方式

@property(nonatomic, strong)UIImageView *itemBaseImgV;  // item

@property(nonatomic, strong)UIImageView *logoImgV;

@property(nonatomic, strong)UILabel *namePayLbl;

@property(nonatomic, strong)UIButton *selectBtn;



@end

@implementation XMRechargeView

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
        make.height.equalTo(@220);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(@40);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@30);
        make.centerX.equalTo(self.baseImgV);
        make.width.equalTo(@100);
        make.height.equalTo(@40);
    }];
    
    UIView *lineV = [[UIView alloc] init];
    lineV.backgroundColor = kHexColor(0x939393);
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@267);
        make.height.equalTo(@1);
        make.top.equalTo(self.titleLbl.mas_bottom).offset(90);
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
    
    [self.payStyleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.itemBaseImgV).offset(7);
        make.top.equalTo(self.baseImgV.mas_bottom).offset(30);
        make.height.equalTo(@20);
        make.width.equalTo(@150);
    }];
    
    [self.itemBaseImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payStyleLbl.mas_bottom).offset(20);
        make.left.right.equalTo(self.baseImgV);
        make.height.equalTo(@78);
    }];
    
    [self.logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.height.equalTo(@25);
        make.centerY.equalTo(self.itemBaseImgV.mas_centerY);
    }];
    
    [self.namePayLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.logoImgV);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
        make.left.equalTo(self.logoImgV.mas_right).offset(10);
    }];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.logoImgV);
        make.width.height.equalTo(@25);
        make.right.equalTo(self.itemBaseImgV.mas_right).offset(-30);
    }];
    
    [self.rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-40);
        make.height.equalTo(@53);
        make.width.equalTo(@181);
        make.centerX.equalTo(self.mas_centerX);
    }];
}

- (UIImageView *)baseImgV
{
    if (!_baseImgV) {
        _baseImgV = [UIImageView new];
        _baseImgV.userInteractionEnabled = YES;
        _baseImgV.image = kGetImage(@"wallet_recharge_base");
        [self addSubview:_baseImgV];
    }
    return _baseImgV;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.text = @"余额充值";
        _titleLbl.font = kBoldFont(24);
        _titleLbl.textColor = kHexColor(0x464646);
        [self.baseImgV addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UILabel *)symbolLbl
{
    if (!_symbolLbl) {
        _symbolLbl = [UILabel new];
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
        _numTxt = [UITextField new];
        _numTxt.placeholder = @"请输入金额";
        _numTxt.keyboardType = UIKeyboardTypeDecimalPad;
        _numTxt.font = kBoldFont(24);
        _numTxt.textColor = kHexColor(0x242424);
        [self.baseImgV addSubview:_numTxt];
    }
    return _numTxt;
}

- (UILabel *)payStyleLbl
{
    if (!_payStyleLbl) {
        _payStyleLbl = [UILabel new];
        _payStyleLbl.text = @"支付方式";
        _payStyleLbl.font = kBoldFont(18);
        _payStyleLbl.textColor = kHexColor(0x464646);
        
        [self addSubview:_payStyleLbl];
    }
    return _payStyleLbl;
}

- (UIImageView *)itemBaseImgV
{
    if (!_itemBaseImgV) {
        _itemBaseImgV = [UIImageView new];
        _itemBaseImgV.image = kGetImage(@"wallet_pay_item");
        _itemBaseImgV.userInteractionEnabled = YES;
        [self addSubview:_itemBaseImgV];
    }
    return _itemBaseImgV;
}

- (UIImageView *)logoImgV
{
    if (!_logoImgV) {
        _logoImgV = [[UIImageView alloc] init];
        _logoImgV.image = kGetImage(@"wechat_icon");
        [self.itemBaseImgV addSubview:_logoImgV];
    }
    return _logoImgV;
}
- (UILabel *)namePayLbl
{
    if (!_namePayLbl) {
        _namePayLbl = [UILabel new];
        _namePayLbl.text = @"微信支付";
        [self.itemBaseImgV addSubview:_namePayLbl];
    }
    return _namePayLbl;
}

- (UIButton *)selectBtn
{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:kGetImage(@"pay_select") forState:UIControlStateNormal];
        [self.itemBaseImgV addSubview:_selectBtn];
    }
    return _selectBtn;
}

- (UIButton *)rechargeBtn
{
    if (!_rechargeBtn) {
        _rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
        _rechargeBtn.backgroundColor = kHexColor(0x8BC34A);
        _rechargeBtn.titleLabel.font = kSysFont(20);
        _rechargeBtn.layer.cornerRadius = 26.5;
        [_rechargeBtn setTitleColor:kHexColor(0xffffff) forState:UIControlStateNormal];
        [self addSubview:_rechargeBtn];
    }
    return _rechargeBtn;
}


@end
