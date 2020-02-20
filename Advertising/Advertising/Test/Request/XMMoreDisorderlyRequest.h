//
//  RKMoreDisorderlyRequest.h
//  Refactoring
//
//  Created by dingqiankun on 2019/4/2.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMMoreDisorderlyDownRequest : XMBaseRequest

@property(nonatomic, assign)NSInteger siteId;

@property(nonatomic, assign)NSInteger pid;

@end

@interface XMMoreDisorderlyUpRequest : XMBaseRequest

@property(nonatomic, assign)NSInteger siteId;

@property(nonatomic, assign)NSInteger rid;

@end



NS_ASSUME_NONNULL_END
