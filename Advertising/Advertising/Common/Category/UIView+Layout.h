//
//  UIView+Layout.h
//  CXDToolKit
//
//  Created by 陈小东 on 15/3/4.
//  Copyright (c) 2015年 ___cxd___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Layout)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic, readonly) CGFloat screenX;
@property (nonatomic, readonly) CGFloat screenY;
@property (nonatomic, readonly) CGFloat screenViewX;
@property (nonatomic, readonly) CGFloat screenViewY;
@property (nonatomic, readonly) CGRect screenFrame;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;
@property (nonatomic, readonly) CGFloat orientationWidth;
@property (nonatomic, readonly) CGFloat orientationHeight;

+ (UIView *)seperatorLine;

@end

@interface UIView(SubViews)

- (void)addSubviewWithFadeAnimation:(UIView *)subview;


@end
