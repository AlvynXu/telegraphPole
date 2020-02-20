//
//  XMMyTeamHeadView.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/27.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMTeamModel.h"
#import "XMHomeMsgModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMMyTeamHeadView : UIImageView

@property(nonatomic, assign)BOOL team;

@property(nonatomic, strong)UIImageView *goShareImgV;

@property(nonatomic, strong)XMTeamModel *teamModel;

@property(nonatomic, strong)XMHomeMsgModel *homeMSgModel;

@end

NS_ASSUME_NONNULL_END
