//
//  XMMineProjectItemView.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/18.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMMineProjectItemView.h"


@interface XMMineProjectItemView ()


@property(nonatomic, strong)UIImageView *arrowImgV;

@end

@implementation XMMineProjectItemView

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
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@25);
        make.width.height.equalTo(@20);
        make.centerY.equalTo(self);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImgV.mas_right).offset(5);
        make.height.equalTo(@20);
        make.width.equalTo(@150);
        make.centerY.equalTo(self);
    }];
    
    [self.arrowImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
        make.centerY.equalTo(self);
    }];
}

- (UIImageView *)iconImgV
{
    if (!_iconImgV) {
        _iconImgV = [UIImageView new];
        _iconImgV.image = kGetImage(@"mine_project_icon");
        [self addSubview:_iconImgV];
    }
    return _iconImgV;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.textColor = kHexColor(0x101010);
        _titleLbl.font = kSysFont(15);
        _titleLbl.text = @"我的广告";
        [self addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UIImageView *)arrowImgV
{
    if (!_arrowImgV) {
        _arrowImgV = [[UIImageView alloc] init];
        _arrowImgV.image = kGetImage(@"mine_arrow_icon");
        [self addSubview:_arrowImgV];
    }
    return _arrowImgV;
}



@end
