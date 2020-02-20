//
//  XMWelcomeView.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/20.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMWelcomeView.h"


@interface XMWelcomeView ()

@property(nonatomic, strong)UIImageView *titleImgV;

@property(nonatomic, strong)UILabel *introduceLbl;

@end

@implementation XMWelcomeView

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
    
    [self.baseImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    [self.enterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(@(230));
        make.height.equalTo(@(50));
        make.bottom.equalTo(self.mas_bottom).offset(-30);
    }];
}

- (UIImageView *)baseImgV
{
    if (!_baseImgV) {
        _baseImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _baseImgV.userInteractionEnabled = YES;
        [self addSubview:_baseImgV];
    }
    return _baseImgV;
}



- (UIButton *)enterBtn
{
    if (!_enterBtn) {
        _enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _enterBtn.backgroundColor = kMainColor;
        [_enterBtn setTitle:@"进入" forState:UIControlStateNormal];
        [_enterBtn setTitleColor:kHexColor(0xFF333333) forState:UIControlStateNormal];
        _enterBtn.titleLabel.font = kBoldFont(21);
        _enterBtn.layer.cornerRadius = 10;
        [self addSubview:_enterBtn];
    }
    return _enterBtn;
}









@end
