//
//  UITextView+PlaceHolder.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/20.
//  Copyright © 2019 rongshu. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UITextView (PlaceHolder)


/** 占位文字 */
@property (copy, nonatomic) NSString *placeHoldString;

/** 占位文字颜色 */
@property (strong, nonatomic) UIColor *placeHoldColor;

/** 占位文字字体 */
@property (strong, nonatomic) UIFont *placeHoldFont;


@end

NS_ASSUME_NONNULL_END
