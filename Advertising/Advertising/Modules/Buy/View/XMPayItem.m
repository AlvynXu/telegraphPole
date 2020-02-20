//
//  XMPayItem.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/27.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMPayItem.h"

@interface XMPayItem()



@end

@implementation XMPayItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [super initWithFrame:frame];
        [self setup];
    }
    return self;
}

// 初始化
- (void)setup
{
    [self.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@21);
        make.height.equalTo(@21);
    }];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@25);
        make.width.equalTo(@25);
        make.right.equalTo(self);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconV.mas_centerY);
        make.left.equalTo(self.iconV.mas_right).offset(15.5);
        make.right.equalTo(self.selectBtn.mas_left).offset(-10);
        make.height.equalTo(@16);
    }];
//    [[self.selectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        NSLog(@"----------******* ");
//    }];
}

- (UIImageView *)iconV
{
    if (!_iconV) {
        _iconV = [[UIImageView alloc] init];
        [self addSubview:_iconV];
    }
    return _iconV;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = kHexColor(0xFF333333);
        _titleLbl.font = kSysFont(15);
        [self addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UIButton *)selectBtn
{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:kGetImage(@"pay_normal") forState:UIControlStateNormal];
        [_selectBtn setImage:kGetImage(@"pay_select") forState:UIControlStateSelected];
        [self addSubview:_selectBtn];
    }
    return _selectBtn;
}


@end
