//
//  RKLoginUtil.m
//  Refactoring
//
//  Created by dingqiankun on 2019/3/26.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMLoginUtil.h"
#import "RKBaseNavigationController.h"
#import "RKLoginController.h"
#import "RKUserDefaultsUtil.h"
#import "NSDate+RFC1123.h"
#import "RKBaseTabBarController.h"

@interface XMLoginUtil()

@property(nonatomic, strong)RKUserInfo *userInfo;  //用户信息

@end

@implementation XMLoginUtil

#define _kUserTokenInfo @"_UserTokenPrivateKey"

+ (instancetype)sharedInstance
{
    static XMLoginUtil *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XMLoginUtil alloc]init];
    });
    return sharedInstance;
}


- (void)goLoginComplete:(void(^)(void))doSome animation:(BOOL)animation
{
    if (self.login) {
        
    }else{
        RKLoginController *loginVC = [RKLoginController new];
        __block RKBaseNavigationController *loginNav = [[RKBaseNavigationController alloc] initWithRootViewController:loginVC];
        [UIViewController.currentViewController presentViewController:loginNav animated:animation completion:nil];
        loginVC.successBlock = ^{
            if (doSome) {
                [UIViewController.currentViewController dismissViewControllerAnimated:YES completion:nil];
                doSome();
            }
        };
    }
}

- (void)storageUserTokenWithDict:(NSDictionary *)dict
{
    @try {
        self.userInfo = [RKUserInfo mj_objectWithKeyValues:dict];
        //只保存用户部分相关信息，避免很多字段为null，导致崩溃
        NSDictionary *params = @{@"id" : dict[@"id"],
                                 @"phone" : dict[@"phone"],
                                 @"token" : dict[@"token"],
                                 @"devAlias" : dict[@"devAlias"],
                                 @"gmtDatetime" : dict[@"gmtDatetime"],
                                 @"uptDatetime" : dict[@"uptDatetime"]};
        [RKUserDefaultsUtil saveValue:params forkey:_kUserTokenInfo];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    // 发送通知  用户登录
}

- (void)loginOut
{
    // 发送通知  已经退出登录
    [self clearToken];
}

- (void)clearToken
{
    self.userInfo = nil;
    [RKUserDefaultsUtil saveValue:nil forkey:_kUserTokenInfo];
    // 发送通知用户退出登录
}

- (NSString *)userToken
{
    return self.userInfo.token;
}

- (NSString *)phone
{
    return self.userInfo.phone;
}

- (NSString *)uid
{
    return self.userInfo.uId;
}

- (BOOL)login
{
    // 双层判断，1.token是否存在  2.token是否有效
    if (self.userToken) {
        return YES;
    }
    return NO;
}


// 判断登录是否超时
- (BOOL)isValidate
{
    NSString *currentTimestamp = [NSDate getCurrentTimestamp];
    if (currentTimestamp) {
        
    }
    return YES;
}

- (RKUserInfo *)userInfo
{
    NSDictionary *dict = [RKUserDefaultsUtil valueWithKey:_kUserTokenInfo];
    if (dict == nil) {
        return nil;
    }
    return [RKUserInfo mj_objectWithKeyValues:dict];
}


@end






@implementation RKUserInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"uId": @"id"};
}

@end
