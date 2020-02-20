//
//  XMSelectStreetCell.m
//  Advertising
//
//  Created by dingqiankun on 2020/1/7.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import "XMSelectStreetCell.h"

@interface XMSelectStreetCell()

@property(nonatomic, strong)UIView *baseV;

@property(nonatomic, strong)UILabel *titleLbl;

@end

@implementation XMSelectStreetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)setup
{
    [self.baseV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@39);
        make.right.equalTo(self.mas_right).offset(-39);
        make.height.equalTo(@47);
        make.centerY.equalTo(self);
        
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.right.equalTo(self.baseV.mas_right).offset(-70);
        make.height.equalTo(@17);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.baseV.mas_right).offset(-20);
        make.height.width.equalTo(@35);
        make.centerY.equalTo(self.baseV);
    }];
}

- (void)setStreetItemModel:(XMStreetItemModel *)streetItemModel
{
    _streetItemModel = streetItemModel;
    self.titleLbl.text = streetItemModel.name;
    [self.selectBtn setSelected:streetItemModel.select];
}

- (UIView *)baseV
{
    if (!_baseV) {
        _baseV = [UIView new];
        _baseV.layer.borderColor = kHexColor(0xEEEEEEFF).CGColor;
        _baseV.layer.borderWidth = 1;
        _baseV.layer.cornerRadius = 23.5;
        _baseV.backgroundColor = UIColor.whiteColor;
        [self addSubview:_baseV];
    }
    return _baseV;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = kHexColor(0xFF333333);
        _titleLbl.font = kSysFont(15);
        [self.baseV addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UIButton *)selectBtn
{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:kGetImage(@"business_rent_normal") forState:UIControlStateNormal];
        [_selectBtn setImage:kGetImage(@"business_rent_select") forState:UIControlStateSelected];
        [self.baseV addSubview:_selectBtn];
    }
    return _selectBtn;
}


@end
