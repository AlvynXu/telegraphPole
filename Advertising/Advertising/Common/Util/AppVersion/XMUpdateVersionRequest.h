//
//  XMUpdateVersionRequest.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/5.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMUpdateModel : NSObject

@property(nonatomic, copy)NSString *appVersion;  // 版本号

@property(nonatomic, copy)NSString *desc;  // 描述

@property(nonatomic, copy)NSString *updateInfo;  // 版本更新内容 如果服务器返回就从服务器取，无，则使用本地

@property(nonatomic, copy)NSString *downloadPth;  // 下载

@property(nonatomic, assign)BOOL enable;  // 下载

@property(nonatomic, copy)NSString *time;  // 下载

@property(nonatomic, copy)NSString *type;  // 下载

@property(nonatomic, assign)BOOL forceUpdate;  // 强制更新

- (BOOL)hasUpdate;

@end


@interface XMUpdateVersionRequest : XMBaseRequest


@end

NS_ASSUME_NONNULL_END
