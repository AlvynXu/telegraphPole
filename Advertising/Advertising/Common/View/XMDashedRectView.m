//
//  XMDashedRectView.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/2.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMDashedRectView.h"

@implementation XMDashedRectView

- (void)drawRect:(CGRect)rect {
    
    // 线的宽度
    
    CGFloat lineWidth = 1.4;
    
    // 根据线的宽度 设置画线的位置
    
    CGRect rect1 =  CGRectMake(lineWidth * 0.5, lineWidth * 0.5, rect.size.width - lineWidth , rect.size.height - lineWidth);
    
    // 获取图像上下文
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 设置线的宽度
    
    CGContextSetLineWidth(context, lineWidth);
    
    // 设置线的颜色
    if (_borderColor) {
        CGContextSetStrokeColorWithColor(context, _borderColor.CGColor);
    }else{
        CGContextSetStrokeColorWithColor(context, UIColor.redColor.CGColor);
    }
    
    
    // 设置虚线和实线的长度
    
    CGFloat lengths[] = { 2.5, 1.5 };
    
    CGContextSetLineDash(context, 0, lengths,1);
    
    // CGContextSetLineDash(context, 0, lengths, 1);
    
    // 画矩形path 圆角5度
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect1 cornerRadius:_radius?_radius:5];
    
    // 添加到图形上下文
    
    CGContextAddPath(context, bezierPath.CGPath);
    
    // 渲染
    
    CGContextStrokePath(context);
    
}

@end
