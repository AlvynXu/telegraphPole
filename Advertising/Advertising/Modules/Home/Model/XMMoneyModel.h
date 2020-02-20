//
//  XMMoneyModel.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/24.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMMoneyModel : NSObject

@property(nonatomic, assign)CGFloat min;   // 最小限制

@property(nonatomic, assign)CGFloat max;   // 最大限制

@property(nonatomic, assign)CGFloat rate;   // 利率

@end

NS_ASSUME_NONNULL_END
