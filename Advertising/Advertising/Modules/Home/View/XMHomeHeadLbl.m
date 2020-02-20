//
//  XMHomeHeadLbl.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/26.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMHomeHeadLbl.h"

@interface XMHomeHeadLbl ()

@property(nonatomic, strong)UILabel *uplbl;

@property(nonatomic, strong)UILabel *downlbl;

@end

@implementation XMHomeHeadLbl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        self.tap = tap;
        [self addGestureRecognizer:tap];
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self.uplbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(self);
        make.height.equalTo(@(kScaleH(17)));
    }];
    
    [self.downlbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScaleH(17)));
        make.top.equalTo(self.uplbl.mas_bottom).offset(kScaleH(5));
    }];
    
    [self.noReadLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.uplbl.mas_right).offset(5);
        make.top.equalTo(self).offset(-7);
        make.height.equalTo(@(kScaleH(8)));
        make.width.equalTo(@(kScaleW(8)));
    }];
}

- (void)setDownStr:(NSString *)downStr
{
    _downStr = downStr;
    self.downlbl.text = downStr;
}

- (void)setUpStr:(NSString *)upStr
{
    _upStr = upStr;
    self.uplbl.text = upStr;
}


- (UILabel *)downlbl
{
    if (!_downlbl) {
        _downlbl = [[UILabel alloc] init];
        _downlbl.textColor = kHexColor(0xFF333333);
        _downlbl.font = kSysFont(14);
        _downlbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_downlbl];
    }
    return _downlbl;
}


- (UILabel *)uplbl
{
    if (!_uplbl) {
        _uplbl = [[UILabel alloc] init];
        _uplbl.textColor = kHexColor(0xFF333333);
        _uplbl.font = kBoldFont(17);
        _uplbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_uplbl];
    }
    return _uplbl;
}

- (UILabel *)noReadLbl
{
    if (!_noReadLbl) {
        _noReadLbl = [[UILabel alloc] init];
        _noReadLbl.layer.cornerRadius = 4;
        _noReadLbl.layer.masksToBounds = YES;
        _noReadLbl.backgroundColor = UIColor.redColor;
        _noReadLbl.hidden = YES;
        [self addSubview:_noReadLbl];
        
    }
    return _noReadLbl;
}


@end
