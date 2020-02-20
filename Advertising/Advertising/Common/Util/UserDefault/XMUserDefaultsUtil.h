//
//  RKUserDefaultsUtils.h
//  Refactoring
//
//  Created by dingqiankun on 2019/3/28.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface XMUserDefaultsUtil : NSObject

+ (void)xm_saveValue:(id)value forkey:(NSString *)key;

+ (id)xm_valueWithKey:(NSString *)key;

+ (void)xm_saveBoolValue:(BOOL)value withKey:(NSString *)key;

+ (BOOL)xm_boolValueWithKey:(NSString *)key;


@end

NS_ASSUME_NONNULL_END
