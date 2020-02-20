//
//  XMProjectDetailRequest.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/18.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseRequest.h"
#import "XMProjectDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMProjectDetailRequest : XMBaseRequest

@property(nonatomic, assign)NSInteger itemId;  // 项目ID

@end



@interface XMProjectDownRequest : XMBaseRequest

@property(nonatomic, assign)NSInteger itemId;  // 项目ID

@end

// 举报
@interface XMProjectReportRequest : XMBaseRequest

@property(nonatomic, assign)NSInteger itemId;  // 项目ID

@end

// 收藏
@interface XMProjectCollectRequest : XMBaseRequest

@property(nonatomic, assign)NSInteger itemId;  // 项目ID

@end

// 取消收藏
@interface XMProjectCancelCollectRequest : XMBaseRequest

@property(nonatomic, assign)NSInteger itemId;  // 项目ID

@end



@interface XMProjectShareRequest : XMBaseRequest

@property(nonatomic, assign)NSInteger itemId;  // 项目ID

@end


@interface XMProjectGetMessageRequest : XMBasePageRequest

@property(nonatomic, assign)NSInteger itemId;  // 项目ID

@end


// mallItemInfo/saveLeaveMessage

@interface XMProjectSaveMessageRequest : XMBaseRequest

@property(nonatomic, assign)NSInteger itemId;  // 项目ID

@property(nonatomic, copy)NSString *message; // 内容

@end




NS_ASSUME_NONNULL_END
