//
//  XMSelectCanStreetCell.m
//  Advertising
//
//  Created by dingqiankun on 2020/1/2.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import "XMSelectCanStreetCell.h"

@interface XMSelectCanStreetCell()

@property(nonatomic, strong)UILabel *titleLbl;  // 标题

@end

@implementation XMSelectCanStreetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

// 初始化
- (void)setup
{
    CGFloat left = 17;
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-left);
        make.height.with.equalTo(@30);
        make.centerY.equalTo(self);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(left));
        make.height.equalTo(@16);
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-47);
    }];
}

- (void)setItemModel:(XMRentCanStreetItemModel *)itemModel
{
    _itemModel = itemModel;
    self.titleLbl.text = kFormat(@"%@ %@ %@", itemModel.cityName, itemModel.districtName, itemModel.streetName);
    self.titleLbl.textColor = itemModel.hasBooth?kHexColor(0xFF333333):kHexColor(0xFF999999);
    self.selectBtn.hidden = !itemModel.hasBooth;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.textColor = kHexColor(0xFF333333);
        _titleLbl.font = kSysFont(15);
        [self addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UIButton *)selectBtn
{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:kGetImage(@"rule_normal") forState:UIControlStateNormal];
        [_selectBtn setImage:kGetImage(@"rule_select") forState:UIControlStateSelected];
        [self addSubview:_selectBtn];
    }
    return _selectBtn;
}


@end
