//
//  XMProjectDetailController.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/18.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMProjectDetailController.h"
#import "XMProjectDetailRequest.h"
#import "XMProjectHeadView.h"
#import "XMProjectDetailCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import "XMBoothManagerController.h"
#import <ZFPlayer/ZFPlayer.h>
#import "ZFAVPlayerManager.h"
#import <ZFPlayer/ZFPlayerControlView.h>
#import "XMAdvertRequest.h"
#import "XMShareUtils.h"
#import "XMProjectBootomView.h"

#import "XMPublishController.h"
#import "XMMessageBoardCell.h"

#import "XMMessageBoardView.h"

@interface XMProjectDetailController()

@property(nonatomic, strong)XMProjectHeadView *headV;

@property(nonatomic, strong)XMProjectDetailRequest *detailRequest;

@property(nonatomic, strong)XMProjectDetailModel *detailModel;  // 头部信息

@property(nonatomic, strong)NSArray *dataSource;  // 数据源

@property(nonatomic, strong)UIButton *collectBtn;  // 收藏按钮

@property(nonatomic, strong)XMProjectDownRequest *downRequest;  //下架
@property(nonatomic, strong)XMProjectReportRequest *reportRequest;  // 举报
@property(nonatomic, strong)XMProjectCollectRequest *collectRequest; // 收藏
@property(nonatomic, strong)XMProjectCancelCollectRequest *cancelCollectRequest;  // 取消收藏

@property(nonatomic, strong)XMDeleteRequest *deleteRequest;

@property(nonatomic, strong)XMProjectShareRequest *shareRequest;


// ZF播放器
@property(nonatomic, strong)ZFPlayerController *player;

@property(nonatomic, strong)ZFPlayerControlView *controlView;

@property(nonatomic, strong)XMProjectBootomView *bottomV;  // 编辑

@property(nonatomic, strong)XMMessageBoardView *messageBoardV;  // 留言板

@property(nonatomic, strong)XMProjectGetMessageRequest *getMessageRequest;  // 获取消息

@property(nonatomic, strong)NSArray *messageData; // 消息数据

@property(nonatomic, strong)XMProjectSaveMessageRequest *saveMessageRequest;  // 保存留言


@end

static NSString *projectDetailCellId = @"projectDetailCellId_cellId";
static NSString *messageBoardCellId = @"messageBoardCellId_cellId";

CGFloat const detailCellRowHeight = 180;

@implementation XMProjectDetailController

- (void)viewWillAppear:(BOOL)animated
{
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"取消";
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    self.tableViewStyle = UITableViewStyleGrouped;
    [super viewDidLoad];
    [self setup];
    [self setupMovie];
    [self loadData];
    [self setBootomViewStatus];
    
    // 留言区
    if (!_isEdit) {
        [self setupMessageBoard];
        [self loadMessage:NO];
        [self loadMoreMessage];
    }
}

// 加载更多留言
- (void)loadMoreMessage
{
    @weakify(self)
    [self.tableView addFooterWithCallback:^{
        @strongify(self)
        self.getMessageRequest.needRefresh = NO;
        [self loadMessage:NO];
    }];
}

// 设置底部视图状态
- (void)setBootomViewStatus
{
    [self.bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@50);
        make.bottom.safeEqualToBottom(self.view).offset(-7);
    }];
    
    self.bottomV.status = self.status;
    self.bottomV.hidden = !self.isEdit;
    
    //删除
    @weakify(self)
    [[self.bottomV.deleteBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        QKAlertView *alertV = [[QKAlertView alloc] initWithTitle:@"" message:@"确定要删除吗" buttonTitles:@"取消", @"确定", nil];
        [alertV showWithCompletion:^(NSInteger index, NSString *msg) {
            
            if (index == 1) {
                @strongify(self)
                [self.tableView hideLoading];
                self.deleteRequest.itemId = self.itemId;
                [self.deleteRequest startWithCompletion:^(__kindof XMDeleteRequest * _Nonnull request, NSError * _Nonnull error) {
                    if (request.businessSuccess) {
                        [XMHUD showSuccess:@"成功"];
                        [self.navigationController popViewControllerAnimated:YES];
                    }else{
                        [XMHUD showFail:request.businessMessage];
                    }
                }];
            }
        }];
    }];
    //追加
    [[self.bottomV.addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        XMBoothManagerController *managerVC = [XMBoothManagerController new];
        managerVC.itemId = self.itemId;
        [managerVC.subject subscribeNext:^(id  _Nullable x) {
            if ([x boolValue]) {
                [self loadData];
            }
        }];
        [self.navigationController pushViewController:managerVC animated:YES];
    }];
    //编辑
    [[self.bottomV.editBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        XMPublishController *editProjectVC = [XMPublishController new];
        editProjectVC.teamId = self.itemId;
        [self.navigationController pushViewController:editProjectVC animated:YES];
    }];
    //状态
    [[self.bottomV.statusBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (self.status == 2) {  // 投放
            XMBoothManagerController *managerVC = [XMBoothManagerController new];
            managerVC.itemId = self.itemId;
            [managerVC.subject subscribeNext:^(id  _Nullable x) {
                if ([x boolValue]) {
                    [self loadData];
                }
            }];
            [self.navigationController pushViewController:managerVC animated:YES];
        }
        // 下架
        if (self.status == 3) {
            [self.tableView showLoading];
            self.downRequest.itemId =self.detailModel.Id;
            [self.downRequest startWithCompletion:^(__kindof XMProjectDownRequest * _Nonnull request, NSError * _Nonnull error) {
                @strongify(self)
                [self.tableView hideLoading];
                if (request.businessSuccess) {
                    [self.subject sendNext:@(XMBlockTypeDown)];
                    // 返回列表
                    [XMHUD showSuccess:@"下架成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [XMHUD showFail:request.businessMessage];
                }
            }];
        }
    }];
}

// 初始化
- (void)setup
{
    [[UIView appearance] setExclusiveTouch:YES];   // 事件冲突
    self.view.backgroundColor = kHexColor(0xf4f4f4);
    self.navigationItem.title = @"详情";
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.safeEqualToTop(self.view);
        if (self.isEdit) {
            make.bottom.safeEqualToBottom(self.view);
        }else{
//             make.bottom.equalTo(self.messageBoardV.mas_top).offset(0);
            make.bottom.safeEqualToBottom(self.view).offset(-50);
        }
        
        make.left.right.equalTo(self.view);
    }];
    
    if (!self.isEdit) {
        UIButton *collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        collectBtn.frame = CGRectMake(0, 0, 32, 32);
        [collectBtn setImage:kGetImage(@"project_collect_select") forState:UIControlStateSelected];
        [collectBtn setImage:kGetImage(@"project_collect_normal") forState:UIControlStateNormal];
        self.collectBtn = collectBtn;
        [collectBtn addTarget:self action:@selector(handCollectAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *collectItem = [[UIBarButtonItem alloc] initWithCustomView:collectBtn];
        
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame = CGRectMake(0, 0, 35, 35);
        [shareBtn setImage:kGetImage(@"project_share_icon") forState:UIControlStateNormal];
        [shareBtn addTarget:self action:@selector(handCollectAction) forControlEvents:UIControlEventTouchUpInside];
        // 分享
        UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
        self.navigationItem.rightBarButtonItems = @[shareItem,collectItem];
    }
    
    // 举报
//    @weakify(self)
    [[self.headV.reportBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        @strongify(self)
        [XMHUD showText:@"暂未开通"];
//        [self reportProject];
    }];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.01)];
    self.tableView.tableHeaderView = header;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[XMProjectDetailCell class] forCellReuseIdentifier:projectDetailCellId];
    [self.tableView registerClass:[XMMessageBoardCell class] forCellReuseIdentifier:messageBoardCellId];
    
    
}

// 初始化留言板
- (void)setupMessageBoard
{
    // 留言板
    [self.messageBoardV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.safeEqualToBottom(self.view);
        make.left.right.equalTo(self.view);
    }];
    
    @weakify(self)
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [self.messageBoardV.messageImgV addGestureRecognizer:tap];
    [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self)
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }];
    
    // 发送消息
    [[self.messageBoardV.sendBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (self.messageBoardV.edingMessageTxt.text.length <= 0) {
            [XMHUD showText:@"请输入文字（100字以内）"];
            return ;
        }
        self.saveMessageRequest.itemId = self.itemId;
        self.saveMessageRequest.message = self.messageBoardV.edingMessageTxt.text;
        [self.saveMessageRequest startWithCompletion:^(__kindof XMProjectSaveMessageRequest * _Nonnull request, NSError * _Nonnull error) {
            if (request.businessSuccess) {
                [self.view endEditing:YES];  // 键盘隐藏
                self.messageBoardV.edingMessageTxt.text = @"";  // 清空文本
                [self.messageBoardV resetViewWith:NO];
                [XMHUD showSuccess:@"成功"];
                self.getMessageRequest.needRefresh = YES;
                [self loadMessage:YES];
            }else{
                [XMHUD showFail:request.businessMessage];
            }
        }];
    }];
}


// 分享
- (void)handCollectAction
{
    self.shareRequest.itemId = self.itemId;
    [self.shareRequest startWithCompletion:^(__kindof XMBaseRequest * _Nonnull request, NSError * _Nonnull error) {
        if (request.businessSuccess) {
            NSString *sharePath = request.businessData[@"sharePath"];
            NSURL *url = [NSURL URLWithString:sharePath];
            [XMShareUtils goShareWith:@[kApp_Name, url]];
        }
    }];
}

// 收藏
- (void)handCollectAction:(UIButton *)sender
{
    if (sender.isSelected) {
        // 取消收藏
        [self.cancelCollectRequest startWithCompletion:^(__kindof XMProjectCancelCollectRequest * _Nonnull request, NSError * _Nonnull error) {
            if (request.businessSuccess) {
                [XMHUD showSuccess:@"已取消收藏"];
                [sender setSelected:NO];
                [self.subject sendNext:@(XMBlockTypeCollect)];
            }else{
                [XMHUD showFail:request.businessMessage];
            }
        }];
    }else{
        // 收藏
        [self.collectRequest startWithCompletion:^(__kindof XMProjectCollectRequest * _Nonnull request, NSError * _Nonnull error) {
            if (request.businessSuccess) {
                [XMHUD showSuccess:@"收藏成功"];
                [sender setSelected:YES];
            }else{
                [XMHUD showFail:request.businessMessage];
            }
        }];
    }
}

// 举报
- (void)reportProject
{
    [self.reportRequest startWithCompletion:^(__kindof XMBaseRequest * _Nonnull request, NSError * _Nonnull error) {
        if (request.businessSuccess) {
            [XMHUD showText:@"举报成功，等待审核"];
        }else{
            [XMHUD showText:request.businessMessage];
        }
    }];
}

- (void)setIsEdit:(BOOL)isEdit
{
    _isEdit = isEdit;
    [self hideCollect];
}

#pragma mark --- 添加收藏功能
- (void)hideCollect
{
    self.navigationItem.rightBarButtonItems = @[];
}
// 播放器  ZF
- (void)setupMovie
{
    ZFAVPlayerManager *playerManager = [ZFAVPlayerManager new];
    self.player = [ZFPlayerController playerWithScrollView:self.tableView playerManager:playerManager containerViewTag:300];
    self.player.controlView = self.controlView;
    self.player.shouldAutoPlay = NO;
    /// 1.0是完全消失的时候
    self.player.playerDisapperaPercent = 1.0;
    
    // 横竖屏
    @weakify(self)
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        @strongify(self)
        [self setNeedsStatusBarAppearanceUpdate];
        [UIViewController attemptRotationToDeviceOrientation];
        self.tableView.scrollsToTop = !isFullScreen;
    };
    
    // 播放结束
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @strongify(self)
        [self.player stopCurrentPlayingCell];
    };
}


// 加载数据
- (void)loadData
{
    self.detailRequest.itemId = self.itemId;
    [self.tableView showLoading];
    @weakify(self)
    [self.detailRequest startWithCompletion:^(__kindof XMProjectDetailRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            XMProjectDetailModel *detailModel = request.businessModel;
            self.detailModel = detailModel;
            [self.collectBtn setSelected:detailModel.collect];
            if (self.isEdit) {
                self.status = detailModel.status;
            }
            NSMutableArray *movieUrl = [NSMutableArray array];
            for (XMProjectListItemModel *itemModel in detailModel.detailList) {
                [itemModel initOtherParam];
                if ([NSString isEmpty:itemModel.filePath]) {
                    itemModel.filePath = @"";
                }
                NSString *URLString = [itemModel.filePath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                
                NSURL *url = [NSURL URLWithString:URLString];
                [movieUrl addObject:url];
            }
            // 设置视频url
            self.player.assetURLs = movieUrl;
            self.dataSource = detailModel.detailList;
            // 留言区
            if (!self.isEdit) {
                [self loadMessage:NO];
            }
        }
        [self.tableView hideLoadingWithRequest:request];
    }];
}

- (void)loadMessage:(BOOL)top
{
    @weakify(self)
    self.getMessageRequest.itemId = self.itemId;
    [self.getMessageRequest startWithCompletion:^(__kindof XMProjectGetMessageRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            XMProjectGetMessageModel *messageModel = request.businessModel;
            self.messageBoardV.numLbl.text = messageModel.totalStr;
            self.messageData = request.businessModelArray;
        }
        [self.tableView hideLoadingAndEndRefreshNoTipsEmpty:request];
        if (top) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isEdit) {
        return 1;
    }else{
        return self.dataSource.count?2:0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
         return self.headV.totalHeight + self.detailModel.addressHeight + self.detailModel.descHeight;  //文字描述高度
    }else{
        return 50;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        self.headV.reportBtn.hidden = self.isEdit;
        self.headV.detailModel = self.detailModel;
        self.headV.frame = CGRectMake(0, 0, kScreenWidth, self.headV.totalHeight);
        return self.headV;
    }else{
        
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth-20, 50)];
        titleLbl.text  = @"   留言区:";
        titleLbl.font = kBoldFont(20);
        titleLbl.backgroundColor = kHexColor(0xf4f4f4);
        return titleLbl;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.dataSource.count;
    }else{        
        return self.messageData.count?:1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        XMProjectListItemModel *itemModel = self.dataSource[indexPath.row];
        if (itemModel.type == 1) {
            // 文字
            return itemModel.descHeight;
        }
        if (itemModel.type == 2) {
            if (isnan(itemModel.imgHeight)) {
                itemModel.imgHeight = 0.0;
            }
            return itemModel.imgHeight;
        }
        return detailCellRowHeight;
    }else{
        if (self.messageData.count) {
            XMProjectMessageItemModel *itemModel = self.messageData[indexPath.row];
            return itemModel.messageHeight;
        }else{
            return 150;
        }
       
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        XMProjectDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:projectDetailCellId forIndexPath:indexPath];
        XMProjectListItemModel *itemModel = self.dataSource[indexPath.row];
        cell.itemModel = itemModel;
        if (itemModel.type == 3) {
            cell.playBtn.tag = 2019+indexPath.row;
            [cell.playBtn addTarget:self action:@selector(handPlayAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }else{
        XMMessageBoardCell *messageBoardCell = [tableView dequeueReusableCellWithIdentifier:messageBoardCellId forIndexPath:indexPath];
        messageBoardCell.isEmptyData = !self.messageData.count;
        if (self.messageData.count) {
            XMProjectMessageItemModel *itemModel = self.messageData[indexPath.row];
            messageBoardCell.itemModel = itemModel;
        }
        
        return messageBoardCell;
    }
}

// 开始播放
- (void)handPlayAction:(UIButton *)sender
{
    NSInteger index = sender.tag - 2019;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    XMProjectListItemModel *itemModel = self.dataSource[indexPath.row];
    [self.player playTheIndexPath:indexPath scrollToTop:NO];
    [self.controlView showTitle:@"" coverImage:itemModel.thumbnail_img fullScreenMode:ZFFullScreenModeAutomatic];
}

#pragma mark  ----- 切换横竖屏操作
- (BOOL)shouldAutorotate {
    /// 如果只是支持iOS9+ 那直接return NO即可，这里为了适配iOS8
    return self.player.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.player.isFullScreen && self.player.orientationObserver.fullScreenMode == ZFFullScreenModeLandscape) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return self.player.isStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

#pragma mark - UIScrollViewDelegate 列表播放必须实现

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidEndDecelerating];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [scrollView zf_scrollViewDidEndDraggingWillDecelerate:decelerate];
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidScrollToTop];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidScroll];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewWillBeginDragging];
}


#pragma mark  -------  懒加载

- (XMProjectDetailRequest *)detailRequest
{
    if (!_detailRequest) {
        _detailRequest = [XMProjectDetailRequest request];
    }
    return _detailRequest;
}

- (XMProjectHeadView *)headV
{
    if (!_headV) {
        _headV = [XMProjectHeadView new];
    }
    return _headV;
}


- (XMProjectDownRequest *)downRequest
{
    if (!_downRequest) {
        _downRequest = [XMProjectDownRequest request];
    }
    return _downRequest;
}

-  (RACSubject *)subject
{
    if (!_subject) {
        _subject = [RACSubject subject];
    }
    return _subject;
}

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
        _controlView.prepareShowLoading = YES;
    }
    return _controlView;
}


- (XMProjectReportRequest *)reportRequest
{
    if (!_reportRequest) {
        _reportRequest = [XMProjectReportRequest request];
        _reportRequest.itemId = self.itemId;
    }
    return _reportRequest;
}

- (XMProjectCollectRequest *)collectRequest
{
    if (!_collectRequest) {
        _collectRequest = [XMProjectCollectRequest request];
        _collectRequest.itemId = self.itemId;
    }
    return _collectRequest;
}

- (XMProjectCancelCollectRequest *)cancelCollectRequest
{
    if (!_cancelCollectRequest) {
        _cancelCollectRequest = [XMProjectCancelCollectRequest request];
        _cancelCollectRequest.itemId = self.itemId;
    }
    return _cancelCollectRequest;
}

- (XMDeleteRequest *)deleteRequest
{
    if (!_deleteRequest) {
        _deleteRequest = [XMDeleteRequest request];
    }
    return _deleteRequest;
}

- (XMProjectShareRequest *)shareRequest
{
    if (!_shareRequest) {
        _shareRequest = [XMProjectShareRequest request];
    }
    return _shareRequest;
}

- (XMProjectBootomView *)bottomV
{
    if (!_bottomV) {
        _bottomV = [XMProjectBootomView new];
        [self.view addSubview:_bottomV];
    }
    return _bottomV;
}

- (XMMessageBoardView *)messageBoardV
{
    if (!_messageBoardV) {
        _messageBoardV = [XMMessageBoardView new];
        [self.view addSubview:_messageBoardV];
    }
    return _messageBoardV;
}


- (XMProjectGetMessageRequest *)getMessageRequest
{
    if (!_getMessageRequest) {
        _getMessageRequest = [XMProjectGetMessageRequest request];
    }
    return _getMessageRequest;
}

- (XMProjectSaveMessageRequest *)saveMessageRequest
{
    if (!_saveMessageRequest) {
        _saveMessageRequest = [XMProjectSaveMessageRequest request];
    }
    return _saveMessageRequest;
}

- (void)dealloc
{
    NSLog(@"****************  ");
}


@end
