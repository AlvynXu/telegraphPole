//
//  XMBackGroundImageV.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/20.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBackGroundImageV.h"

@interface XMBackGroundImageV ()

@property(nonatomic, strong)UIImageView *shadeImgV;  //遮罩

@property(nonatomic, strong)UIImageView *logoImgV;

@end

@implementation XMBackGroundImageV

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = kGetImage(@"map");
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self.shadeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kScaleH(60)));
        make.width.equalTo(@(kScaleW(70)));
        make.height.equalTo(@(kScaleH(54.5)));
        make.centerX.equalTo(self.mas_centerX);
    }];
}


// 遮罩
- (UIImageView *)shadeImgV
{
    if (!_shadeImgV) {
        _shadeImgV = [[UIImageView alloc] init];
        _shadeImgV.backgroundColor = kRGB(80, 80, 80);
//        _shadeImgV.image = kGetImage(@"shade");
        _shadeImgV.userInteractionEnabled = YES;
        [self addSubview:_shadeImgV];
    }
    return _shadeImgV;
}

- (UIImageView *)logoImgV
{
    if (!_logoImgV) {
        _logoImgV = [[UIImageView alloc] init];
//        _logoImgV.image = kGetImage(@"logo");
        [self addSubview:_logoImgV];
    }
    return _logoImgV;
}





@end
