//
//  MovEncodeToMpegTool.m
//  TZImagePickerControllerDemo
//
//  Created by 徐小龙 on 2019/11/11.
//  Copyright © 2019 Liyn. All rights reserved.
//

#pragma mark - WeakSelf/StrongSelf

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define StrongSelf(strongSelf) __strong __typeof(&*self) strongSelf = weakSelf;

#import <Photos/Photos.h>

#import "MovEncodeToMpegTool.h"

@implementation MovEncodeToMpegTool

#pragma mark ### MOV转码MP4

/// 转码 MOV--MP4
/// @param urlAsset MOV资源
/// @param fileUrlHandler 转码后的MP4文件链接
+ (void)convertMovToMp4FromAVURLAsset:(AVURLAsset*)urlAsset
                  andCompeleteHandler:(void(^)(NSURL *fileUrl))fileUrlHandler{
    
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:urlAsset.URL options:nil];
    
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    /*
     AVAssetExportPresetLowQuality        低质量 可以通过移动网络分享
     AVAssetExportPresetMediumQuality     中等质量 可以通过WIFI网络分享
     AVAssetExportPresetHighestQuality    高等质量
     AVAssetExportPreset640x480
     AVAssetExportPreset960x540
     AVAssetExportPreset1280x720    720pHD
     AVAssetExportPreset1920x1080   1080pHD
     AVAssetExportPreset3840x2160
     */
    //中等质量 可以通过WIFI网络分享
    if ([compatiblePresets containsObject:AVAssetExportPresetMediumQuality]) {
        
        //  在Documents目录下创建一个名为FileData的文件夹
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"Cache/VideoData"];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDir = FALSE;
        BOOL isDirExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
        if(!(isDirExist && isDir)) {
            BOOL bCreateDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
            if(!bCreateDir){
                NSLog(@"创建文件夹失败！%@",path);
            }
            NSLog(@"创建文件夹成功，文件路径%@",path);
        }
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [formatter setDateFormat:@"yyyy_MM_dd_HH_mm_ss"]; //每次启动后都保存一个新的文件中
        NSString *dateStr = [formatter stringFromDate:[NSDate date]];
        
        NSString *resultPath = [path stringByAppendingFormat:@"/%@.mp4",dateStr];
        NSLog(@"file path:%@",resultPath);
        
        NSLog(@"resultPath = %@",resultPath);
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset
                                                                               presetName:AVAssetExportPresetMediumQuality];
        exportSession.outputURL = [NSURL fileURLWithPath:resultPath];
        exportSession.outputFileType = AVFileTypeMPEG4;
        exportSession.shouldOptimizeForNetworkUse = YES;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
         {
            switch (exportSession.status) {
                case AVAssetExportSessionStatusUnknown:
                    NSLog(@"AVAssetExportSessionStatusUnknown");
                    fileUrlHandler(nil);
                    break;
                case AVAssetExportSessionStatusWaiting:
                    NSLog(@"AVAssetExportSessionStatusWaiting");
                    fileUrlHandler(nil);
                    break;
                case AVAssetExportSessionStatusExporting:
                    NSLog(@"AVAssetExportSessionStatusExporting");
                    fileUrlHandler(nil);
                    break;
                case AVAssetExportSessionStatusCompleted:
                    NSLog(@"AVAssetExportSessionStatusCompleted");
                    fileUrlHandler(exportSession.outputURL);
                    break;
                case AVAssetExportSessionStatusFailed:
                    NSLog(@"AVAssetExportSessionStatusFailed");
                    fileUrlHandler(nil);
                    break;
                    
                case AVAssetExportSessionStatusCancelled:
                    NSLog(@"AVAssetExportSessionStatusCancelled");
                    fileUrlHandler(nil);
                    break;
            }
        }];
    }
}
@end
