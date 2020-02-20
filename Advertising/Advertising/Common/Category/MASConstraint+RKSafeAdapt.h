//
//  MASConstraint+RKSafeAdapt.h
//  Refactoring
//
//  Created by dingqiankun on 2019/3/26.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "MASConstraint.h"

NS_ASSUME_NONNULL_BEGIN

@interface MASConstraint (RKSafeAdapt)

- (MASConstraint * (^)(UIView *))safeEqualToBottom;
- (MASConstraint * (^)(UIView *))safeEqualToTop;

@end

NS_ASSUME_NONNULL_END
