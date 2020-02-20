//
//  XMMineController.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/22.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMMineController.h"
#import "XMPersonController.h"
#import "XMCiVilianController.h"
#import "XMCountyController.h"


@interface XMMineController ()<TYTabPagerControllerDataSource, TYTabPagerControllerDelegate>

@property(nonatomic, strong)NSArray *datas;

@end

@implementation XMMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTabButtonPager];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}


// 配置Page
- (void)configureTabButtonPager
{
    self.dataSource = self;
    self.delegate = self;
    self.tabBar.backgroundColor = UIColor.greenColor;
    self.tabBar.layout.barStyle = TYPagerBarStyleNoneView;
    self.tabBar.layout.cellWidth = (kScreenWidth - 30) / 3;
    self.tabBar.layout.sectionInset = UIEdgeInsetsMake(25, 0, 0, 0);
    self.tabBar.autoScrollItemToCenter = NO;
    self.tabBarHeight = 104;
}

- (void)loadData {
    self.datas = @[@"地主", @"平民", @"县长"];
    // must call reloadData
    [self reloadData];
}

#pragma mark - TYTabPagerControllerDataSource

- (NSInteger)numberOfControllersInTabPagerController {
    return _datas.count;
}

- (UIViewController *)tabPagerController:(TYTabPagerController *)tabPagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    if (index%3 == 0) {
        XMPersonController *VC = [[XMPersonController alloc]init];
//        VC.text = [@(index) stringValue];
        return VC;
    }else if (index%3 == 1) {
        XMCiVilianController *VC = [[XMCiVilianController alloc]init];
//        VC.text = [@(index) stringValue];
        return VC;
    }else {
        XMCountyController *VC = [[XMCountyController alloc]init];
//        VC.text = [@(index) stringValue];
        return VC;
    }
}

- (NSString *)tabPagerController:(TYTabPagerController *)tabPagerController titleForIndex:(NSInteger)index {
    NSString *title = _datas[index];
    
    return title;
}


@end
