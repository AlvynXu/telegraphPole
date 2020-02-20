//
//  GXBaseTabBarController.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseTabBarController.h"
#import "XMBaseNavigationController.h"
#import "XMGalleryController.h"
#import "XMMineController.h"
#import "XMBusinessController.h"
#import "XMStallController.h"
#import "XMPersonController.h"

@interface XMBaseTabBarController ()

@end

@implementation XMBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTabbas];
}

// 初始化tabbar
- (void)initTabbas
{
    NSMutableArray *controllers = [NSMutableArray array];
    NSArray *tabbarDatas = @[
                             @[@"home-default", @"home-selected", @"首页", [XMStallController class]],
                             @[@"gallery_default", @"gallery_selected", @"展厅", [XMGalleryController class]],
                             @[@"business_default", @"business_select", @"集市", [XMBusinessController class]],
                             @[@"mine_default", @"mine_selected", @"我的", [XMPersonController class]]];
    for (int i = 0; i < tabbarDatas.count; i++) {
        NSString *icon_nomarl = [tabbarDatas[i] objectAtIndex:0];
        NSString *icon_select = [tabbarDatas[i] objectAtIndex:1];
        NSString *title = [tabbarDatas[i] objectAtIndex:2];
        XMBaseController *vc = [[[tabbarDatas[i] objectAtIndex:3] alloc] init];
//        vc.navigationController.interactivePopGestureRecognizer.enabled = YES;
        XMBaseNavigationController *baseNavigationVC = [[XMBaseNavigationController alloc] initWithRootViewController:vc];
        baseNavigationVC.tabBarItem = [self createTabBarItem:icon_nomarl selectIcon:icon_select title:title tag:i];
        [controllers addObject:baseNavigationVC];
    }
    self.viewControllers = controllers;
}

- (UITabBarItem *)createTabBarItem:(NSString *)icon_normal
                        selectIcon:(NSString *)icon_select
                             title:(NSString *)title
                               tag:(NSInteger)tag
{
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:nil tag:tag];
    [item setTitleTextAttributes:@{NSFontAttributeName: kSysFont(12), NSForegroundColorAttributeName: kHexColor(0x000)} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSFontAttributeName: kSysFont(12), NSForegroundColorAttributeName: kMainColor} forState:UIControlStateSelected];
    [item setTitlePositionAdjustment:UIOffsetMake(item.titlePositionAdjustment.horizontal, item.titlePositionAdjustment.vertical)];
    [item setImage:[kGetImage(icon_normal) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item setSelectedImage:[kGetImage(icon_select) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    return item;
}


@end
