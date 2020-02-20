//
//  RKEncryptionUtil.h
//  Refactoring
//
//  Created by dingqiankun on 2019/3/25.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface RKEncryptionUtil : NSObject


// md5加密
+ (NSString *)md5String:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
