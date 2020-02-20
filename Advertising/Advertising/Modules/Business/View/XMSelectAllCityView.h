//
//  XMSelectAllCityView.h
//  Advertising
//
//  Created by dingqiankun on 2020/1/3.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMSelectAllCityView : UIView

@property(nonatomic, strong)RACSubject *subject;

- (void)show;

@end

NS_ASSUME_NONNULL_END
