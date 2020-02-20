//
//  XMMarketController.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/22.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMGalleryController.h"
#import "XMLanlordSectionView.h"
#import "LYLocationUtil.h"
#import "XMSelectCityView.h"
#import "XMCiVilianController.h"
#import "XMGalleryRequest.h"
#import "XMGalleryContentController.h"
#import "XMBuyLandlordRequest.h"
#import "LXFloaintButton.h"
#import "XMPublishController.h"

@interface XMGalleryController ()<TYTabPagerControllerDataSource, TYTabPagerControllerDelegate>

@property(nonatomic, strong)XMGalleryCategoryRequest *categoryRequest;   // 类目

@property(nonatomic, strong)XMSelectCityView *selectCityV;   // 城市弹框

@property(nonatomic, strong)XMLanlordSectionView *sectionHeader;  // 城市选择

@property(nonatomic, strong)XMGetCityCodeRequest *cityCodeRequest;  // 获取默认城市编码

@property(nonatomic, copy)NSString *localCity;  // 当前定位城市

@property(nonatomic, strong)NSArray *datas;  // 控制器数据源

@property(nonatomic, strong)XMGallerySelectModel *selectModel;

@property(nonatomic, assign)NSInteger lastIndex;

@end

@implementation XMGalleryController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.datas.count<=0) {
        [self loadDefaultCityCode];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![LYLocationUtil checkLocaltionIsDenied]) {
        [self setup];
        [self configureTabButtonPager];
        [self addFloatBtn];
    }
}


// 添加浮动按钮
- (void)addFloatBtn
{
    LXFloaintButton *button = [LXFloaintButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth - 50, kScreenHeight - 130, 50, 50);
    button.bottom = self.view.bottom - 130;
    [button setImage:kGetImage(@"project_edit_icon") forState:UIControlStateNormal];
    button.layer.cornerRadius = 25;
    button.layer.masksToBounds = YES;
    button.safeInsets = UIEdgeInsetsMake(kNabigationSafeArea, 0, kTabbarSafeArea , 0);
    [self.view addSubview:button];
    button.parentView = self.view;
    //
    @weakify(self)
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        XMPublishController *publishVC = [XMPublishController new];
        [self.navigationController pushViewController:publishVC animated:YES];
    }];
}

// 初始化
- (void)setup
{
    self.localCity = [LYLocationUtil getLocalCity];
    self.view.backgroundColor = UIColor.whiteColor;
    
    // 城市选择
    XMLanlordSectionView *sectionHeader =  [[XMLanlordSectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    sectionHeader.backgroundColor = UIColor.clearColor;
    sectionHeader.intrinsicContentSize = CGSizeMake(kScreenWidth-100, 60);
    sectionHeader.citySelectV.layer.borderWidth = 0;
    self.sectionHeader = sectionHeader;
    sectionHeader.citySelectV.titleLbl.text = kFormat(@"%@ %@",[LYLocationUtil getLocalParaent],[LYLocationUtil getLocalCity]);
    @weakify(self)
    // 选择城市
    UITapGestureRecognizer *cityTap = [[UITapGestureRecognizer alloc] init];
    [[cityTap rac_gestureSignal] subscribeNext:^(id x) {
        @strongify(self)
        [self.selectCityV show];
        
    }];
    [sectionHeader.citySelectV addGestureRecognizer:cityTap];
    self.navigationItem.titleView = sectionHeader;
    
    // 选择城市回调
    [self.selectCityV.subject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        NSDictionary *dict = (NSDictionary *)x;
        NSString *code = dict[@"code"];
        NSString *name = dict[@"name"];
        NSInteger index = [dict[@"index"] integerValue];
        self.sectionHeader.citySelectV.titleLbl.text = name;
        self.selectModel.areaCode = code; // 城市编码
        self.selectModel.areaType = labs(index - 4);;  // 默认市级
        
        self.lastIndex = self.tabBar.curIndex;
        [self reloadData];
        [self scrollToControllerAtIndex:self.lastIndex animate:NO];
        
    }];
}

// 配置Page
- (void)configureTabButtonPager
{
    self.dataSource = self;
    self.delegate = self;
    self.tabBar.layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    self.tabBar.autoScrollItemToCenter = YES;
    self.tabBar.layout.normalTextFont = kSysFont(16.5);
    self.tabBar.layout.adjustContentCellsCenter = YES;
    
    self.tabBar.layout.normalTextColor = kHexColor(0x999999);
    self.tabBar.layout.selectedTextColor = kHexColor(0xFF333333);
    self.tabBar.layout.selectedTextFont = kBoldFont(17);
    self.tabBar.layout.progressColor = kHexColor(0xFF333333);
    self.tabBarHeight = 44;
    
    [self.tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.safeEqualToTop(self.view);
        make.height.equalTo(@44);
        make.left.right.equalTo(self.view);
    }];
}


// 获取默认城市编码
- (void)loadDefaultCityCode
{
    self.localCity = [LYLocationUtil getLocalCity];
    if ([self.localCity isEmpty]) {
        [self.view showLoadigWith:@"正在获取定位...."];
        return;
    }else{
        [self.view showLoading];
    }
    @weakify(self)
    [self.cityCodeRequest startWithCompletion:^(__kindof XMGetCityCodeRequest * _Nonnull request, NSError * _Nonnull error) {
        [self.view hideLoading];
        @strongify(self)
        // 成功之后 获取默认定位列表
        if (request.businessSuccess) {
            // 获取当前定位城市编码
            XMCityCodeModel *codeModel = request.businessModel;
            self.selectModel.areaCode = codeModel.code; // 城市编码
            self.selectModel.areaType = 3;  // 默认市级
            [self loadData];
        }
    }];
}


// 加载分类数据
- (void)loadData {
    @weakify(self)
    [self.categoryRequest startWithCompletion:^(__kindof XMGalleryCategoryRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            XMGalleryCateModel *cateModel = request.businessModel;
            if (self.datas.count!=cateModel.data.count) {
                self.datas = cateModel.data;
                if (self.datas.count < 6 && self.datas.count > 0) {
                    self.tabBar.layout.cellWidth = (kScreenWidth) / self.datas.count;
                    self.tabBar.layout.cellSpacing = 7;
                    //
                }else{
                    self.tabBar.layout.cellSpacing = 15;
                }
            }
        }
        [self reloadData];
    }];
    
}

#pragma mark - TYTabPagerControllerDataSource

- (NSInteger)numberOfControllersInTabPagerController {
    return _datas.count;
}

- (UIViewController *)tabPagerController:(TYTabPagerController *)tabPagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    XMGalleryContentController *VC = [[XMGalleryContentController alloc]init];
    VC.areaCode = self.selectModel.areaCode;
    VC.areaType = self.selectModel.areaType;
    XMGalleryCateItemModel *cateItemModel = _datas[index];
    VC.categoryId = cateItemModel.Id;
    return VC;
}

- (NSString *)tabPagerController:(TYTabPagerController *)tabPagerController titleForIndex:(NSInteger)index {
    XMGalleryCateItemModel *cateItemModel = _datas[index];
    NSString *title = cateItemModel.title;
    return title;
}

- (XMSelectCityView *)selectCityV
{
    if (!_selectCityV) {
        _selectCityV = [[XMSelectCityView alloc] initWithFrame:kWindow.bounds];
        _selectCityV.level = XMLevelFour;
    }
    return _selectCityV;
}

- (XMGalleryCategoryRequest *)categoryRequest
{
    if (!_categoryRequest) {
        _categoryRequest = [XMGalleryCategoryRequest request];
    }
    return _categoryRequest;
}


- (XMGetCityCodeRequest *)cityCodeRequest
{
    if (!_cityCodeRequest) {
        _cityCodeRequest = [XMGetCityCodeRequest request];
        _cityCodeRequest.cityName = self.localCity;
    }
    return _cityCodeRequest;
}

- (XMGallerySelectModel *)selectModel
{
    if (!_selectModel) {
        _selectModel = [XMGallerySelectModel new];
    }
    return _selectModel;
}


@end
