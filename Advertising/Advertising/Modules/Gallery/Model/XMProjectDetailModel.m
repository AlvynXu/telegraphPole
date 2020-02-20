//
//  XMProjectDetailModel.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/18.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMProjectDetailModel.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>


@implementation XMProjectListItemModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"desc":@"description"};
}

- (CGFloat)descHeight
{
    if (!self.desc) {
        return 0;
    }
    return [self.desc getStringHeightWithText:self.desc font:kSysFont(16) viewWidth:kScreenWidth - 30] + 15;
}

- (void)initOtherParam
{
    if (self.type == 2) {
        self.imgHeight = (kScreenWidth - 30) * [UIImage getImageSizeWithURL:[NSURL URLWithString:self.filePath]].height / [UIImage getImageSizeWithURL:[NSURL URLWithString:self.filePath]].width;
    }
    if (self.type == 3) {   // 获取图片尺寸大小  获取视频封面以及url
        // 获取图片封面
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:self.filePath] options:nil];
            AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
            gen.appliesPreferredTrackTransform = YES;
            CMTime time = CMTimeMakeWithSeconds(0.0, 600);
            NSError *error = nil;
            CMTime actualTime;
            CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
            UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
            CGImageRelease(image);
            self.thumbnail_img = thumb;
        });
    }
}


@end

@implementation XMProjectDetailModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"desc":@"description", @"Id":@"id"};
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"detailList":@"XMProjectListItemModel"};
}

- (CGFloat)addressHeight
{
    if (!self.addressDetail) {
        return 0;
    }
    return [self.desc getStringHeightWithText:self.addressDetail font:kSysFont(14) viewWidth:kScreenWidth - 100];
}


- (CGFloat)descHeight
{
    if (!self.desc) {
        return 0;
    }
    return [self.desc getStringHeightWithText:self.desc font:kBoldFont(18) viewWidth:kScreenWidth - 25];
}

@end


//

@implementation XMProjectMessageItemModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id":@"id"};
}




- (CGFloat)messageHeight
{
    if (!self.message) {
        return 0;
    }
    // 文字内容高度 +顶部15高度+间隙高度+名称高度+底部距离
    return [self.message getStringHeightWithText:self.message font:kSysFont(14) viewWidth:kScreenWidth - 75] + 15 +10 + 14 + 10;
}

@end


@implementation XMProjectGetMessageModel

- (NSString *)totalStr
{
    if (self.total > 99) {
        return @"99+";
    }
    return kFormat(@"%zd", self.total);
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"records":@"XMProjectMessageItemModel"};
}


@end

