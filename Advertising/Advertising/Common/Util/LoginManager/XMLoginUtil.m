//
//  RKLoginUtil.m
//  Refactoring
//
//  Created by dingqiankun on 2019/3/26.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMLoginUtil.h"
#import "XMBaseNavigationController.h"
#import "XMUserDefaultsUtil.h"
#import "NSDate+RFC1123.h"
#import "XMBaseTabBarController.h"
#import "XMLoginController.h"

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
        XMLoginController *loginVC = [XMLoginController new];
        __block XMBaseNavigationController *loginNav = [[XMBaseNavigationController alloc] initWithRootViewController:loginVC];
         [loginNav setNavigationBarHidden:YES animated:YES];
        [kWindow.rootViewController presentViewController:loginNav animated:animation completion:nil];
//        loginVC.successBlock = ^{
//            if (doSome) {
//                [UIViewController.currentViewController dismissViewControllerAnimated:YES completion:nil];
//                doSome();
//            }
//        };
    }
}

- (void)storageUserTokenWithDict:(NSDictionary *)dict
{
    @try {
        self.userInfo = [RKUserInfo mj_objectWithKeyValues:dict];
        //只保存用户部分相关信息，避免很多字段为null，导致崩溃
        NSDictionary *params = @{@"flag" : dict[@"flag"],
                                 @"token" : dict[@"token"],
                                 @"user":@{ @"phone" : dict[@"user"][@"phone"],
                                            @"balance" : dict[@"user"][@"balance"],
                                            @"createTime" : dict[@"user"][@"createTime"],
                                            @"deleted" : dict[@"user"][@"deleted"],
                                            @"id" : dict[@"user"][@"id"],
                                            @"isVip" : dict[@"user"][@"isVip"],
                                            @"level" : dict[@"user"][@"level"],
                                            @"profit" : dict[@"user"][@"profit"],
                                            @"promoterId" : dict[@"user"][@"promoterId"],
                                            @"regCode" : dict[@"user"][@"regCode"],
                                            @"teamProfit" : dict[@"user"][@"teamProfit"],
                                            @"updateTime" : dict[@"user"][@"updateTime"]},
                                 };
        [XMUserDefaultsUtil xm_saveValue:params forkey:_kUserTokenInfo];
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
    [XMUserDefaultsUtil xm_saveValue:nil forkey:_kUserTokenInfo];
    // 发送通知用户退出登录
}

- (NSString *)getCurrentLevelAvarImg:(NSInteger)level
{
    switch (level) {
        case 0:
            return @"mine_tourists";
            break;
        case 1:
            return @"mine_members";
            break;
        case 2:
            return @"mine_booth";
            break;
        case 3:
            return @"mine_lanlord";
            break;
            
        default:
            return @"mine_tourists";
            break;
    }
}

- (NSString *)userToken
{
    return self.userInfo.token;
}

- (NSString *)phone
{
    
    return self.userInfo.user.phone;
}

- (NSString *)uid
{
    
    return self.userInfo.user.uId;
}

- (NSString *)invitation
{
    return self.userInfo.user.regCode;
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
    NSDictionary *dict = [XMUserDefaultsUtil xm_valueWithKey:_kUserTokenInfo];
    if (dict == nil) {
        return nil;
    }
    return [RKUserInfo mj_objectWithKeyValues:dict];
}




@end






@implementation RKUserInfo


@end


@implementation XMUser


+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"uId": @"id"};
}


@end
