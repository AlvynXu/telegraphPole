//
//  XMLanlordRecordCell.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/5.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMLanlordRecordCell.h"

@interface XMLanlordRecordCell()

@property(nonatomic, strong)UIImageView *baseImgV;

@property(nonatomic, strong)UIImageView *iconImgV;

@property(nonatomic, strong)UILabel *titleLbl;

@end

@implementation XMLanlordRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setup];
    }
    return self;
}

- (void)setItemModel:(XMLanlordRecordsItemModel *)itemModel
{
    _itemModel = itemModel;
    NSString *districtDot = kFormat(@"· %@", itemModel.district);
    NSString *streetDot = kFormat(@"· %@", itemModel.street);
    self.titleLbl.text = kFormat(@"%@ %@ %@", itemModel.city, districtDot, streetDot);
}


- (void)setup
{
    [self.baseImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.equalTo(@70);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@38);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
        make.centerY.equalTo(self.baseImgV.mas_centerY);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImgV.mas_right).offset(14);
        make.right.equalTo(self.baseImgV.mas_right).offset(-14);
        make.height.equalTo(@20);
        make.centerY.equalTo(self.baseImgV.mas_centerY);
    }];
}

- (UIImageView *)baseImgV
{
    if (!_baseImgV) {
        _baseImgV = [UIImageView new];
        _baseImgV.image = kGetImage(@"team_item");
        [self addSubview:_baseImgV];
    }
    return _baseImgV;
}

- (UIImageView *)iconImgV
{
    if (!_iconImgV) {
        _iconImgV = [UIImageView new];
        _iconImgV.image = kGetImage(@"record_flag");
        [self.baseImgV addSubview:_iconImgV];
    }
    return _iconImgV;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.textColor = kHexColor(0xFF333333);
        _titleLbl.font = kBoldFont(18);
        [self.baseImgV addSubview:_titleLbl];
    }
    return _titleLbl;
}


@end
