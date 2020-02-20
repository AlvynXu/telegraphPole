//
//  XMMsgModel.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/3.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMMsgItemModel : NSObject

@property(nonatomic, copy)NSString *content;

@property(nonatomic, copy)NSString *deleted;

@property(nonatomic, copy)NSString *createTime;

@property(nonatomic, copy)NSString *fromUserId;

@property(nonatomic, copy)NSString *header;

@property(nonatomic, assign)NSInteger Id;

@property(nonatomic, copy)NSString *sender;

@property(nonatomic, copy)NSString *status;

@property(nonatomic, copy)NSString *theme;   //

@property(nonatomic, copy)NSString *toUserId;

@end

@interface XMMsgModel : NSObject

@property(nonatomic, strong)NSMutableArray<XMMsgItemModel *> *records;

@end

NS_ASSUME_NONNULL_END
