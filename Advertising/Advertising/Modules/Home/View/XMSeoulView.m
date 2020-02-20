//
//  XMSeoulView.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/25.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMSeoulView.h"

@interface XMSeoulView()

@property(nonatomic, strong)UIImageView *imageV;

@property(nonatomic, strong)UILabel *titleLbl;

@property(nonatomic, assign)CGPoint startPoint;

@end

@implementation XMSeoulView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //允许用户交互
        self.userInteractionEnabled = YES;
//        self.layer.cornerRadius = 25;
////        self.layer.masksToBounds = YES;
//        self.layer.shadowOffset = CGSizeZero;//默认为0,-3
//        self.layer.shadowColor = kHexColor(0xBBBBBB).CGColor;
        self.backgroundColor = UIColor.clearColor;
        [self setup];
    }
    return self;
}

// 初始化
- (void)setup
{
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@85);
        make.height.equalTo(@50);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageV.mas_right).offset(15);
        make.width.equalTo(@(100));
        make.height.equalTo(@(40));
        make.centerY.equalTo(self.mas_centerY);
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //保存触摸起始点位置
    CGPoint point = [[touches anyObject] locationInView:self];
    _startPoint = point;
    
    //该view置于最前
    [[self superview] bringSubviewToFront:self];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //计算位移=当前位置-起始位置
    CGPoint point = [[touches anyObject] locationInView:self];
//    float dx = point.x - _startPoint.x;
    float dy = point.y - _startPoint.y;
    
    //计算移动后的view中心点
//    __block CGPoint newcenter = CGPointMake(self.center.x + dx, self.center.y + dy);
    __block CGPoint newcenter = CGPointMake(self.center.x, self.center.y + dy);
    
    /* 限制用户不可将视图托出屏幕 */
//    float halfx = CGRectGetMidX(self.bounds);
//    float halfx = CGRectGetMaxX(self.bounds);
    
//     NSLog(@"--------------  %lf", halfx);
    //x坐标左边界
//    newcenter.x = MAX(halfx, newcenter.x);
//    //x坐标右边界
//    newcenter.x = MIN(self.superview.bounds.size.width - halfx, newcenter.x);
//    newcenter.x = kScreenWidth + 300;
    
    //y坐标同理
    float halfy = CGRectGetMidY(self.bounds);
    newcenter.y = MAX(halfy, newcenter.y);
    newcenter.y = MIN(self.superview.bounds.size.height - halfy, newcenter.y);
    
//    newcenter.x = kScreenWidth;/
    
    [UIView animateWithDuration:0.2 animations:^{
        if (newcenter.y < 64) {
            newcenter.y = 84;
        }
        if (newcenter.y > kScreenHeight - 64) {
            newcenter.y = kScreenHeight - 64 - halfy;
        }
        
        //移动view
        self.center = newcenter;
    }];
}


- (UIImageView *)imageV
{
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
//        _imageV.hidden = YES;
        _imageV.image = kGetImage(@"home_head_line");
        [self addSubview:_imageV];
    }
    return _imageV;
}

//- (UILabel *)titleLbl
//{
//    if (!_titleLbl) {
//        _titleLbl = [[UILabel alloc] init];
//        _titleLbl.text = @"上头条";
////        _titleLbl.font = kBoldFont(22);
//        _titleLbl.textColor = kHexColor(0xFF0000);
//        _titleLbl.font = [UIFont italicSystemFontOfSize:22];
//        _titleLbl.numberOfLines = 0;
//        [self addSubview:_titleLbl];
//    }
//    return _titleLbl;
//}


@end
