//
//  UIView+Normal.m
//  Refactoring
//
//  Created by dingqiankun on 2019/5/6.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "UIView+Normal.h"

@implementation UIView (Normal)

- (void)setBorderDot:(BOOL)borderDot
{
    if (borderDot) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        [shapeLayer setBounds:self.bounds];
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame)/2)];
        [shapeLayer setStrokeColor:kHexColor(0xCCCCCC).CGColor];
        [shapeLayer setLineWidth:1];
        //  设置线宽，线间距
        [shapeLayer setLineDashPattern:@[@10,@6]];
        //  设置路径
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 0, 0);
        if (CGRectGetWidth(self.frame) > CGRectGetHeight(self.frame)) { CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.frame),0);
            
        }else{
            CGPathAddLineToPoint(path, NULL, 0,CGRectGetHeight(self.frame));
            
        }
        [shapeLayer setPath:path];
        CGPathRelease(path);
        
        //  把绘制好的虚线添加上来
        [self.layer addSublayer:shapeLayer];
    }
}

@end
