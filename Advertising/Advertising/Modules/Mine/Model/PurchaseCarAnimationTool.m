//
//  PurchaseCarAnimationTool.m
//  PruchaseCarAnimation
//
//  Created by zhenyong on 16/8/17.
//  Copyright © 2016年 com.demo. All rights reserved.
//
#import "AppDelegate.h"
#import "PurchaseCarAnimationTool.h"
@interface PurchaseCarAnimationTool()<CAAnimationDelegate>

@end

@implementation PurchaseCarAnimationTool
#pragma mark - instancetype
+ (instancetype)shareTool
{
    return [[PurchaseCarAnimationTool alloc]init];
}
#pragma public function
- (void)startAnimationandView:(UIView *)view
                         rect:(CGRect)rect
                  finisnPoint:(CGPoint)finishPoint
                  finishBlock:(animationFinisnBlock)completion
{
    //图层
    _layer = [CALayer layer];
    _layer.contents = view.layer.contents;
    _layer.contentsGravity = kCAGravityResizeAspectFill;
    _layer.bounds = rect;
    _layer.borderWidth = 20;
    _layer.cornerRadius  = 8;
    _layer.borderColor = UIColor.whiteColor.CGColor;
    _layer.masksToBounds = YES;          //圆角
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow.layer addSublayer:_layer];
//    _layer.position = CGPointMake(rect.origin.x+view.frame.size.width/2, CGRectGetMidY(rect)); //a 点
    _layer.position = CGPointMake(rect.origin.x+view.frame.size.width/2, CGRectGetMidY(rect));; //a 点
    /// 路径
    [self createAnimationwithRect:rect finishPoint:finishPoint];
    /// 回调
    if (completion) {
        _animationFinisnBlock = completion;
    }
}
+ (void)shakeAnimation:(UIView *)shakeView
{
//    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
//    shakeAnimation.duration = 0.25f;
//    shakeAnimation.fromValue = [NSNumber numberWithFloat:-5];
//    shakeAnimation.toValue = [NSNumber numberWithFloat:5];
//    shakeAnimation.autoreverses = YES;
//    [shakeView.layer addAnimation:shakeAnimation forKey:nil];
}
#pragma mark - private function
/// 创建动画
- (void)createAnimationwithRect:(CGRect)rect
                    finishPoint:(CGPoint)finishPoint {
    /// 路径动画
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:_layer.position];
    [path addQuadCurveToPoint:finishPoint controlPoint:CGPointMake(ScreenWidth/2, rect.origin.y-80)];
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.path = path.CGPath;
    /// 缩放动画
    CABasicAnimation *rotateAnimation   = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    rotateAnimation.removedOnCompletion = YES;
    rotateAnimation.fromValue = [NSNumber numberWithFloat:1];
    rotateAnimation.toValue   = [NSNumber numberWithFloat:0.2];
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    /// 添加动画动画组合
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[pathAnimation,rotateAnimation];
    groups.duration = 1.2f;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [_layer addAnimation:groups forKey:@"group"];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == [_layer animationForKey:@"group"]) {
        [_layer removeFromSuperlayer];
        _layer = nil;
        if (_animationFinisnBlock) {
            _animationFinisnBlock(YES);
        }
    }
}
@end
