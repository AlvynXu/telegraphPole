//
//  XMAPPShareUtil.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/4.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMAPPShareModel : NSObject

@property(nonatomic, copy)NSString *promoterId;

@property(nonatomic, copy)NSString *url;

@property(nonatomic, copy)NSString *imageBase64;

@property(nonatomic, copy)NSString *ios;

@end

@interface XMAPPShareRequest : XMBaseRequest

@end

NS_ASSUME_NONNULL_END
