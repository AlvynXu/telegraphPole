//
//  XMGetUserInfo.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/4.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMUserBaseNumInfo : NSObject

@property(nonatomic, assign)NSInteger boothCount;  //街道数量

@property(nonatomic, assign)NSInteger streetCount;  //地主数量

@end


@interface XMCurrentUserInfo : NSObject

@property(nonatomic, assign)CGFloat balance;

@property(nonatomic, assign)NSInteger createTime;

@property(nonatomic, assign)BOOL deleted;

@property(nonatomic, assign)NSInteger Id;

@property(nonatomic, assign)BOOL isVip;

@property(nonatomic, copy)NSString *levelName;

@property(nonatomic, assign)NSInteger level;  // 1：游客  2.会员  3展主 4地主
@property(nonatomic, copy)NSString *password;

@property(nonatomic, copy)NSString *phone;

@property(nonatomic, assign)CGFloat profit;
@property(nonatomic, assign)NSInteger promoterId;

@property(nonatomic, copy)NSString *regCode;

@property(nonatomic, assign)CGFloat teamProfit;
@property(nonatomic, assign)NSInteger updateTime;

@property(nonatomic, copy)NSString *levelImgName;

@end

// 获取用户基本信息
@interface XMGetUserInfoRequest : XMBaseRequest

@end


// 获取展位地主数量
@interface XMGetUserBaseNumRequest : XMBaseRequest

@end


NS_ASSUME_NONNULL_END
