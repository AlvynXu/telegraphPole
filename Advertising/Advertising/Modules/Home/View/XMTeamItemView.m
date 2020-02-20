//
//  XMTeamHeadView.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/27.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMTeamItemView.h"

@interface XMTeamItemView()



@end

@implementation XMTeamItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self) {
        self = [super initWithFrame:frame];
        if (self) {
            [self setup];
        }
        return self;
    }
    return self;
}

// 初始化
- (void)setup
{
    [self.circleImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.qrCodeImgV.mas_top).offset(10);
        make.left.equalTo(self);
        make.width.equalTo(@(14.5));
        make.height.equalTo(@(14.5));
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.circleImgV.mas_right).offset(7.5);
        make.width.equalTo(@(120));
        make.height.equalTo(@(15));
        make.top.equalTo(self.circleImgV.mas_top);
    }];
    
    [self.numLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLbl.mas_left);
        make.height.equalTo(@(22));
        make.top.equalTo(self.titleLbl.mas_bottom).offset(8);
        make.width.equalTo(@(130));
    }];
    
    [self.qrCodeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(68));
        make.width.equalTo(@(56.5));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.qrCodeImgV.mas_left).offset(-11);
        make.height.equalTo(@(16));
        make.width.equalTo(@(50));
        make.centerY.equalTo(self.mas_centerY).offset(-10);
    }];
    
}

- (void)hideView:(BOOL)hide
{
    self.detailLbl.hidden = YES;
    self.qrCodeImgV.hidden = hide;
}

- (UIImageView *)circleImgV
{
    if (!_circleImgV) {
        _circleImgV = [[UIImageView alloc] init];
        [self addSubview:_circleImgV];
    }
    return _circleImgV;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.textColor = kHexColor(0xFF333333);
        _titleLbl.font = kSysFont(14);
        [self addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UILabel *)numLbl
{
    if (!_numLbl) {
        _numLbl = [UILabel new];
        _numLbl.textColor = kHexColor(0xFF333333);
        _numLbl.font = kBoldFont(17);
        [self addSubview:_numLbl];
    }
    return _numLbl;
}

- (UILabel *)detailLbl
{
    if (!_detailLbl) {
        _detailLbl = [UILabel new];
        _detailLbl.textColor = kHexColor(0xFF666666);
        _detailLbl.font = kSysFont(14);
        _detailLbl.hidden = YES;
        _detailLbl.text = @"去推广";
        [self addSubview:_detailLbl];
    }
    return _detailLbl;
}

- (UIImageView *)qrCodeImgV
{
    if (!_qrCodeImgV) {
        _qrCodeImgV = [[UIImageView alloc] init];
        _qrCodeImgV.image = kGetImage(@"qrcode");
        [self addSubview:_qrCodeImgV];
    }
    return _qrCodeImgV;
}


@end
