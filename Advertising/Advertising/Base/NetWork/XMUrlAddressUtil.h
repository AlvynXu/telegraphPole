//
//  RKUrlAddressUtil.h
//  Refactoring
//
//  Created by dingqiankun on 2019/3/22.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


extern NSString *const cLoginApi;   // 登录api
extern NSString *const cValidateCodeApi;  // 获取验证码api
extern NSString *const cBankListSelectApi; //获取银行卡
extern NSString *const cBankCardRueryApi;  // 查询绑定过的银行卡
extern NSString *const cAuthResultApi;//  查询用户认证结果
extern NSString *const cUserNeedAuthApi; // 查询用户需要哪些认证
extern NSString *const cUserIdentityAuthApi;//  身份证图像识别认证结果查询
extern NSString *const cContactApi; // 联系人认证
extern NSString *const cMobileOperatorApi1; // 手机运营商认证第一步
extern NSString *const cMobileOperatorApi2; // 手机运营商认证第二步
extern NSString *const cOrderApi;  // 查询订单
extern NSString *const cBindCard1Api; // 绑卡第一步
extern NSString *const cBindCard2Api;  // 绑卡第二步
extern NSString *const cReadMsgApi;  // 消息未读接口
extern NSString *const cUserStatusApi; // 获取用户状态
extern NSString *const cTrailApi; // 试算接口
extern NSString *const caAgreeApi;  //协议接口
extern NSString *const cMaxPeriodApi; // 最大借贷期数
extern NSString *const cApplyOrderApi; // 借贷协议
extern NSString *const cUsetInfoApi; // 用户信息
extern NSString *const cMyInfomationApi;//我的资料
extern NSString *const cMyNewsApi; // 我的消息
extern NSString *const cNewsReaded; // 消息已读
extern NSString *const cOrderDetailApi; // 订单详情
extern NSString *const cApplyRollApi; // 申请展期
extern NSString *const cRollTrialApi; // 展期试算
extern NSString *const cRollPayApi;  // 展期支付
extern NSString *const cRollOrderlListApi; // 展期订单列表
extern NSString *const cPayApi; // 支付
extern NSString *const cHelpCenter;//帮助中心信息查询
extern NSString *const cUploadContact;//通讯录上传
extern NSString *const cUploadAppInfo;//app信息上传
extern NSString *const cLoginOut;//用户登出
extern NSString *const cAppFeedback;//用户反馈
extern NSString *const cSelectCurrentVersion;//App查询更新版本
//人像认证前调用接口获取partnerOrderId
extern NSString *const cPartnerOrderId;

NS_ASSUME_NONNULL_END
