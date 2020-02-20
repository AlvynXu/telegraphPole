//
//  XMRentModel.h
//  Advertising
//
//  Created by dingqiankun on 2020/1/2.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMMyRentItemModel : NSObject

@property(nonatomic, copy)NSString *cityCode;

@property(nonatomic, copy)NSString *createTime;

@property(nonatomic, assign)NSInteger days;

@property(nonatomic, assign)NSInteger Id;

@property(nonatomic, assign)NSInteger payStatus;

@property(nonatomic, assign)CGFloat price;

@property(nonatomic, assign)NSInteger soldCount;

@property(nonatomic, copy)NSString *streetCodes;

@property(nonatomic, assign)NSInteger totalCount;  //

@property(nonatomic, assign)NSInteger type;

@property(nonatomic, assign)NSInteger userId;

@end

@interface XMMyRentModel : NSObject

@property(nonatomic, strong)NSArray <XMMyRentItemModel *>*data;

@end

@interface XMRentItemModel : NSObject

@property(nonatomic, copy)NSString *cityCode;

@property(nonatomic, copy)NSString *createTime;

@property(nonatomic, assign)NSInteger days;

@property(nonatomic, assign)NSInteger Id;

@property(nonatomic, assign)NSInteger payStatus;

@property(nonatomic, assign)CGFloat price;

@property(nonatomic, assign)NSInteger soldCount;

@property(nonatomic, copy)NSString *streetCodes;

@property(nonatomic, assign)NSInteger totalCount;  //

@property(nonatomic, assign)NSInteger type;

@property(nonatomic, assign)NSInteger userId;

@end

@interface XMRentModel : NSObject

@property(nonatomic, strong)NSMutableArray <XMRentItemModel *>*records;

@end



// 可用街道

@interface XMRentCanStreetItemModel : NSObject

@property(nonatomic, copy)NSString *cityName;

@property(nonatomic, copy)NSString *districtName;

@property(nonatomic, assign)BOOL hasBooth;

@property(nonatomic, copy)NSString *streetCode;

@property(nonatomic, copy)NSString *streetName;

@property(nonatomic, assign)BOOL isSelect;

@property(nonatomic, assign)CGFloat price;

@end

@interface XMRentCanStreetModel : NSObject

@property(nonatomic, assign)NSInteger count;

@property(nonatomic, strong)NSMutableArray <XMRentCanStreetItemModel *>*userStreetDTOList;

@end


NS_ASSUME_NONNULL_END
