//
//  RKLoginUtil.h
//  Refactoring
//
//  Created by dingqiankun on 2019/3/26.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kLoginManager [XMLoginUtil sharedInstance]

NS_ASSUME_NONNULL_BEGIN

@interface XMLoginUtil : NSObject

@property(nonatomic, assign)BOOL login;  // 验证登录

@property(nonatomic, strong)NSString *userToken;  // 获取用户token

@property(nonatomic, readonly)NSString *uid; // 用户ID

@property(nonatomic, readonly)NSString *phone;  // 手机号

@property(nonatomic, readonly)NSString *invitation;  // 邀请码



// 单例 此类只能使用此方法创建对象
+ (instancetype)sharedInstance;

// 登录
- (void)goLoginComplete:(void(^)(void))doSome animation:(BOOL)animation;

// 存储用户token
- (void)storageUserTokenWithDict:(NSDictionary *)dict;

// 退出登录
- (void)loginOut;

// 获取当前等级用户头像
- (NSString *)getCurrentLevelAvarImg:(NSInteger)level;


@end




/***
 *   用户信息类
 */
@interface XMUser : NSObject

@property(nonatomic, copy)NSString *phone;

@property(nonatomic, copy)NSString *uId;

@property(nonatomic, copy)NSString *balance;  //余额

@property(nonatomic, copy)NSString *createTime;  // 创建时间

@property(nonatomic, copy)NSString *deleted;

@property(nonatomic, copy)NSString *isVip; // 是否是vip

@property(nonatomic, copy)NSString *level;  //登级

@property(nonatomic, copy)NSString *password; // 密码

@property(nonatomic, copy)NSString *profit;  // 受益

@property(nonatomic, copy)NSString *teamProfit;  //团队受益

@property(nonatomic, copy)NSString *updateTime;  //更新时间

@property(nonatomic, copy)NSString *regCode;  // 邀请码

@end


@interface RKUserInfo : NSObject

@property(nonatomic, assign)BOOL flag;  //是否是新用户

@property(nonatomic, copy)NSString *token; //用户唯一标示

@property(nonatomic, strong)XMUser *user;

@end



NS_ASSUME_NONNULL_END




