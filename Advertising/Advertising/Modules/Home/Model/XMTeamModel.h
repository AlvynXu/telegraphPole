//
//  XMTeamModel.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/3.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMTeamModel : NSObject

@property(nonatomic, assign)NSInteger directCount;

@property(nonatomic, assign)NSInteger indirectCount;

@property(nonatomic, copy)NSString *name;

@property(nonatomic, copy)NSString *time;

@property(nonatomic, assign)NSInteger totalCount;

@end

@interface XMTeamPageItemModel : NSObject

@property(nonatomic, assign)NSInteger directCount; // 直推

@property(nonatomic, copy)NSString *name;

@property(nonatomic, copy)NSString *time;

@property(nonatomic, assign)NSInteger totalCount;

@end

@interface XMTeamPageModel : NSObject

@property(nonatomic, strong)NSArray<XMTeamPageItemModel *> *records;

@end

@interface XMProfitPageItemModel : NSObject

@property(nonatomic, copy)NSString *type;

@property(nonatomic, copy)NSString *name;

@property(nonatomic, copy)NSString *time;

@property(nonatomic, assign)CGFloat amount;

@property(nonatomic, assign)NSInteger Id;

@property(nonatomic, copy)NSString *typeString;


@end

@interface XMProfitPageModel : NSObject

@property(nonatomic, strong)NSArray<XMProfitPageItemModel *> *records;

@end


NS_ASSUME_NONNULL_END
