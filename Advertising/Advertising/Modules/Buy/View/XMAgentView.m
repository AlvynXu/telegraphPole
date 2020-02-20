//
//  XMAgentView.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/29.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMAgentView.h"
#import "XMDashedRectView.h"

@interface XMAgentView()

@property(nonatomic, strong)UIImageView *imgV;
@property(nonatomic, strong)UIView *agentBanber;
@property(nonatomic, strong)UILabel *headTipsLbl;  //首发

@property(nonatomic, strong)UILabel *descipLbl;

@end

@implementation XMAgentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        [self setup];
    }
    return self;
}


// 初始化
- (void)setup
{
    self.imgV.frame = CGRectMake(0, 18.5, kScreenWidth, kScaleH(243));
    self.imgV.image = kGetImage(@"agent_logo");
    
    [self.agentBanber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@306);
        make.height.equalTo(@153);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.imgV.mas_bottom).offset(20);
    }];
    
    [self.headTipsLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@24);
        make.top.equalTo(@24);
        make.width.equalTo(@80);
        make.height.equalTo(@16.5);
    }];
    
    [self.headNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headTipsLbl.mas_right).offset(5);
        make.height.equalTo(@36.5);
        make.centerY.equalTo(self.headTipsLbl.mas_centerY);
    }];
    
    [self.balanceNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.agentBanber.mas_right).offset(-24);
        make.centerY.equalTo(self.headTipsLbl.mas_centerY);
        make.height.equalTo(@17);
        make.left.equalTo(self.headNumLbl.mas_right).offset(10);
    }];
    
    UIImageView *lineV = [[UIImageView alloc] init];
    lineV.image = kGetImage(@"border_line");
    [self.agentBanber addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@24.5);
        make.right.equalTo(self.agentBanber.mas_right).offset(-24.5);
        make.height.equalTo(@1);
        make.top.equalTo(self.headNumLbl.mas_bottom).offset(14.5);
    }];

    [self.currentMoneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@25.5);
        make.top.equalTo(lineV.mas_bottom).offset(29);
        make.height.equalTo(@25.5);
    }];
    
    [self.agentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.currentMoneyLbl);
        make.width.equalTo(@137);
        make.height.equalTo(@51);
        make.right.equalTo(self.agentBanber.mas_right).offset(-23.5);
    }];
    
    [self.oldMoneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.currentMoneyLbl);
        make.width.equalTo(self.currentMoneyLbl);
        make.height.equalTo(@12);
        make.top.equalTo(self.currentMoneyLbl.mas_bottom).offset(1);
    }];
    
    
    XMDashedRectView *dashedRectV = [XMDashedRectView new];
    dashedRectV.backgroundColor = kMainBackGroundColor;
    dashedRectV.borderColor = kHexColor(0x999999);
    dashedRectV.radius = 7;
    [self addSubview:dashedRectV];
    dashedRectV.frame = CGRectMake(0, 0, 306, 120);
    dashedRectV.centerX = kScreenWidth / 2;
    dashedRectV.bottom = kScreenHeight >= 812? kScreenHeight -  90 - 44: kScreenHeight -  90;;
    
    UILabel *tips = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 30)];
    tips.centerX = dashedRectV.centerX;
    tips.textAlignment = NSTextAlignmentCenter;
    tips.backgroundColor = kMainBackGroundColor;
    tips.centerY = dashedRectV.top;
    tips.text = @"会员权益";
    tips.font = kBoldFont(23);
    [self addSubview:tips];
    
    self.descipLbl.frame = CGRectMake(0, 0, 210, 90);
    // 判断iphonx
    self.descipLbl.bottom = kScreenHeight >= 812? kScreenHeight -  93.5 - 44: kScreenHeight -  93.5;
//    self.descipLbl.left = 57.5;
    self.descipLbl.centerX = dashedRectV.centerX;
    
    [self.oldMoneyLbl deleteLineFor:@"￥100"];
    
}





- (UILabel *)descipLbl
{
    if (!_descipLbl) {
        _descipLbl = [[UILabel alloc] init];
        _descipLbl.textColor = kHexColor(0x333333);
        _descipLbl.font = kSysFont(13);
        _descipLbl.text = @"解封团队管理权限: \n1.获得展位/地主推广高回报收益\n2.获得钱包提现权限 \n3.项目推广获项目分红收益";
        _descipLbl.numberOfLines = 0;
        [self addSubview:_descipLbl];
    }
    return _descipLbl;
}


- (UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [[UIImageView alloc] init];
        [self addSubview:_imgV];
    }
    return _imgV;
}

- (UIView *)agentBanber
{
    if (!_agentBanber) {
        _agentBanber = [[UIView alloc] init];
        _agentBanber.backgroundColor = kHexColor(0xFFF3D7);
        _agentBanber.layer.cornerRadius = 7;
        _agentBanber.layer.masksToBounds = YES;
        [self addSubview:_agentBanber];
    }
    return _agentBanber;
}

- (UILabel *)headNumLbl
{
    if (!_headNumLbl) {
        _headNumLbl = [UILabel new];
        _headNumLbl.backgroundColor = UIColor.whiteColor;
        _headNumLbl.textColor = kMainColor;
        _headNumLbl.font = kSysFont(18);
        _headNumLbl.text = @"10000名";
        _headNumLbl.layer.cornerRadius = 5;
        _headNumLbl.textAlignment = NSTextAlignmentCenter;
        [self.agentBanber addSubview:_headNumLbl];
    }
    return _headNumLbl;
}

- (UILabel *)headTipsLbl
{
    if (!_headTipsLbl) {
        _headTipsLbl = [UILabel new];
        _headTipsLbl.textColor = kHexColor(0x333333);
        _headTipsLbl.font = kSysFont(16);
        _headTipsLbl.text = @"首发限额:";
        [self.agentBanber addSubview:_headTipsLbl];
    }
    return _headTipsLbl;
}

- (UILabel *)balanceNumLbl
{
    if (!_balanceNumLbl) {
        _balanceNumLbl = [UILabel new];
        _balanceNumLbl.text = @"";
        _balanceNumLbl.textColor = kHexColor(0x8BC34A);
        _balanceNumLbl.text = @"余：32";
        _balanceNumLbl.hidden = YES;
        _balanceNumLbl.font = kSysFont(16);
        [self.agentBanber addSubview:_balanceNumLbl];
    }
    return _balanceNumLbl;
}

- (UILabel *)currentMoneyLbl
{
    if (!_currentMoneyLbl) {
        _currentMoneyLbl = [UILabel new];
        _currentMoneyLbl.textColor = kHexColor(0x8BC34A);
        _currentMoneyLbl.text = @"￥10.00";
        _currentMoneyLbl.font = kSysFont(23);
        [self.agentBanber addSubview:_currentMoneyLbl];
    }
    return _currentMoneyLbl;
}

- (UILabel *)oldMoneyLbl
{
    if (!_oldMoneyLbl) {
        _oldMoneyLbl = [UILabel new];
        _oldMoneyLbl.text = @"￥198.0";
        _oldMoneyLbl.textColor = kHexColor(0x999999);
        _oldMoneyLbl.font = kSysFont(12);
        [self.agentBanber addSubview:_oldMoneyLbl];
    }
    return _oldMoneyLbl;
}

- (UIButton *)agentBtn
{
    if (!_agentBtn) {
        _agentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _agentBtn.backgroundColor = kHexColor(0x8BC34A);
        _agentBtn.layer.cornerRadius = 15;
        _agentBtn.layer.masksToBounds = YES;
        [_agentBtn setEnabled:NO];
        [_agentBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_agentBtn setTitle:@"升级会员" forState:UIControlStateNormal];
        [self.agentBanber addSubview:_agentBtn];
    }
    return _agentBtn;
}


@end
