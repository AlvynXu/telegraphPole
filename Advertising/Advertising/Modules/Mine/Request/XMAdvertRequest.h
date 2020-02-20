//
//  XMAdvertRequest.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBasePageRequest.h"
#import "XMAdvertModel.h"
#import "XMCollectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMAdvertRequest : XMBasePageRequest


@end



@interface XMCollectRequest : XMBasePageRequest


@end

@interface XMDeleteRequest : XMBaseRequest

@property(nonatomic, assign)NSInteger itemId;

@end

NS_ASSUME_NONNULL_END
