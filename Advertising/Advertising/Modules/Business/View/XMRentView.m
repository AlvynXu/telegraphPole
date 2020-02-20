//
//  XMRentView.m
//  Advertising
//
//  Created by dingqiankun on 2020/1/2.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import "XMRentCell.h"

@interface XMRentCell()

@property(nonatomic, strong)UILabel *unitPriceLbl;  //单价

@property(nonatomic, strong)UILabel *priceTipsLbl;  // 单价提示

@property(nonatomic, strong)UILabel *dayLbl;  // 天数

@property(nonatomic,strong)UILabel *dayTipsLbl;  //天数提示

@property(nonatomic, strong)UILabel *typeLbl;  // 我的求租

@property(nonatomic, strong)UIButton *sallBtn;  // 出售

@property(nonatomic, strong)UILabel *scaleLbl;  // 比例值

@end

@implementation XMRentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

// 初始化
- (void)setup
{
    [self.unitPriceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.left.equalTo(@30);
        make.width.equalTo(@100);
        make.height.equalTo(@17);
    }];
    
    [self.priceTipsLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.unitPriceLbl);
        make.top.equalTo(self.unitPriceLbl.mas_bottom).offset(5);
        make.width.equalTo(@50);
        make.height.equalTo(@13);
    }];
}

- (UILabel *)unitPriceLbl
{
    if (!_unitPriceLbl) {
        _unitPriceLbl = [UILabel new];
        _unitPriceLbl.text = @"￥1.0";
        _unitPriceLbl.font = kSysFont(18);
        _unitPriceLbl.textColor = kHexColor(0xFF333333);
        [self addSubview:_unitPriceLbl];
    }
    return _unitPriceLbl;
}

- (UILabel *)priceTipsLbl
{
    if (!_priceTipsLbl) {
        _priceTipsLbl = [UILabel new];
        _priceTipsLbl.text = @"单价";
        _priceTipsLbl.textColor = kHexColor(0xFF999999);
        _priceTipsLbl.font = kSysFont(12);
        [self addSubview:_priceTipsLbl];
    }
    return _priceTipsLbl;
}

- (UILabel *)dayLbl
{
    if (!_dayLbl) {
        _dayLbl  =[UILabel new];
        _dayLbl.textColor = kHexColor(0xFF999999);
        _dayLbl.font = kSysFont(18);
        _dayLbl.text = @"15";
        [self addSubview:_dayLbl];
    }
    return _dayLbl;
}

- (UILabel *)typeLbl
{
    if (!_typeLbl) {
        _typeLbl = [UILabel new];
        _typeLbl.textColor = kHexColor(0xFF333333);
        _typeLbl.font = kSysFont(16);
        _typeLbl.text = @"#我的求租";
        [self addSubview:_typeLbl];
    }
    return _typeLbl;
}

- (UIButton *)sallBtn
{
    if (!_sallBtn) {
        _sallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sallBtn.titleLabel.font = kSysFont(15);
        [_sallBtn setTitle:@"卖给ta" forState:UIControlStateNormal];
        _sallBtn.layer.cornerRadius = 17;
        _sallBtn.layer.masksToBounds = YES;
        _sallBtn.backgroundColor = kMainColor;
        [self addSubview:_sallBtn];
    }
    return _sallBtn;
}

- (UILabel *)scaleLbl
{
    if (!_scaleLbl) {
        _scaleLbl = [UILabel new];
        _scaleLbl.textColor = kHexColor(0xFFF85F53);
        _scaleLbl.font = kSysFont(10);
        _scaleLbl.text = @"1/22";
        [self addSubview:_scaleLbl];
    }
    return _scaleLbl;
}

@end
