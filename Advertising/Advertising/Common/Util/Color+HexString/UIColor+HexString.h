//
//  UIColor+HexString.h
//  WPD
//
//  Created by zhangtibin on 15/7/28.
//  Copyright (c) 2015年 Huarong Wealth Manage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)

+ (UIColor *) colorWithHexString: (NSString *) hexString;
+ (UIColor *)colorWithIntValue:(int)intValue;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIColor *)barBackgroundColor;
+ (UIColor *) colorWithHexString: (NSString *) hexString AndAlpa:(float) apl;
@end
