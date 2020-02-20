//
//  XMSectionTitleView.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/16.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMSectionTitleView.h"

@interface XMSectionTitleView()

@property(nonatomic, strong)UIImageView *logoImgV;

@property(nonatomic, strong)UILabel *titleLbl;

@end

@implementation XMSectionTitleView

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
    [self.logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.width.equalTo(@55);
        make.height.equalTo(@25);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoImgV.mas_right).offset(7);
        make.centerY.equalTo(self.logoImgV);
        make.width.equalTo(@120);
        make.height.equalTo(@30);
    }];
}

- (UIImageView *)logoImgV
{
    if (!_logoImgV) {
        _logoImgV = [[UIImageView alloc] init];
        _logoImgV.image = kGetImage(@"top_stories");
        [self addSubview:_logoImgV];
    }
    return _logoImgV;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.text = @"电线竿头条";
        _titleLbl.textColor = kHexColor(0x4D4D4D);
        _titleLbl.font = kBoldFont(20);
        [self addSubview:_titleLbl];
    }
    return _titleLbl;
}




@end
