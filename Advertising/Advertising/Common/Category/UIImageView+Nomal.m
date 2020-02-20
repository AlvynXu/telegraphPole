//
//  UIImageView+Nomal.m
//  Refactoring
//
//  Created by dingqiankun on 2019/4/2.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "UIImageView+Nomal.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

static CGRect oldframe;

@interface UIImageView ()

@property(nonatomic, strong)UIButton *saveImgBtn;

@end

@implementation UIImageView (Nomal)


- (void)addImage:(UIImage *)image
{
    //防止图片被拉伸
    // 左端盖宽度
    NSInteger leftCapWidth = image.size.width * 0.5f;
    // 顶端盖高度
    NSInteger topCapHeight = image.size.height * 0.5f;
    // 重新赋值
    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    self.image = image;
}

- (void)whenTapImageViewChangeBigImage
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImage)];
    [self addGestureRecognizer:tap];
}

- (void)magnifyImage{
    [self showImage];
}

- (void)showImage{
    UIImage *image=self.image;
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    
    UIView    *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0,
                                                                      0,
                                                                      [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    oldframe = [self
                convertRect:self.bounds toView:window];
    backgroundView.backgroundColor=[UIColor
                                    blackColor];
    backgroundView.alpha=0;
    UIImageView
    *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image = image;
    imageView.tag = 1;
    [backgroundView
     addSubview:imageView];
    [window
     addSubview:backgroundView];
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView
     addGestureRecognizer: tap];
    [UIView
     animateWithDuration:0.3
     animations:^{
         imageView.frame = CGRectMake(0,([UIScreen
                                          mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2,
                                      [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
         backgroundView.alpha=1;
     }
     completion:^(BOOL finished) {
         
     }];
}

- (void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView
    *imageView=(UIImageView*)[tap.view viewWithTag:1];
    
    [UIView
     animateWithDuration:0.3
     animations:^{
         imageView.frame = oldframe;
         backgroundView.alpha=0;
     }
     completion:^(BOOL finished) {
         [backgroundView
          removeFromSuperview];
     }];
}



- (void)rk_setImageUrl:(NSString *)url
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
}

- (void)rk_setimageUrl:(NSString *)url placeholder:(NSString *)placeholder;
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder.isEmpty ? nil : kGetImage(placeholder)];
}

-(void)getMovieImage:(NSString *)videoURL
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoURL] options:nil];
        
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        
        gen.appliesPreferredTrackTransform = YES;
        
        CMTime time = CMTimeMakeWithSeconds(0.0, 600);
        
        NSError *error = nil;
        
        CMTime actualTime;
        
        CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
        
        UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
        
        CGImageRelease(image);
        
        dispatch_async(dispatch_get_main_queue(), ^{
             self.image = thumb;
        });
        
    });
   
}



// 保存图片
- (void)handSaveAction
{
    if (![self isCanUsePhotos]) {
        [XMHUD showText:@"请到设置页面打开访问相册权限"];
    }else{
        UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    }
}

// 判断用户相机权限
- (BOOL)isCanUsePhotos {
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        ALAuthorizationStatus author =[ALAssetsLibrary authorizationStatus];
        if (author == kCLAuthorizationStatusRestricted || author == kCLAuthorizationStatusDenied) {
            //无权限
            return NO;
        }
    }
    else {
        
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted ||
            status == PHAuthorizationStatusDenied) {
            //无权限
            return NO;
        }
    }
    return YES;
}



@end

