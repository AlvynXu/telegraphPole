//
//  XMShareController.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/4.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMShareController.h"
#import "XMAPPShareUtil.h"
#import "XMShareUtils.h"
#import "PurchaseCarAnimationTool.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@interface XMShareController ()<CAAnimationDelegate>

@property(nonatomic, strong)UIImageView *baseImgV;

@property(nonatomic, strong)UIButton *saveBtn;  //保存

@property(nonatomic, strong)UIButton *shareBtn;  // 分享

@property(nonatomic, strong)UILabel *invitationTipsLbl;

@property(nonatomic, strong)UILabel *invitationLbl;

@property(nonatomic, strong)CALayer *subLayer;  // 子

@property(nonatomic, strong)XMAPPShareRequest *shareRequest;  // 请求

@property(nonatomic, strong)UIImageView *qrCodeImgV;  // 二维码

@property(nonatomic, strong)XMAPPShareModel *model;  // 模型


@property(nonatomic, strong)UIImageView *animationSaveImgV;  // 二维码
@property(nonatomic, strong)UIView *animationBaeImgV;  // 二维码

@property(nonatomic, strong)UIButton *downBtn;

//shar_down_app

@end

@implementation XMShareController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self loadData];
}

// 初始化
- (void)setup
{
    self.navigationItem.title = @"分享";
    [self.baseImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.safeEqualToTop(self.view);
        make.bottom.safeEqualToBottom(self.view);
    }];
     
     [self.downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.equalTo(self.baseImgV.mas_right).offset(kScaleW(-14.5));
         make.top.equalTo(@(kScaleW(15.5)));
         make.width.equalTo(@(kScaleW(60)));
         make.height.equalTo(@(kScaleW(30)));
     }];

    
    [self.qrCodeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.baseImgV.mas_right).offset(-20);
        make.width.height.equalTo(@100);
        make.bottom.equalTo(self.baseImgV.mas_bottom).offset(kScaleH(-170));
    }];

    
    [self.invitationTipsLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.qrCodeImgV.mas_centerX);
        make.height.equalTo(@20);
        make.width.equalTo(self.qrCodeImgV.mas_width);
        make.top.equalTo(self.qrCodeImgV.mas_bottom).offset(15);
    }];
    
    [self.invitationLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.qrCodeImgV.mas_centerX);
        make.top.equalTo(self.invitationTipsLbl.mas_bottom).offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(self.qrCodeImgV.mas_width);
    }];
    
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kScaleW(27.5)));
        make.height.equalTo(@(kScaleH(45)));
        make.width.equalTo(@(kScaleW(145)));
        make.bottom.safeEqualToBottom(self.view).offset(kScaleH(-11.5));
    }];
    
    
    @weakify(self)
    [[self.saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (![self isCanUsePhotos]) {
            [XMHUD showText:@"请到设置页面打开访问相册权限"];
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Photos"]];
        }else{
            [self loadImageFinished:[self captureImageFromView:self.baseImgV]];
        }
        
    }];
    
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(kScaleW(-27.5));
        make.height.width.equalTo(self.saveBtn);
        make.bottom.equalTo(self.saveBtn.mas_bottom);
    }];
    
    [[self.shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (![self.model.url isEmpty]) {
            NSURL *shareUrl = [NSURL URLWithString:self.model.url];
            [XMShareUtils goShareWith:@[kApp_Name, shareUrl]];
        }
    }];
    
    // 下载
    [[self.downBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.model.ios]];
    }];
}
// 获取分享数据
- (void)loadData
{
    [self.view showLoading];
    @weakify(self)
    [self.shareRequest startWithCompletion:^(__kindof XMAPPShareRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        [self.view hideLoading];
        if (request.businessSuccess) {
            self.model = request.businessModel;
            self.invitationLbl.text = self.model.promoterId;
//            self.qrCodeImgV.image = [self base64ToImage:self.model.imageBase64];
        }
    }];
}

- (UIImage *)base64ToImage:(NSString *)base64
{
    NSData *_decodedImageData = [[NSData alloc] initWithBase64EncodedString:base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *_decodedImage = [UIImage imageWithData:_decodedImageData];
    return _decodedImage;
}



#pragma mark ------  保存图片到本地成功
- (void)loadImageFinished:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
        [self saveImageAnimation:image];
    }
    if (error.code == -3310) {
        [XMHUD showText:@"请到设置页面打开访问相册权限"];
    }
    
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}


#pragma mark -----  保存图片动画

-(void)saveImageAnimation:(UIImage *)image
{
    
    UIView *_baseV = [[UIView alloc] initWithFrame:self.view.bounds];
    _baseV.backgroundColor = kHexColorA(0xffffff, 0.6);
    self.animationBaeImgV = _baseV;
    [self.view addSubview:_baseV];
    
    UIImageView *saveImgV = [[UIImageView alloc] initWithFrame:CGRectMake(40, 100, kScreenWidth-40*2, kScreenHeight - 100 * 2)];
    self.animationSaveImgV = saveImgV;
    saveImgV.image = image;
    saveImgV.layer.borderWidth = 20;
    saveImgV.layer.borderColor = UIColor.whiteColor.CGColor;
    saveImgV.layer.cornerRadius = 8;
    self.subLayer = saveImgV.layer;
    [self.view.layer addSublayer:self.subLayer];
    
    [self performSelector:@selector(startAnimation:) withObject:saveImgV afterDelay:0.8];
    
    
    
}

- (void)startAnimation:(UIImageView *)saveImgV
{
    if (self.animationBaeImgV.superview) {
        [self.animationBaeImgV removeFromSuperview];
    }
    if (self.subLayer.superlayer) {
        [self.subLayer removeFromSuperlayer];
    }
    [[PurchaseCarAnimationTool shareTool] startAnimationandView:saveImgV
                                                           rect:saveImgV.frame
                                                    finisnPoint:CGPointMake(30,kScreenHeight - 50)
                                                    finishBlock:^(BOOL finish) {
                                                        [XMHUD showSuccess:@"已保存至相册"];
                                                    }];
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


//截图功能
-(UIImage *)captureImageFromView:(UIView *)view
{
    CGRect rect = view.bounds;
    UIGraphicsBeginImageContextWithOptions(rect.size,YES, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshotImage;
}


- (UIImageView *)baseImgV
{
    if (!_baseImgV) {
        _baseImgV = [[UIImageView alloc] init];
        _baseImgV.image = kGetImage(@"share_base");
        _baseImgV.userInteractionEnabled = YES;
        [self.view addSubview:_baseImgV];
    }
    return _baseImgV;
}


- (UILabel *)invitationTipsLbl
{
    if (!_invitationTipsLbl) {
        _invitationTipsLbl = [UILabel new];
        _invitationTipsLbl.text = @"我的码子";
        _invitationTipsLbl.textAlignment = NSTextAlignmentCenter;
        _invitationTipsLbl.font = kBoldFont(20);
        _invitationTipsLbl.textColor = UIColor.whiteColor;
        [self.baseImgV addSubview:_invitationTipsLbl];
    }
    return _invitationTipsLbl;
}

- (UILabel *)invitationLbl
{
    if (!_invitationLbl) {
        _invitationLbl = [UILabel new];
        _invitationLbl.textAlignment = NSTextAlignmentCenter;
        _invitationLbl.textColor = kHexColor(0xff8601);
        _invitationLbl.font = kBoldFont(20);
        [self.baseImgV addSubview:_invitationLbl];
    }
    return _invitationLbl;
}

- (UIButton *)saveBtn
{
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn setImage:kGetImage(@"share_save_btn") forState:UIControlStateNormal];
        [self.view addSubview:_saveBtn];
    }
    return _saveBtn;
}


- (UIButton *)shareBtn
{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:kGetImage(@"share_url_btn") forState:UIControlStateNormal];
        [self.view addSubview:_shareBtn];
    }
    return _shareBtn;
}

- (XMAPPShareRequest *)shareRequest
{
    if (!_shareRequest) {
        _shareRequest = [XMAPPShareRequest request];
    }
    return _shareRequest;
}

- (UIImageView *)qrCodeImgV
{
    if (!_qrCodeImgV) {
        _qrCodeImgV = [UIImageView new];
        _qrCodeImgV.backgroundColor = kHexColorA(0xffffff, 0.7);
        _qrCodeImgV.image = kGetImage(@"share_qrcode");
        [self.baseImgV addSubview:_qrCodeImgV];
    }
    return _qrCodeImgV;
}

- (UIButton *)downBtn
{
    if (!_downBtn) {
        _downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_downBtn setImage:kGetImage(@"shar_down_app") forState:UIControlStateNormal];
        _downBtn.hidden = YES;
        [self.baseImgV addSubview:_downBtn];
    }
    return _downBtn;
}


@end
