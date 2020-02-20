//
//  RKDataModel.h
//  Refactoring
//
//  Created by dingqiankun on 2019/4/1.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMDataModel : NSObject

@property(nonatomic, copy)NSString *mid;

@property(nonatomic, copy)NSString *uid;

@property(nonatomic, copy)NSString *title;

@property(nonatomic, copy)NSString *pic_url;

@property(nonatomic, copy)NSString *shopTitle;

@property(nonatomic, copy)NSString *price;

@end

NS_ASSUME_NONNULL_END
