//
//  XMHeadLineModel.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/17.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHeadLineItemModel : NSObject

@property(nonatomic, copy)NSString *desc;   //

@property(nonatomic, copy)NSString *bannerPath;

@property(nonatomic, assign)NSInteger views;

@property(nonatomic, assign)NSInteger Id;

@end

@interface XMHeadLineModel : NSObject

@property(nonatomic, strong)NSMutableArray<XMHeadLineItemModel *> *records;   //

@end




NS_ASSUME_NONNULL_END
