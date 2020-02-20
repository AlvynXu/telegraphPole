//
//  XMStallController.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/22.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMStallController.h"
#import "XMSeoulView.h"
#import "XMHomeView.h"
#import "XMMyTeamController.h"
#import "XMGrabLandlordController.h"
#import "XMHomeRequest.h"
#import "XMHomeMsgModel.h"
#import "XMAgentController.h"
#import "XMMessageBaseController.h"
#import "XMProfitController.h"
#import "XMSeoulController.h"
#import "XMBuyStateController.h"
#import "XMHomeGuidVm.h"
#import "XMShareController.h"
#import "LYLocationUtil.h"
#import "XMPublishController.h"
#import "XMHomeCell.h"
#import "XMSectionTitleView.h"
#import "XMWalletController.h"
#import "XMProjectDetailController.h"
#import "XMProjectDetailController.h"
#import "XMCustomerController.h"
#import "XMComWebController.h"
#import "XMSuccessController.h"


@interface XMStallController()<SDCycleScrollViewDelegate>

@property(nonatomic, strong)XMSeoulView *seoulV;  //上头条

@property(nonatomic, strong)XMHomeView *homeV;

@property(nonatomic, strong)XMSectionTitleView *sectionTitleV;

@property(nonatomic, strong)XMHomeRequest *zhanweiRequest; // 展位

@property(nonatomic, strong)XMHomeMsgRequest *msgRequest; // 头部数据

@property(nonatomic, strong)XMHomeGetBannerRequest *getBannerRequest;  // 加载轮播图

@property(nonatomic, strong)XMHomeMsgModel *msgModel;

@property(nonatomic, strong)XMHomeLandlordRequest *landLordRequest;  //地主

@property(nonatomic, copy)NSString *localCity;  //当前市

@property(nonatomic, copy)NSString *localParent;  //当前省

@property(nonatomic, strong)XMHomeHeadLineRequest *headLineRequest;  // 头条

@property(nonatomic, strong)NSMutableArray *headLineData;  //头条

@end

@implementation XMStallController

static NSString *homeCellID = @"homeCellID_cellId";

- (void)viewDidLoad {
    self.tableViewStyle = UITableViewStyleGrouped;
    [super viewDidLoad];
    [self setup];
}


- (void)viewWillDisappear:(BOOL)animated
{
     [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    self.headLineRequest.needRefresh = YES;
    // 获取首页其他信息
    [self loadData];
    // 获取头条
    [self getHeadLieData];
}
// 初始化
- (void)setup
{
    // 用户第一次进来加载
    [XMHomeGuidVm firstLoadGuid];
    
    self.view.backgroundColor = UIColor.whiteColor;
    // 表视图
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.safeEqualToTop(self.view);
        make.bottom.safeEqualToBottom(self.view);
    }];
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.01)];
    self.tableView.tableHeaderView = header;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[XMHomeCell class] forCellReuseIdentifier:homeCellID];
    
    self.seoulV.frame = CGRectMake(0, 0, 85, 40);
    self.seoulV.right = kScreenWidth;
    self.seoulV.bottom = self.view.bottom - 100;
    // 添加刷新
    [self addrefresh];
    
    @weakify(self)
    // 上头条
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [[tapGesture rac_gestureSignal] subscribeNext:^(id x) {
        @strongify(self)
        XMCustomerController *customerVC = [XMCustomerController new];
        [self.navigationController pushViewController:customerVC animated:YES];
    }];
    [self.seoulV addGestureRecognizer:tapGesture];
    
    // 抢地主
    UITapGestureRecognizer *landlordBuy = [[UITapGestureRecognizer alloc] init];
    [[landlordBuy rac_gestureSignal] subscribeNext:^(id x) {
        @strongify(self)
        if (![LYLocationUtil checkLocaltionIsDenied]) {
            XMGrabLandlordController *banlandVc = [XMGrabLandlordController new];
            banlandVc.isLandlord = YES;
            banlandVc.isfirst = YES;
            [self.navigationController pushViewController:banlandVc animated:YES];
        }
    }];
    [self.homeV.buyLanlordImgV addGestureRecognizer:landlordBuy];
    
   // 抢展位
    UITapGestureRecognizer *boothBuy = [[UITapGestureRecognizer alloc] init];
    [[boothBuy rac_gestureSignal] subscribeNext:^(id x) {
        @strongify(self)
        if (![LYLocationUtil checkLocaltionIsDenied]) {
            XMGrabLandlordController *banlandVc = [XMGrabLandlordController new];
            banlandVc.isLandlord = NO;
            banlandVc.isfirst = YES;
            [self.navigationController pushViewController:banlandVc animated:YES];
        }
        
    }];
    [self.homeV.buyBoothImagv addGestureRecognizer:boothBuy];
    
    // 升级代理
    [[self.homeV.placeholderWealthV.placeholderBtn  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        
        XMPublishController *publishVC = [XMPublishController new];
        [self.navigationController pushViewController:publishVC animated:YES];

    }];
    
    // 受益
    [[self.homeV.benefitLbl.tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
       @strongify(self)
        XMWalletController *walletVC = [XMWalletController new];
        [self.navigationController pushViewController:walletVC animated:YES];

    }];
    // 团队
    [[self.homeV.teamLbl.tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self)
        XMMyTeamController *teamVC = [XMMyTeamController new];
        [self.navigationController pushViewController:teamVC animated:YES];
    }];
    
    // 消息
    [[self.homeV.msgLbl.tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self)
        XMMessageBaseController *VC = [XMMessageBaseController new];
        [self.navigationController pushViewController:VC animated:YES];
    }];
    
    // 轮播图
    self.homeV.cycleScrollView.clickItemOperationBlock = ^(NSInteger currentIndex) {
        @strongify(self)
         XMBannerModel *bannerModel = self.getBannerRequest.businessModel;
         XMBannerItemModel *itemModel = bannerModel.data[currentIndex];
        //3项目 4h5
        if (itemModel.type==3) {
            // 项目
            XMProjectDetailController *detailVC = [XMProjectDetailController new];
            detailVC.itemId = itemModel.itemId.integerValue;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
        if (itemModel.type==4) {
            XMComWebController *comWebVC = [XMComWebController new];
            comWebVC.urlStr = itemModel.itemId;
            [self.navigationController pushViewController:comWebVC animated:YES];
        }
    };
}

- (void)addrefresh
{
    @weakify(self)
    [self.tableView addFooterWithCallback:^{
        @strongify(self)
        self.headLineRequest.needRefresh = NO;
        [self getHeadLieData];
    }];
    
    [self.tableView addHeaderWithCallback:^{
        @strongify(self)
        self.headLineRequest.needRefresh = YES;
        [self getHeadLieData];
        [self loadData];
    }];
    
}


// 加载数据
- (void)loadData
{
    @weakify(self)
    // 展位
    [self.zhanweiRequest startWithCompletion:^(__kindof XMHomeRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            XMHomeBootModel *bootModel = request.businessModel;
            self.homeV.booth = YES;
             self.homeV.commonModel = bootModel;
        }
    }];
    
    // 信息数据
    [self.msgRequest startWithCompletion:^(__kindof XMHomeMsgRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            self.msgModel = request.businessModel;
            self.homeV.msgStr = self.msgModel.message;
            self.homeV.teamStr = self.msgModel.team;
            self.homeV.benefitStr = kFormat(@"%.2lf", self.msgModel.balance);
            self.homeV.noRead = [self.msgModel.message intValue];
        }
    }];
    
    // 地主
    [self.landLordRequest startWithCompletion:^(__kindof XMHomeLandlordRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            XMHomeBootModel *bootModel = request.businessModel;
            self.homeV.booth = NO;
            self.homeV.commonModel = bootModel;
        }
    }];
    
    // 获取轮播图
    [self.getBannerRequest startWithCompletion:^(__kindof XMHomeGetBannerRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
           XMBannerModel *bannerModel = request.businessModel;
            NSMutableArray *tempArray = [NSMutableArray array];
            [bannerModel.data enumerateObjectsUsingBlock:^(XMBannerItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [tempArray addObject:obj.imageUrl];
            }];
            self.homeV.cycleScrollView.imageURLStringsGroup = tempArray;
        }
    }];
    
    
}

- (void)getHeadLieData
{
    // 获取头条
    @weakify(self)
    [self.headLineRequest startWithCompletion:^(__kindof XMHomeHeadLineRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            self.headLineData = request.businessModelArray;
        }
        CGFloat bottomSpace = 94;   // 6P
        if (kIsIphoneX) {
            if (kScreenHeight == 812) {
                bottomSpace = 170;
            }else{
                bottomSpace = 220;
            }
        }else{
            if (kIphone6 || kIphone5) {
                bottomSpace = 64;
            }
        }
        
        [self.tableView hideLoadingWithRequest:request rect:CGRectMake(0, 410+kScaleH(153), kScreenWidth, 130)];
        [self.tableView.emptyView setDetail:@"暂没有头条~" forState:EmptySateEmptyData];
    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return self.homeV;
    }
    return self.sectionTitleV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        // 固定高度加上轮播图高度
        return 287+kScaleH(153);
    }
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return self.headLineData.count?:1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:homeCellID forIndexPath:indexPath];
    cell.lineV.hidden = !self.headLineData.count;
//    cell.isEmptyData = !self.headLineData.count;
    if (indexPath.section == 1 && self.headLineData.count) {
        cell.itemModel = self.headLineData[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.headLineData.count?150:110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.headLineData.count) {
        XMProjectDetailController *projectDetailVC = [[XMProjectDetailController alloc] init];
        XMHeadLineItemModel *itemModel = self.headLineData[indexPath.row];
        projectDetailVC.itemId = itemModel.Id;
        [self.navigationController pushViewController:projectDetailVC animated:YES];
    }
}


- (XMSeoulView *)seoulV
{
    if (!_seoulV) {
        _seoulV = [[XMSeoulView alloc] init];
        [self.view addSubview:_seoulV];
    }
    return _seoulV;
}

- (XMHomeView *)homeV
{
    if (!_homeV) {
        _homeV = [[XMHomeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 480)];
//        _homeV.backgroundColor = UIColor.redColor;
    }
    return _homeV;
}

- (XMSectionTitleView *)sectionTitleV
{
    if (!_sectionTitleV) {
        _sectionTitleV = [[XMSectionTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    }
    return _sectionTitleV;
}

- (XMHomeRequest *)zhanweiRequest
{
    if (!_zhanweiRequest) {
        _zhanweiRequest = [XMHomeRequest request];
    }
    return _zhanweiRequest;
}

- (XMHomeMsgRequest *)msgRequest
{
    if (!_msgRequest) {
        _msgRequest = [XMHomeMsgRequest request];
    }
    return _msgRequest;
}


- (XMHomeLandlordRequest *)landLordRequest
{
    if (!_landLordRequest) {
        _landLordRequest = [XMHomeLandlordRequest request];
    }
    return _landLordRequest;
}

- (XMHomeGetBannerRequest *)getBannerRequest
{
    if (!_getBannerRequest) {
        _getBannerRequest = [XMHomeGetBannerRequest request];
        _getBannerRequest.areaCode = @"-1";
    }
    return _getBannerRequest;
}


- (XMHomeHeadLineRequest *)headLineRequest
{
    if (!_headLineRequest) {
        _headLineRequest = [XMHomeHeadLineRequest request];
    }
    return _headLineRequest;
}



@end
