//
//  XMNinvitationView.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/30.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPPasswordTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMNinvitationView : UIView

@property(nonatomic, strong)UIButton *backBtn;  //返回

@property(nonatomic, strong)TPPasswordTextView *invitationTxt;

@property(nonatomic, strong)UIButton *sureBtn;

@end

NS_ASSUME_NONNULL_END
