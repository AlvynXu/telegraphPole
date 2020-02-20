//
//  XMNinvitationView.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/30.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMNinvitationView.h"

@interface XMNinvitationView()

@property(nonatomic, strong)UIImageView *logoImgV;

@property(nonatomic, strong)UIImageView *iconImgV;

@property(nonatomic, strong)UILabel *titleLbl;

@property(nonatomic, strong)UILabel *tipsLbl;

@end


@implementation XMNinvitationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

// 初始化
-(void)setup
{
    CGFloat left = 40;
    CGFloat top = 90;
    
    [self.logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@0);
        make.width.equalTo(@133);
        make.height.equalTo(@89);
    }];
    
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImgV.mas_bottom).offset(top);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
        make.left.equalTo(@(left));
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImgV.mas_right).offset(14);
        make.centerY.equalTo(self.iconImgV.mas_centerY);
        make.width.equalTo(@110);
        make.height.equalTo(@20);
    }];
    
    [self.invitationTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImgV);
        make.right.equalTo(self.mas_right).offset(-left);
        make.height.equalTo(@50);
        make.top.equalTo(self.titleLbl.mas_bottom).offset(30);
    }];
    
    [self.tipsLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.invitationTxt);
        make.right.equalTo(self.invitationTxt);
        make.height.equalTo(@16);
        make.top.equalTo(self.invitationTxt.mas_bottom).offset(15);
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.invitationTxt);
        make.height.equalTo(@45);
        make.top.equalTo(self.tipsLbl.mas_bottom).offset(40);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@25);
        make.top.equalTo(@25);
        make.width.equalTo(@17);
        make.height.equalTo(@25);
    }];
}

- (UIImageView *)logoImgV
{
    if (!_logoImgV) {
        _logoImgV = [[UIImageView alloc] init];
        _logoImgV.image = kGetImage(@"login_title_icon");
        [self addSubview:_logoImgV];
    }
    return _logoImgV;
}

- (UIImageView *)iconImgV
{
    if (!_iconImgV) {
        _iconImgV = [UIImageView new];
        _iconImgV.image = kGetImage(@"login_input_code");
        [self addSubview:_iconImgV];
    }
    return _iconImgV;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.text = @"输入邀请码";
        _titleLbl.textColor = kHexColor(0xFF333333);
        _titleLbl.font = kSysFont(14);
        [self addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (TPPasswordTextView *)invitationTxt
{
    if (!_invitationTxt) {
        _invitationTxt = [TPPasswordTextView new];
        _invitationTxt.elementCount = 6;
        _invitationTxt.elementBorderColor = UIColor.clearColor;
        _invitationTxt.elementMargin = 8;
        [self addSubview:_invitationTxt];
    }
    return _invitationTxt;
}

- (UILabel *)tipsLbl
{
    if (!_tipsLbl) {
        _tipsLbl = [UILabel new];
        _tipsLbl.textColor = kHexColor(0xFF363636);
        _tipsLbl.font = kSysFont(12);
        _tipsLbl.text = @"VIP制，请向好友索要邀请码(6位数字)";
        [self addSubview:_tipsLbl];
    }
    return _tipsLbl;
}

- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = kBoldFont(15);
        [_sureBtn setTitleColor:kHexColor(0xffffff) forState:UIControlStateNormal];
        _sureBtn.layer.cornerRadius = 8;
        _sureBtn.backgroundColor = kHexColor(0xFFDBDBDB);
        _sureBtn.layer.masksToBounds = YES;
        [_sureBtn setEnabled:NO];
        [self addSubview:_sureBtn];
    }
    return _sureBtn;
}

- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:kGetImage(@"drawback") forState:UIControlStateNormal];
        _backBtn.hidden = YES;
        [self addSubview:_backBtn];
    }
    return _backBtn;
}


@end
