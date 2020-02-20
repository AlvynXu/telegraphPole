//
//  XMRecordsModel.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/5.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMLanlordRecordsItemModel : NSObject

@property(nonatomic, copy)NSString *city;

@property(nonatomic, copy)NSString *code;

@property(nonatomic, assign)NSInteger days;

@property(nonatomic, copy)NSString *district;

@property(nonatomic, copy)NSString *expireDate;

@property(nonatomic, copy)NSString *name;

@property(nonatomic, copy)NSString *street;

@end

@interface XMLanlordRecordModel : NSObject

@property(nonatomic, strong)NSArray<XMLanlordRecordsItemModel *> *records;

@property(nonatomic, assign)NSInteger total;

@end

@interface XMBoothRecordsItemModel : NSObject

@property(nonatomic, copy)NSString *city;

@property(nonatomic, copy)NSString *code;

@property(nonatomic, assign)NSInteger days;

@property(nonatomic, copy)NSString *district;

@property(nonatomic, copy)NSString *expireDate;

@property(nonatomic, copy)NSString *desc;

@property(nonatomic, copy)NSString *name;

@property(nonatomic, copy)NSString *street;

@property(nonatomic, copy)NSString *statusStr;

@property(nonatomic, assign)CGFloat cellHeight;

@property(nonatomic, strong)UIColor *statusColor;

@property(nonatomic, assign)NSInteger Id;

@property(nonatomic, assign)NSInteger itemId;

@property(nonatomic, assign)NSInteger rentHours;  // 剩余时间

@property(nonatomic, assign)NSInteger useStatus;   //使用状态 1闲置 2待租   4已租 5租用  6广告(已发布)

//

@end

@interface XMBoothRecordModel : NSObject

@property(nonatomic, strong)NSArray<XMBoothRecordsItemModel *> *records;

@property(nonatomic, assign)NSInteger total;

@end

@interface XMBoothRecordGetNumModel : NSObject

@property(nonatomic, copy)NSString *total;

@property(nonatomic, copy)NSString *canUsed;

@end





//records

NS_ASSUME_NONNULL_END
