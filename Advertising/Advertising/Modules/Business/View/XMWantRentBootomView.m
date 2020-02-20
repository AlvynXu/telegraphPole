//
//  XMWantRentBootomView.m
//  Advertising
//
//  Created by dingqiankun on 2020/1/6.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import "XMWantRentBootomView.h"

@interface XMWantRentBootomView()<UITextFieldDelegate>

@property(nonatomic, strong)UIView *numBaseV;

@property(nonatomic, strong)UILabel *unitPriceLbl;  // 单价

@property(nonatomic, strong)UILabel *symbolLbl;  //符号

@property(nonatomic, strong)UILabel *totalDayLbl;  // 总天数

@property(nonatomic, strong)UILabel *rentTipsLbl; // 租用

@property(nonatomic, strong)UIView *variableV;  // 变量

@property(nonatomic, strong)UILabel *selectNumTipsLbl;  //选择数量提示

@property(nonatomic, strong)UILabel *priceTipsLbl;  // 价格提示

@property(nonatomic, strong)UILabel *priceSymbolLbl;  // 金钱符号

@property(nonatomic, strong)UIView *bootomBaseV;


@end

@implementation XMWantRentBootomView

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
    [self.numBaseV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@74);
        make.left.equalTo(@37);
        make.right.equalTo(self.mas_right).offset(-37);
        make.top.equalTo(self);
    }];
    
    [self.unitPriceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.numBaseV.mas_centerX).offset(-25);
        make.top.equalTo(@10);
        make.height.equalTo(@13);
        make.width.equalTo(@95);
    }];
    
    [self.symbolLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.unitPriceTxt.mas_left).offset(-10);
        make.bottom.equalTo(self.unitPriceTxt.mas_bottom).offset(-5);
        make.width.equalTo(@10);
        make.height.equalTo(@10);
    }];
    
    [self.unitPriceTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.unitPriceLbl.mas_right).offset(0);
        make.width.equalTo(@70);
        make.height.equalTo(@25);
        make.top.equalTo(self.unitPriceLbl.mas_bottom).offset(10.5);
    }];
    
    UIView *lineV1 = [UIView new];
    lineV1.backgroundColor = kHexColor(0xDBDBDBFF);
    [self.numBaseV addSubview:lineV1];
    [lineV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.symbolLbl);
        make.right.equalTo(self.unitPriceTxt.mas_right);
        make.height.equalTo(@1);
        make.top.equalTo(self.unitPriceTxt.mas_bottom);
    }];
    
    [self.totalDayLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numBaseV.mas_centerX).offset(25);
        make.centerY.height.equalTo(self.unitPriceLbl);
        make.width.equalTo(self.unitPriceTxt);
    }];
    
    [self.totalDayTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.totalDayLbl);
        make.centerY.height.width.equalTo(self.unitPriceTxt);
    }];
    UIView *lineV2 = [UIView new];
    lineV2.backgroundColor = kHexColor(0xDBDBDBFF);
    [self.numBaseV addSubview:lineV2];
    [lineV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.totalDayTxt);
        make.height.equalTo(@1);
        make.top.equalTo(self.totalDayTxt.mas_bottom);
    }];
    
    
    [self.rentTipsLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.unitPriceTxt.mas_bottom).offset(12);
        make.left.equalTo(@32);
        make.right.equalTo(self.mas_right).offset(-32);
        make.height.equalTo(@100);
    }];
    
    [self.bootomBaseV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(@55);
        make.bottom.equalTo(self);
    }];
    
    
    [self.selectNumTipsLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-8);
        make.width.equalTo(@62);
        make.height.equalTo(@15);
        make.left.equalTo(@0);
    }];
    

    [self.selectNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.selectNumTipsLbl.mas_top).offset(-5);
        make.width.equalTo(@62);
        make.height.equalTo(@15);
        make.left.equalTo(@0);
    }];
    
    UIView *lineV = [UIView new];
    lineV.backgroundColor = kHexColor(0xE3E3E3FF);
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectNumLbl.mas_right).offset(1);
        make.height.equalTo(self.bootomBaseV);
        make.centerY.equalTo(self.bootomBaseV);
        make.width.equalTo(@0.5);
    }];
    
    [self.payAndPublishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@125);
        make.height.equalTo(@44);
        make.centerY.equalTo(self.bootomBaseV);
        make.right.equalTo(self.mas_right).offset(-12);
    }];
    
    [self.priceTipsLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineV.mas_right).offset(10);
        make.bottom.equalTo(self.selectNumTipsLbl);
        make.height.equalTo(@15);
        make.width.equalTo(@35);
    }];
    
    [self.priceSymbolLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceTipsLbl.mas_right).offset(0);
        make.bottom.equalTo(self.selectNumTipsLbl).offset(0);
        make.width.equalTo(@10);
        make.height.equalTo(@15);
    }];
    
    [self.priceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceSymbolLbl.mas_right).offset(5);
        make.right.equalTo(self.payAndPublishBtn.mas_left).offset(-10);
        make.bottom.equalTo(self.selectNumTipsLbl).offset(3);
    }];
}

#pragma mark -------- 文本框代理校验金额

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    // 单价
    if (textField == self.unitPriceTxt) {
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
    }else{
        // 天数
        if (range.length >= 1) { // 删除数据, 都允许删除
            return YES;
        }
        return YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.unitPriceTxt) {
        if (textField.text.floatValue > 10000) {
            [XMHUD showText:@"最大租金10000元"];
            textField.text = @"10000";
        }
        if (textField.text.floatValue < 1) {
            [XMHUD showText:@"最小租金1.00元"];
            textField.text = @"1.00";
        }
    }else{
        if (textField.text.integerValue > 365) {
            [XMHUD showText:@"最大租期365天"];
            textField.text = @"365";
        }
        if (textField.text.integerValue < 1) {
            [XMHUD showText:@"最小租期1天"];
            textField.text = @"1";
        }
    }
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


- (UIView *)numBaseV
{
    if (!_numBaseV) {
        _numBaseV = [UIView new];
        _numBaseV.layer.borderWidth = 1;
        _numBaseV.layer.borderColor = kHexColor(0xEEEEEEFF).CGColor;
        _numBaseV.layer.cornerRadius = 37;
        _numBaseV.layer.masksToBounds = YES;
        _numBaseV.backgroundColor = UIColor.whiteColor;
        [self addSubview:_numBaseV];
    }
    return _numBaseV;
}

- (UILabel *)unitPriceLbl
{
    if (!_unitPriceLbl) {
        _unitPriceLbl = [UILabel new];
        _unitPriceLbl.textColor = kHexColor(0xFF333333);
        _unitPriceLbl.font = kSysFont(11);
        _unitPriceLbl.textAlignment = NSTextAlignmentCenter;
        _unitPriceLbl.text = @"求租单价/天";
        [self addSubview:_unitPriceLbl];
    }
    return _unitPriceLbl;
}


- (UILabel *)totalDayLbl
{
    if (!_totalDayLbl) {
        _totalDayLbl = [UILabel new];
        _totalDayLbl.font = kSysFont(11);
        _totalDayLbl.textAlignment = NSTextAlignmentCenter;
        _totalDayLbl.textColor = kHexColor(0xFF333333);
        _totalDayLbl.text = @"总天数";
        [self.numBaseV addSubview:_totalDayLbl];
    }
    return _totalDayLbl;
}

- (UILabel *)symbolLbl
{
    if (!_symbolLbl) {
        _symbolLbl = [UILabel new];
        _symbolLbl.textColor = kHexColor(0xFFF85F53);
        _symbolLbl.font = kSysFont(12);
        _symbolLbl.text = @"￥";
        [self.numBaseV addSubview:_symbolLbl];
    }
    return _symbolLbl;
}


- (UITextField *)unitPriceTxt
{
    if (!_unitPriceTxt) {
        _unitPriceTxt = [UITextField new];
        _unitPriceTxt.delegate = self;
        _unitPriceTxt.font = kSysFont(18);
        _unitPriceTxt.keyboardType = UIKeyboardTypeDecimalPad;
        _unitPriceTxt.textColor = kHexColor(0xFF333333);
        _unitPriceTxt.text = @"1.00";
        _unitPriceTxt.textAlignment = NSTextAlignmentCenter;
        [self.numBaseV addSubview:_unitPriceTxt];
    }
    return _unitPriceTxt;
}

- (UITextField *)totalDayTxt
{
    if (!_totalDayTxt) {
        _totalDayTxt = [[UITextField alloc] init];
        _totalDayTxt.delegate = self;
        _totalDayTxt.keyboardType = UIKeyboardTypeNumberPad;
        _totalDayTxt.font = kSysFont(18);
        _totalDayTxt.textColor = kHexColor(0xFF333333);
        _totalDayTxt.text = @"10";
        _totalDayTxt.textAlignment = NSTextAlignmentCenter;
        [self.numBaseV addSubview:_totalDayTxt];
    }
    return _totalDayTxt;
}

- (UILabel *)rentTipsLbl
{
    if (!_rentTipsLbl) {
        _rentTipsLbl = [UILabel new];
        _rentTipsLbl.textColor = kHexColor(0xFF333333);
        _rentTipsLbl.font = kSysFont(12);
        _rentTipsLbl.numberOfLines = 0;
        _rentTipsLbl.text = @"求租须知：\n求租信息发布后，展示时间为7天；\n如无人租用，所付订金将全额退回您的钱包；\n成功租用后，请及时使用展位哦...";
        [_rentTipsLbl setText:_rentTipsLbl.text lineSpacing:5];
        [self addSubview:_rentTipsLbl];
    }
    return _rentTipsLbl;
}

- (UILabel *)selectNumTipsLbl
{
    if (!_selectNumTipsLbl) {
        _selectNumTipsLbl = [UILabel new];
        _selectNumTipsLbl.textColor = kHexColor(0xFF000000);
        _selectNumTipsLbl.font = kSysFont(13);
        _selectNumTipsLbl.text = @"已选";
        _selectNumTipsLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_selectNumTipsLbl];
    }
    return _selectNumTipsLbl;
}

- (UILabel *)selectNumLbl
{
    if (!_selectNumLbl) {
        _selectNumLbl = [UILabel new];
        _selectNumLbl.textColor = kHexColor(0xFF000000);
        _selectNumLbl.font = kSysFont(13);
        _selectNumLbl.text = @"0";
        _selectNumLbl.adjustsFontSizeToFitWidth=YES;
        _selectNumLbl.minimumScaleFactor = 0.5;
        _selectNumLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_selectNumLbl];
    }
    return _selectNumLbl;
}

- (UILabel *)priceTipsLbl
{
    if (!_priceTipsLbl) {
        _priceTipsLbl = [UILabel new];
        _priceTipsLbl.text = @"价格:";
        _priceTipsLbl.font = kSysFont(13);
        _priceTipsLbl.textColor = kHexColor(0xFF000000);
        [self addSubview:_priceTipsLbl];
    }
    return _priceTipsLbl;
}

- (UILabel *)priceSymbolLbl
{
    if (!_priceSymbolLbl) {
        _priceSymbolLbl = [UILabel new];
        _priceSymbolLbl.text=@"￥";
        _priceSymbolLbl.textColor = kHexColor(0xFFF85F53);
        _priceSymbolLbl.font = kSysFont(12);
        [self addSubview:_priceSymbolLbl];
    }
    return _priceSymbolLbl;
}

- (UILabel *)priceLbl
{
    if (!_priceLbl) {
        _priceLbl = [UILabel new];
        _priceLbl.textColor = kHexColor(0xFFF85F53);
        _priceLbl.font = kSysFont(21);
        _priceLbl.adjustsFontSizeToFitWidth=YES;
        _priceLbl.minimumScaleFactor = 0.5;
        [self addSubview:_priceLbl];
    }
    return _priceLbl;
}

- (UIButton *)payAndPublishBtn
{
    if (!_payAndPublishBtn) {
        _payAndPublishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payAndPublishBtn setTitle:@"支付并发布" forState:UIControlStateNormal];
        [_payAndPublishBtn setTitleColor:kHexColor(0xFF000000) forState:UIControlStateNormal];
        _payAndPublishBtn.backgroundColor = kHexColor(0xFFFFCC00);
        _payAndPublishBtn.titleLabel.font = kSysFont(16);
        _payAndPublishBtn.layer.cornerRadius = 22;
        [self addSubview:_payAndPublishBtn];
    }
    return _payAndPublishBtn;
}


- (UIView *)bootomBaseV
{
    if (!_bootomBaseV) {
        _bootomBaseV = [UIView new];
        _bootomBaseV.backgroundColor = UIColor.whiteColor;
        [self addSubview:_bootomBaseV];
    }
    return _bootomBaseV;
}



@end
