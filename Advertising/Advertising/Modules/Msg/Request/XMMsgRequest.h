//
//  XMMsgRequest.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/3.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBasePageRequest.h"
#import "XMMsgModel.h"

NS_ASSUME_NONNULL_BEGIN

// 消息分页
@interface XMMsgPageRequest : XMBasePageRequest

@property(nonatomic, assign)BOOL status;

@end

//api/message/getMessageInfo

@interface XMMsgSetReadRequest : XMBasePageRequest

@property(nonatomic, assign)NSInteger Id;

@end

NS_ASSUME_NONNULL_END
