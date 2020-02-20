//
//  RKDisorderlyView.m
//  Refactoring
//
//  Created by dingqiankun on 2019/4/2.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMDisorderlyView.h"

@implementation XMDisorderlyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (UIImageView *)imageV
{
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        [self addSubview:_imageV];
    }
    return _imageV;
}

@end
