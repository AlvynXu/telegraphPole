//
//  XMBoothManagerCell.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBoothManagerCell.h"

@interface XMBoothManagerCell()

@property(nonatomic, strong)UIImageView *baseImgV;

@property(nonatomic, strong)UILabel *titileLbl; // 标题

@property(nonatomic, strong)UILabel *numLbl;  //编号

@property(nonatomic, strong)UILabel *dayLbl;  // 剩余

@end

@implementation XMBoothManagerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setup];
    }
    return self;
}

// 初始化
- (void)setup
{
    
    [self.baseImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.baseImgV.mas_right).offset(-25);
        make.top.equalTo(@30);
        make.width.height.equalTo(@25);
    }];
    [self.titileLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@25);
        make.top.equalTo(@30);
        make.right.equalTo(self.selectBtn.mas_left).offset(-10);
        make.height.equalTo(@20);
    }];
    
    [self.numLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titileLbl);
        make.height.equalTo(@16);
        make.top.equalTo(self.titileLbl.mas_bottom).offset(3);
    }];
    
    [self.dayLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.right.equalTo(self.titileLbl);
        make.top.equalTo(self.numLbl.mas_bottom).offset(3);
    }];
}

- (void)setItemModel:(XMBoothMangerItemModel *)itemModel
{
    _itemModel = itemModel;
    [self.selectBtn setSelected:itemModel.select];
    self.titileLbl.text = kFormat(@"%@-%@-%@", itemModel.city, itemModel.district, itemModel.street);
    self.numLbl.text = kFormat(@"编号：%@", itemModel.boothCode);
    self.dayLbl.text = kFormat(@"剩余：%@天", itemModel.leftDate);
}

- (UILabel *)titileLbl
{
    if (!_titileLbl) {
        _titileLbl = [[UILabel alloc] init];
        _titileLbl.textColor = kHexColor(0x2D2D2D);
        _titileLbl.font = kSysFont(16);
        [self.baseImgV addSubview:_titileLbl];
    }
    return _titileLbl;
}

- (UILabel *)numLbl
{
    if (!_numLbl) {
        _numLbl = [UILabel new];
        _numLbl.textColor = kHexColor(0x555555);
        _numLbl.font = kSysFont(13);
        [self.baseImgV addSubview:_numLbl];
    }
    return _numLbl;
}

- (UILabel *)dayLbl
{
    if (!_dayLbl) {
        _dayLbl = [UILabel new];
        _dayLbl.textColor = kHexColor(0x555555);
        _dayLbl.font=kSysFont(13);
        [self.baseImgV addSubview:_dayLbl];
    }
    return _dayLbl;
}

- (UIButton *)selectBtn
{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:kGetImage(@"project_normal_icon") forState:UIControlStateNormal];
        [_selectBtn setImage:kGetImage(@"project_select_icon") forState:UIControlStateSelected];
        [self.baseImgV addSubview:_selectBtn];
    }
    return _selectBtn;
}



- (UIImageView *)baseImgV
{
    if (!_baseImgV) {
        _baseImgV = [UIImageView new];
        _baseImgV.image= kGetImage(@"team_item");
        _baseImgV.userInteractionEnabled = YES;
        [self addSubview:_baseImgV];
    }
    return _baseImgV;
}


@end
