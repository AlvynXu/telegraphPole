//
//  XMBoothMangerRequest.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBasePageRequest.h"
#import "XMBoothMangerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMBoothMangerRequest : XMBasePageRequest

@end

@interface XMBoothMangerSureRequest : XMBaseRequest

@property(nonatomic, strong)NSArray *boothIds;

@property(nonatomic, assign)NSInteger itemId;

@end

NS_ASSUME_NONNULL_END
