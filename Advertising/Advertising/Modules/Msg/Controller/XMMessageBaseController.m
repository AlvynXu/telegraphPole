//
//  XMMessageController.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/1.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMMessageBaseController.h"
#import "XMNoReadController.h"
#import "XMReadedController.h"

@interface XMMessageBaseController ()<TYTabPagerControllerDataSource, TYTabPagerControllerDelegate>

@property(nonatomic, strong)NSArray *datas;

@end

@implementation XMMessageBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息";
    self.view.backgroundColor = kMainBackGroundColor;
    [self configureTabButtonPager];
    [self loadData];
}


// 配置Page
- (void)configureTabButtonPager
{
    self.dataSource = self;
    self.delegate = self;
    self.tabBar.backgroundColor = kMainBackGroundColor;
    self.tabBar.layout.barStyle = TYPagerBarStyleNoneView;
    self.tabBar.layout.cellWidth = (kScreenWidth - 180) / 2;
    self.tabBar.layout.sectionInset = UIEdgeInsetsMake(20, 90, 0, 90);
    self.tabBar.autoScrollItemToCenter = NO;
    self.tabBarHeight = 50;
    self.tabBar.layout.progressHeight = 10;
    self.tabBar.layout.progressColor = kMainColor;
    self.tabBar.layout.progressRadius = 3;
    self.tabBar.layout.progressWidth = 50;
    self.tabBar.layout.selectedTextColor = kHexColor(0xFF333333);
    self.tabBar.layout.normalTextColor = kHexColor(0xFF666666);
    self.tabBar.layout.barStyle = TYPagerBarStyleProgressView;
    self.tabBar.layout.normalTextFont = kBoldFont(17);
    self.tabBar.layout.selectedTextFont = kBoldFont(17);

}

- (void)loadData {
    self.datas = @[@"未读", @"已读"];
    // must call reloadData
    [self reloadData];
}

#pragma mark - TYTabPagerControllerDataSource

- (NSInteger)numberOfControllersInTabPagerController {
    return _datas.count;
}

- (UIViewController *)tabPagerController:(TYTabPagerController *)tabPagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    if (index == 0) {
        return [XMNoReadController new];
    }else{
        return [XMReadedController new];
    }
}

- (NSString *)tabPagerController:(TYTabPagerController *)tabPagerController titleForIndex:(NSInteger)index {
    NSString *title = _datas[index];
    
    return title;
}


@end
