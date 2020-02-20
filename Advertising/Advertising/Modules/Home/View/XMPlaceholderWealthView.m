//
//  XMPlaceholderWealthView.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/16.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMPlaceholderWealthView.h"
#import "UIImage+GIF.h"

@interface XMPlaceholderWealthView()

@property(nonatomic, strong)UIImageView *baseImgV;

@end

@implementation XMPlaceholderWealthView

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
    [self.baseImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    [self.placeholderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"home_agent" ofType:@"gif"];
//    NSData *data = [NSData dataWithContentsOfFile:path];
//
//    UIImage *gifImg = [UIImage sd_imageWithGIFData:data];;
    self.baseImgV.image = kGetImage(@"home_name_card");
}

- (UIImageView *)baseImgV
{
    if (!_baseImgV) {
        _baseImgV = [[UIImageView alloc] init];
        _baseImgV.userInteractionEnabled = YES;
        _baseImgV.image = kGetImage(@"landlord_base");
        [self addSubview:_baseImgV];
    }
    return _baseImgV;
}


- (UIButton *)placeholderBtn
{
    if (!_placeholderBtn) {
        _placeholderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _placeholderBtn.backgroundColor = UIColor.clearColor;
        [self.baseImgV addSubview:_placeholderBtn];
    }
    return _placeholderBtn;
}



@end
