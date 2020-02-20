//
//  XMNInvitationController.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/30.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMNInvitationController : XMBaseController

@property(nonatomic, copy)NSString *userid;

@property(nonatomic, strong)RACSubject *blockSubject;

@end

NS_ASSUME_NONNULL_END
