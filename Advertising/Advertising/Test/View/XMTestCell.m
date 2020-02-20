//
//  RKTestCell.m
//  Refactoring
//
//  Created by dingqiankun on 2019/4/1.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMTestCell.h"

@implementation XMTestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    [self.goodsImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@15);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImgv.mas_right).offset(10);
        make.top.equalTo(self.goodsImgv);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
    [self.shopNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLbl);
        make.bottom.equalTo(self.goodsImgv);
        make.height.equalTo(@20);
    }];
    
    [self.priceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLbl);
        make.height.equalTo(@20);
        make.bottom.equalTo(self.shopNameLbl.mas_top).offset(-5);
    }];
}

- (void)setViewWithModel:(XMDataModel *)model
{
    self.titleLbl.text = model.title;
    self.priceLbl.text = kFormat(@"￥%@", model.price);
    self.shopNameLbl.text = model.shopTitle;
    NSURL *imgUrl = [NSURL URLWithString:model.pic_url];
    [self.goodsImgv sd_setImageWithURL:imgUrl placeholderImage:nil];
}

#pragma mark  ------  懒加载

- (UIImageView *)goodsImgv
{
    if (!_goodsImgv) {
        _goodsImgv = [[UIImageView alloc] init];
        [self addSubview:_goodsImgv];
    }
    return _goodsImgv;
}

- (UILabel *)priceLbl
{
    if (!_priceLbl) {
        _priceLbl = [[UILabel alloc] init];
        _priceLbl.textColor = [UIColor redColor];
        _priceLbl.font = kSysFont(13);
        [self addSubview:_priceLbl];
    }
    return _priceLbl;
}


- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.numberOfLines = 0;
        _titleLbl.font = kSysFont(13);
        [self addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UILabel *)shopNameLbl
{
    if (!_shopNameLbl) {
        _shopNameLbl = [[UILabel alloc] init];
        _shopNameLbl.font = kSysFont(14);
        [self addSubview:_shopNameLbl];
    }
    return _shopNameLbl;
}

@end
