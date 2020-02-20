//
//  XMBuyStateView.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/28.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBuyStateView.h"

@interface XMBuyStateView()

@property(nonatomic, strong)UIImageView *logoImgV;

@property(nonatomic, strong)UIImageView *line1;

@property(nonatomic, strong)UIImageView *line2;

@end

@implementation XMBuyStateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

// 初始化
- (void)setup
{
    [self.logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@62.5);
        make.height.equalTo(@62.5);
        make.top.equalTo(@38);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(kScreenWidth - 30));
        make.height.equalTo(@62.5);
        make.top.equalTo(self.logoImgV.mas_bottom).offset(27.5);
    }];
    
    [self.oneLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@45);
        make.right.equalTo(self.mas_right).offset(-45);
        make.height.equalTo(@58.5);
        make.top.equalTo(self.titleLbl.mas_bottom).offset(70);
    }];
    
    UIImageView *line1 = [UIImageView new];
    line1.image = kGetImage(@"border_line");
    self.line1 = line1;
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.oneLbl);
        make.height.equalTo(@1);
        make.top.equalTo(self.oneLbl.mas_bottom);
    }];

    [self.twoLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oneLbl);
        make.width.equalTo(self.oneLbl);
        make.height.equalTo(self.oneLbl);
        make.top.equalTo(line1.mas_bottom);
    }];



    UIImageView *line2 = [UIImageView new];
    self.line2 = line2;
    line2.image = kGetImage(@"border_line");
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.oneLbl);
        make.height.equalTo(@1);
        make.top.equalTo(self.twoLbl.mas_bottom);
    }];
    
    [self.threeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oneLbl);
        make.width.equalTo(self.oneLbl);
        make.height.equalTo(self.oneLbl);
        make.top.equalTo(line2.mas_bottom);
    }];

    UIImageView *line3 = [UIImageView new];
    self.line3 = line3;
    line3.image = kGetImage(@"border_line");
    [self addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.oneLbl);
        make.height.equalTo(@1);
        make.top.equalTo(self.threeLbl.mas_bottom);
    }];
    
}


- (void)agentView
{
    [self.goBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@176.5);
        make.height.equalTo(@46.5);
        make.bottom.equalTo(self.mas_bottom).offset(-58);
    }];
}

- (void)hideSomeView
{
    self.oneLbl.hidden = YES;
    self.twoLbl.hidden = YES;
    self.threeLbl.hidden = YES;
    self.line1.hidden = YES;
    self.line2.hidden = YES;
    self.line3.hidden = YES;
    
    [self.goBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@176.5);
        make.height.equalTo(@46.5);
        make.centerY.equalTo(self.mas_centerY).offset(30);
    }];
}


- (UIImageView *)logoImgV
{
    if (!_logoImgV) {
        _logoImgV = [UIImageView new];
        _logoImgV.image = kGetImage(@"success_buy");
        [self addSubview:_logoImgV];
    }
    return _logoImgV;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.textColor = kHexColor(0x333333);
        _titleLbl.font = kBoldFont(21);
        _titleLbl.text = kFormat(@"恭喜您，荣升为%@会员", kApp_Name);
        [self addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UILabel *)oneLbl
{
    if (!_oneLbl) {
        _oneLbl = [UILabel new];
        _oneLbl.textColor = kHexColor(0x333333);
        _oneLbl.font = kSysFont(15);
        _oneLbl.text = @"权益: 全网代理";
        _oneLbl.hidden = YES;
        [self addSubview:_oneLbl];
    }
    return _oneLbl;
}

- (UILabel *)twoLbl
{
    if (!_twoLbl) {
        _twoLbl = [UILabel new];
        _twoLbl.textColor = kHexColor(0x333333);
        _twoLbl.font = kSysFont(15);
        _twoLbl.text = @"期限: 永久";
        [self addSubview:_twoLbl];
    }
    return _twoLbl;
}

- (UILabel *)threeLbl
{
    if (!_threeLbl) {
        _threeLbl = [UILabel new];
        _threeLbl.textColor = kHexColor(0x333333);
        _threeLbl.font = kSysFont(15);
        _threeLbl.hidden = YES;
        [self addSubview:_threeLbl];
    }
    return _threeLbl;
}

- (UIButton *)goBtn
{
    if (!_goBtn) {
        _goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _goBtn.backgroundColor = kHexColor(0x8BC34A);
        _goBtn.titleLabel.font = kBoldFont(16);
        _goBtn.layer.cornerRadius = 23.25;
        [_goBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_goBtn setTitle:@"好的" forState:UIControlStateNormal];
        [self addSubview:_goBtn];
    }
    return _goBtn;
}


@end
