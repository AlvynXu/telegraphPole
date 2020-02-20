//
//  UIImageView+Nomal.h
//  Refactoring
//
//  Created by dingqiankun on 2019/4/2.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Nomal)

// 添加图片
- (void)addImage:(UIImage *)image;

// 点击图片时放大
- (void)whenTapImageViewChangeBigImage;

// 设置图片
- (void)rk_setImageUrl:(NSString *)url;

// 设置图片
- (void)rk_setimageUrl:(NSString *)url placeholder:(NSString *)placeholder;

// 获取第一真图
-(void)getMovieImage:(NSString *)videoURL;

- (UIImage *)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;


@end

NS_ASSUME_NONNULL_END
