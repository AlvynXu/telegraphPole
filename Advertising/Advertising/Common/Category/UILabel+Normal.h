//
//  UILabel+Normal.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/30.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Normal)

// 改变字符串颜色
- (void)changeStr:(NSString *)changeStr color:(UIColor *)color font:(UIFont *)font;


// 添加中划线
- (void)deleteLineFor:(NSString *)content;

/**
 设置文本,并指定行间距
 
 @param text 文本内容
 @param lineSpacing 行间距
 */
-(void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;

@end

NS_ASSUME_NONNULL_END
