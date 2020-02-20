//
//  MovEncodeToMpegTool.h
//  TZImagePickerControllerDemo
//
//  Created by 徐小龙 on 2019/11/11.
//  Copyright © 2019 Liyn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AVURLAsset;

@interface MovEncodeToMpegTool : NSObject
/// 转码 MOV--MP4
/// @param urlAsset MOV资源
/// @param fileUrlHandler 转码后的MP4文件链接
+ (void)convertMovToMp4FromAVURLAsset:(AVURLAsset*)urlAsset
                  andCompeleteHandler:(void(^)(NSURL *fileUrl))fileUrlHandler;
@end


