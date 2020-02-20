//
//  UIViewController+RKViewController.m
//  Refactoring
//
//  Created by dingqiankun on 2019/3/26.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "UIViewController+RKViewController.h"

@implementation UIViewController (RKViewController)

+ (UIViewController*)currentViewController
{
    return [self currentControllerWithRootController:kWindow.rootViewController];
}

+ (UIViewController *)currentControllerWithRootController:(UIViewController *)rootController
{
    if ([rootController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabbarController = (UITabBarController *)rootController;
        return [self currentControllerWithRootController:tabbarController.selectedViewController];
    }else if ([rootController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootController;
        
        return [self currentControllerWithRootController:navigationController.visibleViewController];
    }else if (rootController.presentedViewController) {
        UIViewController *presentedController = rootController.presentedViewController;
        return [self currentControllerWithRootController:presentedController];
    }else{
        return rootController;
    }
}

@end
