//
//  XMCustomerController.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/5.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMCustomerController.h"

@interface XMCustomerController ()

@property(nonatomic, strong)UIImageView *imageV;

@property(nonatomic, strong)UILabel *numLbl;

@property(nonatomic, strong)UIImageView *qrCodeImgV;

@end

@implementation XMCustomerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"客服";
    [self setup];
}

// 初始化
- (void)setup
{
    // 图片
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.safeEqualToTop(self.view);
        make.height.equalTo(@(kScaleH(261)));
        make.width.equalTo(@(kScreenWidth));
        make.left.equalTo(self.view);
    }];
    
    // 二维码
    [self.qrCodeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageV.mas_bottom).offset(18);
        make.width.equalTo(@159);
        make.height.equalTo(@159);
        make.centerX.equalTo(self.view);
    }];
    
    // 微信号
    [self.numLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@20);
        make.width.equalTo(@200);
        make.top.equalTo(self.qrCodeImgV.mas_bottom).offset(13);
    }];
}

- (UIImageView *)imageV
{
    if (!_imageV) {
        _imageV = [UIImageView new];
        _imageV.image = kGetImage(@"wecaht_top_icon");
        [self.view addSubview:_imageV];
    }
    return _imageV;
}

- (UILabel *)numLbl
{
    if (!_numLbl) {
        _numLbl = [UILabel new];
        _numLbl.textColor = kHexColor(0xFF000000);
        _numLbl.font = kSysFont(15);
        _numLbl.text = @"客服微信号：w1222500";
        _numLbl.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_numLbl];
    }
    return _numLbl;
}

- (UIImageView *)qrCodeImgV
{
    if (!_qrCodeImgV) {
        _qrCodeImgV = [UIImageView new];
        _qrCodeImgV.image = kGetImage(@"wechat_custom_icon");
        [self.view addSubview:_qrCodeImgV];
    }
    return _qrCodeImgV;
}



@end
