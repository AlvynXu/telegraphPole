//
//  XMSeoulController.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/2.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMSeoulController.h"

@interface XMSeoulController ()

@property(nonatomic, strong)UIScrollView *scrollV;

@property(nonatomic, strong)UIImageView *imagV;

@end

@implementation XMSeoulController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"赚钱攻略";
    [self setup];
}

- (void)setup
{
    self.scrollV.showsVerticalScrollIndicator = NO;
    [self.scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.safeEqualToTop(self.view);
        make.bottom.safeEqualToBottom(self.view);
        make.left.right.equalTo(self.view);
    }];
     
     [self.imagV mas_makeConstraints:^(MASConstraintMaker *make) {
         make.width.equalTo(@(kScreenWidth));
//         make.height.equalTo(@(kScreenHeight));
         make.left.equalTo(@0);
         make.top.equalTo(self.scrollV);
         make.bottom.equalTo(self.scrollV.mas_bottom).offset(-10);
     }];
}

- (UIImageView *)imagV
{
    if (!_imagV) {
        _imagV = [[UIImageView alloc] init];
        _imagV.image = kGetImage(@"home_seoul");
        [self.scrollV addSubview:_imagV];
    }
    return _imagV;
}


- (UIScrollView *)scrollV
{
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc] init];
        [self.view addSubview:_scrollV];
        [self.view addSubview:_scrollV];
    }
    return _scrollV;
}


@end
