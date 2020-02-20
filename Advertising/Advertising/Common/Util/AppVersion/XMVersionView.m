//
//  XMVersionView.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/14.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMVersionView.h"

@interface XMVersionView ()

@property(nonatomic, strong)UIImageView *baseImgV;

@property(nonatomic, strong)UILabel *titleLbl;


@end

@implementation XMVersionView

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
    [self.baseImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@115);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.top.equalTo(@30);
        make.width.equalTo(@120);
        make.height.equalTo(@25);
    }];
    
    [self.versionLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLbl);
        make.top.equalTo(self.titleLbl.mas_bottom).offset(10);
        make.height.equalTo(@15);
        make.right.equalTo(self.mas_right).offset(-30);
    }];
    
    [self.contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseImgV.mas_bottom).offset(40);
        make.left.equalTo(@30);
        make.right.equalTo(self.mas_right).offset(-30);
        make.bottom.equalTo(self.mas_bottom).offset(-40);
    }];
}


- (UIImageView *)baseImgV
{
    if (!_baseImgV) {
        _baseImgV = [[UIImageView alloc] init];
        _baseImgV.image = kGetImage(@"version_base");
        [self addSubview:_baseImgV];
    }
    return _baseImgV;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.font = kBoldFont(23);
        _titleLbl.text = @"版本介绍";
        _titleLbl.textColor = kHexColor(0x212121);
        [self addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UILabel *)versionLbl
{
    if (!_versionLbl) {
        _versionLbl = [UILabel new];
        _versionLbl.textColor = kHexColor(0x212121);
        _versionLbl.font = kBoldFont(14);
//        _versionLbl.text = @"当前版本：V1.0.5";
        [self addSubview:_versionLbl];
    }
    return _versionLbl;
}

- (UILabel *)contentLbl
{
    if (!_contentLbl) {
        _contentLbl = [[UILabel alloc] init];
        _contentLbl.numberOfLines = 0;
        _contentLbl.textColor = kHexColor(0x212121);
        _contentLbl.font = kSysFont(14);
//        _contentLbl.text = @"1.谁知道更新了什么功能\n2.第二个功能和第一个功能很像的\n3.第三个功能和第二个功能很像的like busi";
        [self addSubview:_contentLbl];
    }
    return _contentLbl;
}



@end
