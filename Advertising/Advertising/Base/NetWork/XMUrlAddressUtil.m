//
//  RKUrlAddressUtil.m
//  Refactoring
//
//  Created by dingqiankun on 2019/3/22.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMUrlAddressUtil.h"

// 登录
NSString *const cLoginApi = @"api/user/loginCode";

// 发送验证码
NSString *const cValidateCodeApi = @"api/user/sendMsg";

// 获取银行卡列表
NSString *const cBankListSelectApi = @"api/bankCard/bankInfo";

// 查询绑定过的银行卡
NSString *const cBankCardRueryApi = @"api/bankCard/findMyBank";

// 手机运营商认证第一步
//NSString *const cMobileOperatorApi1 = @"api/authentication/operatorCertification/getSmsCode";
NSString *const cMobileOperatorApi1 = @"api/authentication/operatorCertification/step1";

// 手机运营商认证第二步
NSString *const cMobileOperatorApi2 = @"api/authentication/operatorCertification/authencation";

// 联系人认证
NSString *const cContactApi = @"api/authentication/emergencyContactAuth";

// 查询用户认证结果
NSString *const cAuthResultApi = @"api/authentication/selectMyAuthentication";

// 查询用户需要哪些认证
NSString *const cUserNeedAuthApi = @"api/authentication/queriesAuthentication";

// 身份证图像识别认证结果查询
NSString *const cUserIdentityAuthApi = @"api/authentication/userIdentityAuth";

// 查询订单
NSString *const cOrderApi = @"api/evaluation/selectUserEvaluationAll";

// 绑卡第一步
NSString *const cBindCard1Api = @"api/bankCard/authenticationCardBindingStep1";

// b绑卡第二步
NSString *const cBindCard2Api = @"api/bankCard/authenticationCardBindingStep2";

// 查看是否有未读的消息
NSString *const cReadMsgApi = @"api/userMessage/getUserMessageStatus";

//  获取用户状态
NSString *const cUserStatusApi = @"api/evaluation/getUserStatus";

// 试算接口
NSString *const cTrailApi = @"api/evaluation/trialEvaluation";

// 借贷协议
NSString *const caAgreeApi = @"api/protocol/selectOneByType";

// 最大期数
NSString *const cMaxPeriodApi = @"api/paramSetting/getParamSetting";

// 申请借款订单
NSString *const cApplyOrderApi = @"api/evaluation/addEvaluation";

// 用户信息
NSString *const cUsetInfoApi = @"api/user/selectCurrentUser";

//我的资料
NSString *const cMyInfomationApi = @"api/user/myInformation";

// 我的消息
NSString *const cMyNewsApi = @"api/userMessage/selectThisUserMessageAll";

// 消息已读
NSString *const cNewsReaded = @"api/userMessage/update";

// 订单详情
NSString *const cOrderDetailApi = @"api/evaluation/lendingDetails";

// 申请展期
NSString *const cApplyRollApi = @"api/renewal/backendExtension";

// 试算
NSString *const cRollTrialApi = @"api/renewal/appQuery";

// 展期支付
NSString *const cRollPayApi = @"api/evaluation/userSubmissionExtension";

// 展期订单列表
NSString *const cRollOrderlListApi = @"api/evaluation/listofExtendedOrders";

// 支付
NSString *const cPayApi = @"api/pay/paymentInterface";

//帮助中心信息查询
NSString *const cHelpCenter = @"api/helpCenter/selectTypeOne";

//通讯录上传
NSString *const cUploadContact = @"api/authentication/auth/txl";

//app信息上传
NSString *const cUploadAppInfo = @"api/authentication/installedapps/up";

//用户登出
NSString *const cLoginOut = @"api/user/logout";
//用户反馈
NSString *const cAppFeedback = @"api/appFeedback/add";
//App查询最新版本
NSString *const cSelectCurrentVersion = @"api/version/selectCurrentVersion";

//人像认证前调用接口获取partnerOrderId
NSString *const cPartnerOrderId = @"api/authentication/userIdentityOrderId";


