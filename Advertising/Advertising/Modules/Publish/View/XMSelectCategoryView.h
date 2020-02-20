//
//  XMSelectCategoryView.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/20.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMSelectCategoryView : UIView

@property(nonatomic, strong)RACSubject *subject;


- (void)show;

- (void)hinde;

@end

NS_ASSUME_NONNULL_END
