//
//  XMGalleryContentController.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/18.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMGalleryContentController.h"
#import "XMGalleryContentCell.h"
#import "XMHeadView.h"
#import "XMHomeRequest.h"
#import "XMGalleryRequest.h"
#import "XMProjectDetailController.h"

@interface XMGalleryContentController ()

@property(nonatomic, strong)XMHeadView *headV;

@property(nonatomic, strong)XMHomeGetBannerRequest *getBannerRequest;  // 加载轮播图

@property(nonatomic, strong)XMGalleryListRequest *listRequest;  //

@property(nonatomic, strong)NSArray *dataSource;

@end

static NSString *const galleryContentCellId = @"galleryContentCellId_cellID";

@implementation XMGalleryContentController

- (void)viewDidLoad {
    self.tableViewStyle = UITableViewStyleGrouped;
    [super viewDidLoad];
    [self setup];
    [self getBannerData];
    [self addrefresh];
}

// 初始化
- (void)setup
{
    self.view.backgroundColor = UIColor.whiteColor;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.safeEqualToTop(self.view);
        make.bottom.safeEqualToBottom(self.view);
        make.left.right.equalTo(self.view);
    }];
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.01)];
    self.tableView.tableHeaderView = header;    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[XMGalleryContentCell class] forCellReuseIdentifier:galleryContentCellId];
}

// 添加刷新
- (void)addrefresh
{
    @weakify(self)
    [self.tableView addHeaderWithCallback:^{
        @strongify(self)
        self.listRequest.needRefresh = YES;
        [self getBannerData];
    }];
    
    [self.tableView addFooterWithCallback:^{
        @strongify(self)
        self.listRequest.needRefresh = NO;
        [self getBannerData];
    }];
}
// 获取轮播图
- (void)getBannerData
{
    self.getBannerRequest.areaCode = self.areaCode;
    self.getBannerRequest.categoryId = kFormat(@"%zd", self.categoryId);
    @weakify(self)
    // 获取轮播图
    [self.getBannerRequest startWithCompletion:^(__kindof XMHomeGetBannerRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            XMBannerModel *bannerModel = request.businessModel;
            NSMutableArray *tempArray = [NSMutableArray array];
            [bannerModel.data enumerateObjectsUsingBlock:^(XMBannerItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [tempArray addObject:obj.imageUrl];
            }];
            self.headV.cycleScrollView.imageURLStringsGroup = tempArray;
        }
        [self loadListData];
    }];
}

- (void)loadListData
{
    self.listRequest.areaCode = self.areaCode;
    self.listRequest.areaType = self.areaType;
    self.listRequest.categoryId = self.categoryId;
    @weakify(self)
    [self.listRequest startWithCompletion:^(__kindof XMGalleryListRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            self.dataSource = request.businessModelArray;
        }
        [self.tableView hideLoadingWithRequest:request rect:CGRectMake(0, kScaleH(153) + 108, kScreenWidth, 150)];
        [self.tableView.emptyView setDetail:@"该类目下没有数据~" forState:EmptySateEmptyData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.headV.cycleScrollView.imageURLStringsGroup.count) {
        XMHeadView *headV = [[XMHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScaleH(153))];
        self.headV = headV;
        
        return headV;
    }else{
        return nil;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.headV.cycleScrollView.imageURLStringsGroup.count?kScaleH(153):0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGalleryContentCell *cell = [tableView dequeueReusableCellWithIdentifier:galleryContentCellId forIndexPath:indexPath];
    cell.itemModel = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMCategoryListItemModel *itemModel = self.dataSource[indexPath.row];
    XMProjectDetailController *detailVC = [XMProjectDetailController new];
    detailVC.itemId = itemModel.Id;
    [self.navigationController pushViewController:detailVC animated:YES];
}



- (XMHomeGetBannerRequest *)getBannerRequest
{
    if (!_getBannerRequest) {
        _getBannerRequest = [XMHomeGetBannerRequest request];
    }
    return _getBannerRequest;
}

- (XMGalleryListRequest *)listRequest
{
    if (!_listRequest) {
        _listRequest = [XMGalleryListRequest request];
    }
    return _listRequest;
}



@end
