//
//  GXBaseNavigationController.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseNavigationController.h"
#import "XMStallController.h"
#import "XMBaseTabBarController.h"

@interface XMBaseNavigationController ()<UIGestureRecognizerDelegate>

@property(nonatomic, assign)BOOL pop;

@end

@implementation XMBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self apperanceSetup];
}


- (void)apperanceSetup{
    if (@available(iOS 11.0, *)) {
        
        self.navigationBar.largeTitleTextAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:24], NSForegroundColorAttributeName:kHexColor(0xFF333333)};
        //去除导航下的一条线
        UIImage *nilImg = UIImage.new;
        self.navigationBar.shadowImage = nilImg;
        
//        self.navigationBar.translucent = NO;//设为NO,防止一些空间被大标题遮住,不需要根据不同屏幕计算导航偏移
//        self.navigationBar.prefersLargeTitles = true;//两句顺序不能互换，否则大标题效果丢失
        
    }else{
        //iOS11以下去除导航下的线
        UIImage *nilImg = UIImage.new;
        self.navigationBar.shadowImage = nilImg;
        [self.navigationBar setBackgroundImage:nilImg forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault]; //导致导航栏透明
        //解决导航栏透明问题
        self.navigationBar.translucent = NO;
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.interactivePopGestureRecognizer.enabled = YES;      // 手势有效设置为YES  无效为NO
        self.interactivePopGestureRecognizer.delegate = self;    // 手势的代理设置为self
    }
    self.navigationBar.barTintColor = kHexColor(0xFFF7F7F7);
    //导航Title字体
    self.navigationBar.titleTextAttributes =  @{NSFontAttributeName: kSysFont(15), NSForegroundColorAttributeName:kHexColor(0xFF333333)};
}

//- (void)apperanceSetup
//{
////    self.navigationBar.barTintColor = [UIColor whiteColor];
//    self.navigationBar.backgroundColor = kHexColor(0xFFF7F7F7);
////    self.navigationBar.shadowImage = [UIImage new];
//}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    _pop = NO;
    if (self.childViewControllers.count > 0) {
        // 设置返回按钮
        UIBarButtonItem *barLeftItem = [[UIBarButtonItem alloc] initWithImage:[kGetImage(@"nav-back") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(onBack)];
        viewController.navigationItem.leftBarButtonItem = barLeftItem;
        
//        if (!kLoginManager.login && ![viewController isKindOfClass:RKRegisterController.class]) {
//            [kLoginManager goLoginComplete:^{
//                viewController.hidesBottomBarWhenPushed = self.viewControllers.count>0;
//                [super pushViewController:viewController animated:animated];
//            } animation:YES];
//            return;
//        }
    }
    viewController.hidesBottomBarWhenPushed = self.viewControllers.count>0;
    //    [self setStatusBarBackgroundColorForCurrentController:viewController];
    [super pushViewController:viewController animated:animated];
}

- (void)onBack
{
    
    [self popViewControllerAnimated:YES];
//    _pop = YES;
//    if ([self.visibleViewController isKindOfClass:[RKOrderDetailController class]]) {
//        [self popToRootViewControllerAnimated:YES];
//    } else {
//        [self popViewControllerAnimated:YES];
//    }
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //    [self setStatusBarBackgroundColorForCurrentController:viewController];
}

//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (_pop) {
//        [self setStatusBarBackgroundColorForCurrentController:viewController];
//    }
//}


- (void)setStatusBarBackgroundColorForCurrentController:(UIViewController *)controller
{
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        
        if (controller.navigationController.navigationBar.isHidden) {
            statusBar.backgroundColor = [UIColor clearColor];
        }else {
            if ([controller isKindOfClass:XMStallController.class]) {
                statusBar.backgroundColor = self.navigationController.navigationBar.backgroundColor;
            }else {
                statusBar.backgroundColor = self.navigationController.navigationBar.backgroundColor;
            }
            
        }
    }
}


@end
