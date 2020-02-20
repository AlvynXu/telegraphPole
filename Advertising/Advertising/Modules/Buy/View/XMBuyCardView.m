//
//  XMBuyCardView.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/26.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBuyCardView.h"

@interface XMBuyCardView ()



@end

@implementation XMBuyCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [super initWithFrame:frame];
        [self setup];
    }
    return self;
}

// 初始化
- (void)setup
{
    [self.baseImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.leftImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(13));
        make.centerY.equalTo(self.baseImgV.mas_centerY);
        make.width.equalTo(@(48));
        make.height.equalTo(@(48));
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImgV.mas_right).offset(6);
        make.top.equalTo(self.leftImgV.mas_top).offset(7);
        make.right.equalTo(self);
        make.height.equalTo(@(18));
    }];
    
    [self.numLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLbl.mas_left);
         make.top.equalTo(self.titleLbl.mas_bottom).offset(5);
        make.right.equalTo(self.titleLbl.mas_right);
        make.height.equalTo(self.titleLbl.mas_height);
    }];
}

- (UIImageView *)baseImgV
{
    if (!_baseImgV) {
        _baseImgV = [[UIImageView alloc] init];
//        _baseImgV.image = kGetImage(@"landlord_base");
        _baseImgV.userInteractionEnabled = YES;
        [self addSubview:_baseImgV];
    }
    return _baseImgV;
}

- (UIImageView *)leftImgV
{
    if (!_leftImgV) {
        _leftImgV = [[UIImageView alloc] init];
        _leftImgV.hidden = YES;
        [self.baseImgV addSubview:_leftImgV];
    }
    return _leftImgV;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = kHexColor(0x101010);
        _titleLbl.font = kBoldFont(16);
        _titleLbl.hidden = YES;
        [self.baseImgV addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UILabel *)numLbl
{
    if (!_numLbl) {
        _numLbl = [[UILabel alloc] init];
        _numLbl.textColor = kHexColor(0x7D7D7D);
        _numLbl.font = kSysFont(14);
        _numLbl.hidden = YES;
        [self.baseImgV addSubview:_numLbl];
    }
    return _numLbl;
}

@end
