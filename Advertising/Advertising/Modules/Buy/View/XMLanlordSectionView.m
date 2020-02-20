//
//  XMLanlordSectionView.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/27.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMLanlordSectionView.h"


@interface XMLanlordSectionView ()


@end

@implementation XMLanlordSectionView

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
    [self.citySelectV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@44);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
    [self.stateSelectV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_centerX).offset(10);
//        make.width.equalTo(@131);
//        make.height.equalTo(@44);
//        make.centerY.equalTo(self.mas_centerY);
    }];
    self.stateSelectV.hidden = YES;
}



- (XMSelectCircleView *)citySelectV
{
    if (!_citySelectV) {
        _citySelectV = [[XMSelectCircleView alloc] init];
        _citySelectV.titleLbl.text = @"定位中...";
        [self addSubview:_citySelectV];
    }
    return _citySelectV;
}

- (XMSelectCircleView *)stateSelectV
{
    if (!_stateSelectV) {
        _stateSelectV.titleLbl.text = @"未售卖";
        _stateSelectV = [[XMSelectCircleView alloc] init];
        
        [self addSubview:_stateSelectV];
    }
    return _stateSelectV;
}


@end
