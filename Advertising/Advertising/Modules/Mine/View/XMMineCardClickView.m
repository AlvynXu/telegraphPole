//
//  XMMineCardClickView.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/18.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMMineCardClickView.h"

@interface XMMineCardClickView ()


@property(nonatomic, strong)UIImageView *iconImgV;

@end

@implementation XMMineCardClickView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self.numLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self);
        make.left.equalTo(@25);
        make.height.equalTo(@20);
    }];
        
    [self.descLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.right.equalTo(self.numLbl);
        make.top.equalTo(self.numLbl.mas_bottom).offset(10);
    }];
    
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.width.height.equalTo(@20);
        make.centerY.equalTo(self.descLbl.mas_centerY);
    }];
}

- (UILabel *)numLbl
{
    if (!_numLbl) {
        _numLbl = [UILabel new];
        _numLbl.textColor = kHexColor(0x101010);
        _numLbl.font = kBoldFont(18);
        [self addSubview:_numLbl];
    }
    return _numLbl;
}

- (UILabel *)descLbl
{
    if (!_descLbl) {
        _descLbl = [UILabel new];
        _descLbl.textColor = kHexColor(0x101010);
        _descLbl.font = kSysFont(15);
        [self addSubview:_descLbl];
    }
    return _descLbl;
}

- (UIImageView *)iconImgV
{
    if (!_iconImgV) {
        _iconImgV = [UIImageView new];
        _iconImgV.image = kGetImage(@"mine_card_circle");
        [self addSubview:_iconImgV];
    }
    return _iconImgV;
}




@end
