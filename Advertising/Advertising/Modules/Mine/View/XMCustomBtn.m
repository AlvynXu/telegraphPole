//
//  XMCustomBtn.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/18.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMCustomBtn.h"

@interface XMCustomBtn()



@end

@implementation XMCustomBtn

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
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@40);
        make.top.equalTo(self);
        make.centerX.equalTo(self);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgV.mas_bottom).offset(7);
        make.width.equalTo(self);
        make.centerX.equalTo(self);
        make.height.equalTo(@20);
    }];
}

- (UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [[UIImageView alloc] init];
        _imgV.userInteractionEnabled = YES;
        [self addSubview:_imgV];
    }
    return _imgV;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.userInteractionEnabled = YES;
        _titleLbl.textColor = kHexColor(0x101010);
        _titleLbl.font = kSysFont(13);
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLbl];
    }
    return _titleLbl;
}



@end
