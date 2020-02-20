//
//  UIView+XMDragable.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/26.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (XMDragable)

- (void)addDragableActionWithEnd:(void (^)(CGRect endFrame))endBlock;

@end

NS_ASSUME_NONNULL_END
