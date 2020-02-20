//
//  MASConstraint+RKSafeAdapt.m
//  Refactoring
//
//  Created by dingqiankun on 2019/3/26.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "MASConstraint+RKSafeAdapt.h"

@interface MASConstraint ()

//私用函数声明
- (MASConstraint * (^)(id, NSLayoutRelation))equalToWithRelation;

@end

@implementation MASConstraint (RKSafeAdapt)

- (MASConstraint * (^)(UIView *))safeEqualToBottom{
    return ^id(UIView *view) {
        id attr = view;
        if (@available(iOS 11.0, *)) {
            attr = view.mas_safeAreaLayoutGuideBottom;
        }
        return self.equalToWithRelation(attr, NSLayoutRelationEqual);
    };
    
}
- (MASConstraint * (^)(UIView *))safeEqualToTop{
    return ^id(UIView *view) {
        id attr = view;
        if (@available(iOS 11.0, *)) {
            attr = view.mas_safeAreaLayoutGuideTop;
        }
        return self.equalToWithRelation(attr, NSLayoutRelationEqual);
    };
}

@end
