//
//  XMPublishController.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/15.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMPublishController.h"
#import "XMPublishCell.h"
#import "XMPublishHeadFootView.h"
#import "JXMovableCellTableView.h"
#import "ZFPlayer.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "TZImagePickerController.h"
#import "XMPublishBaseInfoHeadView.h"
#import "XMPublishHeadFootView.h"
#import "XMPublishDetailModel.h"
#import "XMPublishItemModel.h"
#import "MovEncodeToMpegTool.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "XMSelectCategoryView.h"
#import "XMPublishRequest.h"
#import "XMMyAdvertController.h"
#import "XMSuccessController.h"
#import "UIImage+Nomal.h"
#import "XMProjectDetailRequest.h"


@interface XMPublishController ()<JXMovableCellTableViewDataSource, JXMovableCellTableViewDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate, TZImagePickerControllerDelegate>

@property (nonatomic, strong) JXMovableCellTableView *tableView;

@property(nonatomic, strong)NSMutableArray *dataSource;

@property(nonatomic, strong)XMPublishBaseInfoHeadView *headVew;

@property(nonatomic, assign)BOOL coverImg;  //判断当前选中的是不是封面图

@property(nonatomic, strong)XMPublishDetailModel *baseModel;  // 详情基本信息
@property(nonatomic, strong)XMSelectCategoryView *selectCategoryV;  // 选择类别
@property(nonatomic, strong)XMSaveBaseInfoRequest *baseInfoRequest;  // 基础信息
@property(nonatomic, strong)XMSaveDetailInfoRequest *detailInfoRequest;  // 详细

// 临时变量
@property(nonatomic, assign)NSInteger baseInfoId;  // 基本信息Id
@property(nonatomic, assign)NSInteger replaceImgRow;  // 替换图片的当前行

@property(nonatomic, assign)BOOL noError; // 发布时没有错误

@property(nonatomic, strong)XMProjectDetailRequest *detailRequest;  // 详情

@property(nonatomic, strong)UIButton *publishBtn;


@end

@implementation XMPublishController

static NSString *const publishCellId = @"publishCellId_cellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self bind];
    if (self.teamId>0) {
        [self _loadData];
    }
}

// 加载数据
- (void)_loadData
{
    self.detailRequest.itemId = self.teamId;
    [self.tableView showLoading];
    [self.view showLoading];
    @weakify(self)
    [self.detailRequest startWithCompletion:^(__kindof XMProjectDetailRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        [self.view hideLoading];
        if (request.businessSuccess) {
            XMProjectDetailModel *projectDetailModel = request.businessModel;
             self.baseInfoRequest.pId = projectDetailModel.Id;
            [self _resetBaseInfo:projectDetailModel];
            [self _addModelData:projectDetailModel.detailList];
        }
        [self.tableView hideLoadingWithRequest:request];
    }];
}

// 显示基本信息
- (void)_resetBaseInfo:(XMProjectDetailModel *)projectDetailModel
{
    self.headVew.phoneTxt.text = projectDetailModel.phone;
    self.headVew.titleTxtV.text = projectDetailModel.desc;
    self.headVew.addressTxtV.text = projectDetailModel.addressDetail;
    [self.headVew.showImgV sd_setImageWithURL:[NSURL URLWithString:projectDetailModel.bannerPath] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.baseModel.coverImg = image;
    }];
    self.baseModel.categoryId = projectDetailModel.categoryId;
    [self.headVew.selectCategoryBtn setTitle:@"告白墙" forState:UIControlStateNormal];
    self.baseModel.catename  = @"告白墙";
    self.baseModel.phone =  projectDetailModel.phone;
    self.baseModel.title = projectDetailModel.desc;
    self.baseModel.address = projectDetailModel.addressDetail;
}

// 显示详情信息
- (void)_addModelData:(NSArray *)modelArray
{
    for (XMProjectListItemModel *itemListModel in modelArray) {
        XMPublishItemModel *itemModel = [XMPublishItemModel new];
        itemModel.type = itemListModel.type;
        
        if (itemListModel.type == 2) {
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:itemListModel.filePath]];
            itemModel.coverImage = [UIImage imageWithData:data];
        }
        if (itemListModel.type == 3) {
            itemModel.movieUrl = [NSURL URLWithString:itemListModel.filePath];
            itemModel.coverImage = [UIImage thumbnailImageForVideo:itemListModel.filePath atTime:1];
        }
        if (itemListModel.type == 1) {
            itemModel.content = itemListModel.desc;
        }
        
        [self.dataSource addObject:itemModel];
    }
}


// 绑定
- (void)bind
{
    // 手机号/微信
    RAC(self.baseModel, phone) = self.headVew.phoneTxt.rac_textSignal;
    RAC(self.baseModel, title) = self.headVew.titleTxtV.rac_textSignal;
    RAC(self.baseModel, address) = self.headVew.addressTxtV.rac_textSignal;
}
// 初始化
- (void)setup
{
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"编辑";
    self.dataSource = [NSMutableArray array];
    _tableView = [[JXMovableCellTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIView *headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.01)];
    self.tableView.tableHeaderView = headV;
    [self.view addSubview:_tableView];

    _tableView.longPressGesture.minimumPressDuration = 0.6;
    [_tableView registerClass:[XMPublishCell class] forCellReuseIdentifier:publishCellId];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setEditing:YES animated:YES];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.safeEqualToTop(self.view);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(0);
    }];
    _tableView.backgroundColor = UIColor.whiteColor;
    
    // 点击选择类别
    @weakify(self)
    [[self.headVew.selectCategoryBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.selectCategoryV show];
    }];
    
    // 选择类别回调
    [self.selectCategoryV.subject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        NSDictionary *dict = x;
        [self.headVew.selectCategoryBtn setTitle:dict[@"title"] forState:UIControlStateNormal];
        self.baseModel.categoryId = [dict[@"cateId"] integerValue];
        self.baseModel.catename = dict[@"title"];
    }];
    
    // 发布
    UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [publishBtn setTitle:@"发布" forState:UIControlStateNormal];
    [publishBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    self.publishBtn = publishBtn;
    publishBtn.titleLabel.font = kSysFont(15);
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:publishBtn];
    [publishBtn addTarget:self action:@selector(handPublishAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(handPublishAction)];
//    [barItem setTintColor:kMainColor];
    self.navigationItem.rightBarButtonItem = barItem;
}

// 发布
- (void)handPublishAction:(UIButton *)sender
{
    [sender setEnabled:NO];
    if ([NSString isEmpty:self.baseModel.catename] ) {
        [XMHUD showText:@"请选择分类"];
        return ;
    }
    if (!self.baseModel.coverImg) {
        [XMHUD showText:@"请选择封面图"];
        return ;
    }
    if ([NSString isEmpty:self.baseModel.title] ) {
        [XMHUD showText:@"标题不能为空"];
        return ;
    }
    if ([NSString isEmpty:self.baseModel.phone] ) {
        [XMHUD showText:@"手机号/微信不能为空"];
        return ;
    }
    if ([NSString isEmpty:self.baseModel.address] ) {
        [XMHUD showText:@"地址不能为空"];
        return ;
    }
    if (self.dataSource.count == 0) {
        [XMHUD showText:@"请选择一种详情内容发布"];
        return;
    }
    // 发送信息
    self.baseInfoRequest.categoryId = self.baseModel.categoryId;
    self.baseInfoRequest.desc = self.baseModel.title;
    self.baseInfoRequest.addressDetail = self.baseModel.address;
    self.baseInfoRequest.phone = self.baseModel.phone;
    self.baseInfoRequest.multipartFile = UIImageJPEGRepresentation(self.baseModel.coverImg, 0.7);
    // 第一步 上传基本信息
    [self.tableView showLoadigWith:@"正在为您上传基本信息..."];
    [self.baseInfoRequest startWithCompletion:^(__kindof XMSaveBaseInfoRequest * _Nonnull request, NSError * _Nonnull error) {
        self.noError = YES;
        [self.tableView hideLoading];
        if (request.businessSuccess) {
            self.baseInfoId = [request.businessData[@"id"] integerValue];
            [self.tableView showLoadigWith:@"正在为您上传详情..."];
            [self uploadFile];
        }else{
            [sender setEnabled:YES];
            [XMHUD showFail:request.businessMessage];
            self.noError = NO;
        }
    }];
}

// 第二步上传文件信息
- (void)uploadFile
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    for (int i = 0; i < self.dataSource.count; i++) {
        dispatch_group_async(group, queue, ^{
            XMSaveDetailInfoRequest * detailInfoRequest = XMSaveDetailInfoRequest.request;
            detailInfoRequest.seq = i;
            XMPublishItemModel *itemModel = self.dataSource[i];
            if (itemModel.type==1) {
                detailInfoRequest.desc = [NSString isEmpty:itemModel.content]?@" ":itemModel.content;
            }
            detailInfoRequest.itemId = self.baseInfoId;
            detailInfoRequest.type = itemModel.type;
            if (itemModel.type==2) {
                detailInfoRequest.multipartFile = UIImageJPEGRepresentation(itemModel.coverImage, 0.7);
            }
            if (itemModel.type==3) {
                detailInfoRequest.multipartFile = [NSData dataWithContentsOfURL:itemModel.movieUrl];
            }
            [detailInfoRequest startWithCompletion:^(__kindof XMSaveDetailInfoRequest * _Nonnull request, NSError * _Nonnull error) {
                if (request.businessSuccess) {
                    
                }else{
                    [XMHUD showFail:request.businessMessage];
                    self.noError = NO;
                }
            }];
        });
    }
    // 数据请求完毕
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.publishBtn setEnabled:YES];
        [self.tableView hideLoading];
        if (self.noError) {
            [XMHUD showSuccess:@"上传完毕"];
            XMSuccessController *successVC = [XMSuccessController new];
            successVC.type = XMSuccessTypePublish;
            [self.navigationController pushViewController:successVC animated:YES];
        }
    });
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.headVew.frame = CGRectMake(0, 0, kScreenWidth, 520);
    self.headVew.showImgV.image = self.baseModel.coverImg?:kGetImage(@"select_img_icon");
    UITapGestureRecognizer *selectImgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handSelctImgAction)];
    [self.headVew.showImgV addGestureRecognizer:selectImgTap];
    return self.headVew;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 554;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 77;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    XMPublishHeadFootView *footHeadV = [XMPublishHeadFootView headerFooterViewWithTabelView:tableView];
    [footHeadV.txtBtn addTarget:self action:@selector(handAddTxtAction:) forControlEvents:UIControlEventTouchUpInside];
    [footHeadV.imageBtn addTarget:self action:@selector(handAddImgAction:) forControlEvents:UIControlEventTouchUpInside];
    [footHeadV.movieBtn addTarget:self action:@selector(handAddMovieAction:) forControlEvents:UIControlEventTouchUpInside];
    

    return footHeadV;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMPublishCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:publishCellId forIndexPath:indexPath];
    XMPublishItemModel *itemModel = self.dataSource[indexPath.row];
    tableViewCell.itemModel = itemModel;
    [tableViewCell.selectImgBtn addTarget:self action:@selector(handAddImgAction:) forControlEvents:UIControlEventTouchUpInside];
    tableViewCell.selectImgBtn.tag = 2019+indexPath.row;
    tableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableViewCell.delBtn.tag=2019+indexPath.row;
    [tableViewCell.delBtn addTarget:self action:@selector(handleDelAction:) forControlEvents:UIControlEventTouchUpInside];
    tableViewCell.playBtn.tag = 2019+indexPath.row;
    [tableViewCell.playBtn addTarget:self action:@selector(handPlayAction:) forControlEvents:UIControlEventTouchUpInside];
    return tableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.dataSource exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
}

- (void)tableView:(JXMovableCellTableView *)tableView didMoveCellFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [self.dataSource exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}


#pragma mark --------- 单击事件

// 选择封面图片
- (void)handSelctImgAction
{
    self.coverImg = YES;
    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePicker.preferredLanguage = @"zh-Hans";
    // 是否显示可选原图按钮
    imagePicker.allowPickingOriginalPhoto = NO;
    // 是否允许显示视频
    imagePicker.allowPickingVideo = NO;
    // 是否允许显示图片
    imagePicker.allowPickingImage = YES;
    imagePicker.cropRect = CGRectMake(kScreenWidth/2-135, kScreenHeight / 2-80, 135*2, 80*2);
    imagePicker.allowCrop = YES;
    // 这是一个navigation 只能present
    [self presentViewController:imagePicker animated:YES completion:nil];
}

// 添加文字
- (void)handAddTxtAction:(UIButton *)sender
{
    XMPublishItemModel *itemModel = [XMPublishItemModel new];
    itemModel.type = 1;
    [self.dataSource addObject:itemModel];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView reloadData];
}
// 添加图片
- (void)handAddImgAction:(UIButton *)sender
{
    if (sender.tag>=2019) {
        self.replaceImgRow = sender.tag -2019;  // 用户点击的是当前cell的图
    }else{
        self.replaceImgRow = -1;  // 用户点击的是封面图
    }
    [self selectPicture];
}

// 添加视频
- (void)handAddMovieAction:(UIButton *)sender
{
    [self selectMovie];
}

// 播放
- (void)handPlayAction:(UIButton *)sender
{
    NSInteger row = sender.tag - 2019;
    XMPublishItemModel *item = self.dataSource[row];
    AVPlayerViewController *playerController = [[AVPlayerViewController alloc] init];
    playerController.player = [AVPlayer playerWithURL:item.movieUrl];
    [self presentViewController:playerController animated:YES completion:nil];
    [playerController player];
}

// 删除
- (void)handleDelAction:(UIButton *)sender
{
    NSInteger row =  sender.tag - 2019;
    [self.dataSource removeObjectAtIndex:row];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView reloadData];
}


#pragma mark ---------  选择图片回调
// 详情选择图片
- (void)selectPicture
{
    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    imagePicker.preferredLanguage = @"zh-Hans";
    // 是否显示可选原图按钮
    imagePicker.allowPickingOriginalPhoto = NO;
    // 是否允许显示视频
    imagePicker.allowPickingVideo = NO;
    // 是否允许显示图片
    imagePicker.allowPickingImage = YES;
//    imagePicker.cropRect = CGRectMake(0, kScreenHeight / 2-kScreenWidth/2, kScreenWidth, kScreenWidth);
//    imagePicker.allowCrop = YES;
    // 这是一个navigation 只能present
    [self presentViewController:imagePicker animated:YES completion:nil];
}

// 选择照片的回调
-(void)imagePickerController:(TZImagePickerController *)picker
      didFinishPickingPhotos:(NSArray<UIImage *> *)photos
                sourceAssets:(NSArray *)assets
       isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    if (self.coverImg) {
        // 获取封面图之后刷新
        self.baseModel.coverImg = photos.firstObject;
        [self.tableView reloadData];
    }else{
        // 替换修改
        if (self.replaceImgRow < self.dataSource.count && self.replaceImgRow >= 0) {
            XMPublishItemModel *itemModel = self.dataSource[self.replaceImgRow];
            itemModel.coverImage = photos.firstObject;
            [self.tableView reloadData];
        }else{
            // 添加模型
            for (int i = 0; i < photos.count; i++) {
                XMPublishItemModel *itemModel = [XMPublishItemModel new];
                itemModel.type = 2;
                itemModel.coverImage = photos[i];
                [self.dataSource addObject:itemModel];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0];
                [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
            }
        }
    }
    self.coverImg=NO;
}

#pragma mark ---------  选择视频回调

- (void)selectMovie
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    imagePickerVc.allowPickingImage = NO;
    [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage *coverImage, PHAsset *asset) {
    
        /// 包含该视频的基础信息
        PHAssetResource * resource = [[PHAssetResource assetResourcesForAsset: asset] firstObject];
        
        NSMutableArray *resourceArray = nil;
        
        if (@available(iOS 13.0, *)) {
            
            NSString *string1 = [resource.description stringByReplacingOccurrencesOfString:@" - " withString:@" "];
            
            NSString *string2 = [string1 stringByReplacingOccurrencesOfString:@": " withString:@"="];
            
            NSString *string3 = [string2 stringByReplacingOccurrencesOfString:@"{" withString:@""];
            
            NSString *string4 = [string3 stringByReplacingOccurrencesOfString:@"}" withString:@""];
            
            NSString *string5 = [string4 stringByReplacingOccurrencesOfString:@", " withString:@" "];
            
            resourceArray = [NSMutableArray arrayWithArray:[string5 componentsSeparatedByString:@" "]];
            
            [resourceArray removeObjectAtIndex:0];
            
            [resourceArray removeObjectAtIndex:0];
            
        } else {
            
            NSString *string1 = [resource.description stringByReplacingOccurrencesOfString:@"{" withString:@""];
            
            NSString *string2 = [string1 stringByReplacingOccurrencesOfString:@"}" withString:@""];
            
            NSString *string3 = [string2 stringByReplacingOccurrencesOfString:@", " withString:@","];
            
            resourceArray = [NSMutableArray arrayWithArray:[string3 componentsSeparatedByString:@" "]];
            
            [resourceArray removeObjectAtIndex:0];
            
            [resourceArray removeObjectAtIndex:0];
            
        }
        
        NSMutableDictionary *videoInfo = [[NSMutableDictionary alloc] init];
        
        for (NSString *string in resourceArray) {
            
            NSArray *array = [string componentsSeparatedByString:@"="];
            
            videoInfo[array[0]] = array[1];
            
        }
        
        videoInfo[@"duration"] = @(asset.duration).description;
        
        NSLog(@"%@",videoInfo);
        
        /*
         {
         assetLocalIdentifier = "A99AA1C3-7D59-4E10-A8D3-BF4FAD7A1BC6/L0/001";
         fileSize = 2212572;
         filename = "IMG_0049.MOV";
         size = "1080,1920";
         type = video;
         uti = "com.apple.quicktime-movie";
         }
         */
        
        
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
        
        options.version = PHImageRequestOptionsVersionCurrent;
        
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        
        
        @weakify(self)
        PHImageManager *manager = [PHImageManager defaultManager];
        [manager requestAVAssetForVideo:asset
                                options:options
                          resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                              
                              @strongify(self)
                              
                              NSString *sizeString = videoInfo[@"size"];
                              
                              NSArray *array = [sizeString componentsSeparatedByString:@","];
                              
                              CGSize size = CGSizeMake([array[0] floatValue], [array[1] floatValue]);
                              
                              [self choseVedioCompeletWithVedioAsset:(AVURLAsset *)asset
                                                             andAVAudioMix:audioMix
                                                              andVedioInfo:info
                                                              andImageSize:size];
                              
                          }];
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

/// 收到转码结束回调
/// @param urlAsset 转码源文件
/// @param audioMix 转码源文件音频
/// @param vedioInfo 视频信息
/// @param size 视频文件大小
- (void)choseVedioCompeletWithVedioAsset:(AVURLAsset *)urlAsset
                           andAVAudioMix:(AVAudioMix *)audioMix
                            andVedioInfo:(NSDictionary *)vedioInfo
                            andImageSize:(CGSize)size{
    @weakify(self);
    dispatch_async(dispatch_queue_create(0, 0), ^{
        @strongify(self)
        // 子线程执行任务（比如获取较大数据）
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view showLoadigWith:@"处理视频数据"];
        });
    });
    
    [MovEncodeToMpegTool convertMovToMp4FromAVURLAsset:urlAsset
                                   andCompeleteHandler:^(NSURL * _Nonnull fileUrl) {
                          @strongify(self)
                       [self addVideoToTableCompeletWithVedioAsset:urlAsset
                                                     andAVAudioMix:audioMix
                                                      andVedioInfo:vedioInfo
                                                      andImageSize:size
                                                     andMP4FileUrl:fileUrl];
                                       
                                   }];
    
    
}

//1024*1024 MiByte 字节
#define VideoSizeMax  1024*1024

/// 收到转码结束回调
/// @param urlAsset 转码源文件
/// @param audioMix 转码源文件音频
/// @param vedioInfo 视频信息
/// @param size 视频文件大小
/// @param MP4FileUrl 转码后视频文件链接
- (void)addVideoToTableCompeletWithVedioAsset:(AVURLAsset *)urlAsset
                                andAVAudioMix:(AVAudioMix *)audioMix
                                 andVedioInfo:(NSDictionary *)vedioInfo
                                 andImageSize:(CGSize)size
                                andMP4FileUrl:(NSURL *)MP4FileUrl{
    if (MP4FileUrl == nil || MP4FileUrl.path == nil) {
        NSLog(@"视频获取失败") ;
        return;
    }
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
    generator.maximumSize = CGSizeMake(size.width, size.height);
    NSError *error = nil;
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 10) actualTime:NULL error:&error];
    // 截取 封面
    UIImage *image = [UIImage imageWithCGImage:img];
    NSLog(@"%@",image);
    NSError *mp4Rrror = nil;
    // 检查文件属性 查看文件大小 是否超标
    NSDictionary *infoDict = [[NSFileManager defaultManager]attributesOfItemAtPath:MP4FileUrl.path error:&mp4Rrror];
    NSString *fileSizeString = infoDict[@"NSFileSize"];
    @weakify(self)
    dispatch_async(dispatch_queue_create(0, 0), ^{
        @strongify(self)
        // 子线程执行任务（比如获取较大数据）
        dispatch_async(dispatch_get_main_queue(), ^{
           [self.view hideLoading];
        });
    });
    if (fileSizeString && !error) {
        NSInteger fileSize = fileSizeString.integerValue;
        // 检查转码后的视频大小，压缩率一般可以达到5-10
        // 视频限制大小 单位兆字节 MiByte
        NSInteger capacity = 15;
        if (fileSize>VideoSizeMax*capacity) {
            [XMHUD showText:@"视频不能超过15M"];
            // 删除已转码的视频
            [[NSFileManager defaultManager] removeItemAtPath:MP4FileUrl.path error:&error];
        }else{
            
//            __weak __typeof(self) weakself= self;
            @weakify(self)
            dispatch_async(dispatch_queue_create(0, 0), ^{
                @strongify(self)
                // 子线程执行任务（比如获取较大数据）
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 添加模型
                    XMPublishItemModel *itemModel = [XMPublishItemModel new];
                    itemModel.type = 3;
                    itemModel.movieUrl = MP4FileUrl;
                    itemModel.coverImage = image;
                    [self.dataSource addObject:itemModel];
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0];
                    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
                });
            });
        }
    }
    else{
        NSLog(@"视频获取失败");
        [[NSFileManager defaultManager] removeItemAtPath:MP4FileUrl.path error:&error];
    }
    
}

- (XMPublishDetailModel *)baseModel
{
    if (!_baseModel) {
        _baseModel = [XMPublishDetailModel new];
    }
    return _baseModel;
}


- (XMPublishBaseInfoHeadView *)headVew
{
    if (!_headVew) {
        _headVew = [XMPublishBaseInfoHeadView new];
    }
    return _headVew;
}

- (XMSelectCategoryView *)selectCategoryV
{
    if (!_selectCategoryV) {
        _selectCategoryV = [[XMSelectCategoryView alloc] initWithFrame:kWindow.bounds];
    }
    return _selectCategoryV;
}

- (XMSaveBaseInfoRequest *)baseInfoRequest
{
    if (!_baseInfoRequest) {
        _baseInfoRequest = [XMSaveBaseInfoRequest request];
        _baseInfoRequest.pId = -1992;
    }
    return _baseInfoRequest;
}

- (XMSaveDetailInfoRequest *)detailInfoRequest
{
    if (!_detailInfoRequest) {
        _detailInfoRequest = [XMSaveDetailInfoRequest request];
    }
    return _detailInfoRequest;
}

- (XMProjectDetailRequest *)detailRequest
{
    if (!_detailRequest) {
        _detailRequest = [XMProjectDetailRequest request];
    }
    return _detailRequest;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
