//
//  XMTeamProfitView.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/27.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMHomeGuidView.h"
#import "XMTeamCell.h"

@interface XMHomeGuidView ()

@end

@implementation XMHomeGuidView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
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
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(@197);
        make.height.equalTo(@78);
        make.bottom.equalTo(self.mas_bottom).offset(-197.5);
    }];
    
}

- (void)setStep:(NSInteger)step
{
    _step = step;
    if (step == 1) {
        [self.btn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(kScaleH(-197.5));
        }];
    }else{
        [self.btn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(kScaleH(-108.5));
        }];
    }
    
}

- (UIImageView *)baseImgV
{
    if (!_baseImgV) {
        _baseImgV = [UIImageView new];
        [self addSubview:_baseImgV];
    }
    return _baseImgV;
}

- (UIButton *)btn
{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setImage:kGetImage(@"home_guid_btn") forState:UIControlStateNormal];
        [self addSubview:_btn];
    }
    return _btn;
}






@end

