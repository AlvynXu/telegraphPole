//
//  XMSuccessView.m
//  Advertising
//
//  Created by dingqiankun on 2020/1/4.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import "XMSuccessView.h"

@interface XMSuccessView()

@property(nonatomic, strong)UIImageView *logoImgV;

@end

@implementation XMSuccessView

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
        make.width.height.equalTo(@40);
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.tipsLbl.mas_top).offset(-20);
    }];
    
    [self.tipsLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-100);
        make.width.equalTo(@(kScreenWidth - 30));
        make.height.equalTo(@21);
    }];
    
    [self.goBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(@180);
        make.top.equalTo(self.tipsLbl.mas_bottom).offset(30);
        make.height.equalTo(@40);
    }];
}

- (UIImageView *)logoImgV
{
    if (!_logoImgV) {
        _logoImgV = [[UIImageView alloc] init];
        _logoImgV.image = kGetImage(@"com_success_logo");
        [self addSubview:_logoImgV];
    }
    return _logoImgV;
}

- (UILabel *)tipsLbl
{
    if (!_tipsLbl) {
        _tipsLbl = [[UILabel alloc] init];
        _tipsLbl.textColor = kHexColor(0xFF000000);
        _tipsLbl.font = kSysFont(20);
        _tipsLbl.numberOfLines = 0;
        _tipsLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tipsLbl];
    }
    return _tipsLbl;
}

- (UIButton *)goBtn
{
    if (!_goBtn) {
        _goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _goBtn.backgroundColor = kHexColor(0xFFFFCC00);
        [_goBtn setTitleColor:kHexColor(0xFF000000) forState:UIControlStateNormal];
        _goBtn.titleLabel.font = kSysFont(18);
        _goBtn.layer.masksToBounds = YES;
        [_goBtn setTitle:@"确定" forState:UIControlStateNormal];
        _goBtn.layer.cornerRadius = 4.6;
        [self addSubview:_goBtn];
    }
    return _goBtn;
}



@end
