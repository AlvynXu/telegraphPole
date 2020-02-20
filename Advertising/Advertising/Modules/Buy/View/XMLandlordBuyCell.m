//
//  XMLandlordBuyCell.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/27.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMLandlordBuyCell.h"

@interface XMLandlordBuyCell()

@property(nonatomic, strong)UIImageView *baseImgV;

@property(nonatomic, strong)UIImageView *iconImgV;

@property(nonatomic, strong)UILabel *titleLbl;

@property(nonatomic, strong)UILabel *numLbl;


@end

@implementation XMLandlordBuyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setup];
    }
    return self;
}


// 设置地主
- (void)setLandlordModel:(XMLandlordRecordsModel *)landlordModel
{
    _landlordModel = landlordModel;
    self.titleLbl.text = landlordModel.name;
    self.numLbl.text = kFormat(@"￥%.2lf/永久", landlordModel.price);
}


- (void)setBoothModel:(XMBoothRecordsModel *)boothModel
{
    _boothModel = boothModel;
    
    self.numLbl.text = kFormat(@"￥%.2lf/年", boothModel.price);
    if (boothModel.saved) {
        self.titleLbl.text = kFormat(@"地主展位：%@", boothModel.boothCode);
        self.buyBtn.backgroundColor = kMainColor;
        [self.buyBtn setTitle:@"免费解锁" forState:UIControlStateNormal];
    }else{
        self.titleLbl.text = kFormat(@"普通展位：%@", boothModel.boothCode);
        self.buyBtn.backgroundColor = kHexColor(0x03aa41);
        [self.buyBtn setTitle:@"购买" forState:UIControlStateNormal];
    }
}


// 初始化
- (void)setup
{
    [self.baseImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(@0);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@22);
        make.top.equalTo(@22);
        make.width.equalTo(@5);
        make.height.equalTo(@5);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImgV.mas_right).offset(2);
        make.top.equalTo(self.iconImgV);
        make.height.equalTo(@16);
        make.right.equalTo(self.buyBtn.mas_left).offset(-10);
    }];
    
    [self.numLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLbl.mas_left);
        make.top.equalTo(self.titleLbl.mas_bottom).offset(10);
        make.width.equalTo(@150);
        make.height.equalTo(@20);
    }];
    
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.baseImgV.mas_right).offset(-22);
        make.height.equalTo(@43);
        make.width.equalTo(@107);
        make.centerY.equalTo(self.baseImgV.mas_centerY);
    }];
    
}

- (UIImageView *)baseImgV
{
    if (!_baseImgV) {
        _baseImgV = [[UIImageView alloc] init];
        _baseImgV.image = kGetImage(@"landlord_base");
        [self addSubview:_baseImgV];
    }
    return _baseImgV;
}

- (UIImageView *)iconImgV
{
    if (!_iconImgV) {
        _iconImgV = [[UIImageView alloc] init];
        [self.baseImgV addSubview:_iconImgV];
    }
    return _iconImgV;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
//        _titleLbl.text = @"滨江区 中大街道";
        _titleLbl.font = kSysFont(15);
        _titleLbl.textColor = kHexColor(0xFF666666);
        [self.baseImgV addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UILabel *)numLbl
{
    if (!_numLbl) {
        _numLbl = [[UILabel alloc] init];
//        _numLbl.text = @"￥19800.0/永久";
        _numLbl.font = kBoldFont(18);
        _numLbl.textColor = kHexColor(0xFF333333);
        [self.baseImgV addSubview:_numLbl];
    }
    return _numLbl;
}

- (UIButton *)buyBtn
{
    if (!_buyBtn) {
        _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyBtn setTitle:@"购买" forState:UIControlStateNormal];
        _buyBtn.titleLabel.font = kSysFont(18);
        _buyBtn.backgroundColor = kMainColor;
        _buyBtn.layer.cornerRadius = 7;
        _buyBtn.layer.masksToBounds = YES;
        [self addSubview:_buyBtn];
    }
    return _buyBtn;
}

@end
