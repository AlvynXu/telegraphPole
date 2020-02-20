//
//  XMMineHeadView.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/2.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMGetUserInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMMineHeadView : UIView

@property(nonatomic, strong)UIButton *scopyBtn;

@property(nonatomic, strong)XMCurrentUserInfo *userInfo;

@property(nonatomic, strong)UIButton *invitationBtn;  // 邀请好友

@property(nonatomic, strong)RACSubject *subject;

@property(nonatomic, strong)XMUserBaseNumInfo *baseNumInfo;

@end

NS_ASSUME_NONNULL_END
