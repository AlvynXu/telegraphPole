//
//  XMMoneyNumCell.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/27.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMMoneyNumCell.h"
#import "UILabel+Normal.h"

@interface XMMoneyNumCell ()

@property(nonatomic, strong)UIImageView *logoImgV;

@property(nonatomic, strong)UILabel *titleLbl;

@property(nonatomic, strong)UILabel *numLbl;

@property(nonatomic, strong)UIView *lineV;

@property(nonatomic, strong)UILabel *soldLbl;  // 已售

@end

@implementation XMMoneyNumCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self.logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@87);
        make.width.equalTo(@82);
        make.top.equalTo(self);
    }];
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@15);
        make.width.equalTo(@(kScreenWidth - 30));
        make.top.equalTo(self.logoImgV.mas_bottom).offset(9);
    }];
    [self.numLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@25);
        make.width.equalTo(@(kScreenWidth - 30));
        make.top.equalTo(self.titleLbl.mas_bottom).offset(15);
    }];
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@1);
        make.width.equalTo(@(164));
        make.top.equalTo(self.numLbl.mas_bottom).offset(15);
    }];
    [self.soldLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@16);
        make.width.equalTo(@(164));
        make.top.equalTo(self.lineV.mas_bottom).offset(12);
    }];
}

- (void)setLandlordModle:(XMHomeBootModel *)landlordModle
{
    _landlordModle = landlordModle;
    self.titleLbl.text = self.isLandlord?@"地主限量发行 (总量)": @"展位限量发行 (总量)";
    // 模型是否存在
    if (self.landlordModle) {
        [self viewValueWithModel];
    }
}


- (void)viewValueWithModel
{
    NSString *total =  self.landlordModle.totalCount;
    self.numLbl.text = total;
    NSString *selled = self.landlordModle.soldCount;
//    CGFloat perence = selled.floatValue / total.floatValue;
    self.soldLbl.text = kFormat(@"已售：%@", selled);
    [self.soldLbl changeStr:selled color:kMainColor font:kSysFont(14)];
}


- (UIImageView *)logoImgV
{
    if (!_logoImgV) {
        _logoImgV = [[UIImageView alloc] init];
        _logoImgV.image = kGetImage(@"lanlord_buy");
        [self addSubview:_logoImgV];
    }
    return _logoImgV;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = kHexColor(0xFF333333);
        _titleLbl.font = kSysFont(15);
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UILabel *)numLbl
{
    if (!_numLbl) {
        _numLbl = [[UILabel alloc] init];
        _numLbl.text = @"0";
        _numLbl.textColor = kHexColor(0xFF333333);
        _numLbl.font = kBoldFont(24);
        _numLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_numLbl];
    }
    return _numLbl;
}

- (UIView *)lineV
{
    if (!_lineV) {
        _lineV = [[UIView alloc] init];
        _lineV.backgroundColor = kHexColor(0xFFD0D0D0);
        [self addSubview:_lineV];
    }
    return _lineV;
}

- (UILabel *)soldLbl
{
    if (!_soldLbl) {
        _soldLbl = [[UILabel alloc] init];
        _soldLbl.textColor = kHexColor(0xFF333333);
        _soldLbl.font = kSysFont(14);
        _soldLbl.text = @"已售: 0 0.00%";
        [self addSubview:_soldLbl];
    }
    return _soldLbl;
}


@end
