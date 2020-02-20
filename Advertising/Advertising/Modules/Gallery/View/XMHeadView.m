//
//  XMHeadView.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/18.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMHeadView.h"


@implementation XMHeadView

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
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@(kScaleH(153)));
        make.centerX.equalTo(self.mas_centerX);
    }];
    self.cycleScrollView.backgroundColor = UIColor.whiteColor;
}


- (SDCycleScrollView *)cycleScrollView
{
    if (!_cycleScrollView) {
        _cycleScrollView = [[SDCycleScrollView alloc] init];
        [self addSubview:_cycleScrollView];
    }
    return _cycleScrollView;
}




@end
