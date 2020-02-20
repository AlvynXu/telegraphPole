//
//  XMSelectCircleView.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/27.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMSelectCircleView.h"

@implementation XMSelectCircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = 1;
        self.layer.borderColor = kHexColor(0xFFDCDCDC).CGColor;
        self.layer.cornerRadius = 22;
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.height.equalTo(@16);
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-28);
    }];
    
    [self.arrowImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLbl.mas_right).offset(10).priorityHigh();
        make.width.equalTo(@8);
        make.height.equalTo(@4.5);
        make.right.equalTo(self.mas_right).offset(-20).priorityHigh();
        make.centerY.equalTo(self.titleLbl.mas_centerY);
    }];
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = kHexColor(0xFF333333);
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.font = kSysFont(15);
        [self addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UIImageView *)arrowImgV
{
    if (!_arrowImgV) {
        _arrowImgV = [[UIImageView alloc] init];
        _arrowImgV.image = kGetImage(@"arrow_down");
        [self addSubview:_arrowImgV];
    }
    return _arrowImgV;
}


@end
