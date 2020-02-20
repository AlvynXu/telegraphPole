//
//  UIImage+Nomal.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/26.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Nomal)

+ (CGSize)getImageSizeWithURL:(id)URL;

+ (UIImage *)thumbnailImageForVideo:(NSString *)videoPath atTime:(NSTimeInterval)time;


@end

NS_ASSUME_NONNULL_END
