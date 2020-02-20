//
//  RKJsonHelper.h
//  Refactoring
//
//  Created by 111 on 2019/6/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMJsonHelper : NSObject

+ (instancetype)sharedInstance;

/**
 *NSData转字典
 */
- (NSDictionary *)getJsonDict:(NSData *)data;

/**
 *NSData转数组
 */
- (NSMutableArray *)getJsonArray:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
