//
//  RKUserAgent.h
//  Refactoring
//
//  Created by dingqiankun on 2019/5/5.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define kUserAgent [XMUserAgent sharedInstance]

@interface XMUserAgent : NSObject

@property(nonatomic, copy)NSString *userAgent;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
