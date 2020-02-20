//
//  XMBoothMangerModel.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMBoothMangerItemModel : NSObject

@property(nonatomic, assign)BOOL select;

@property(nonatomic, copy)NSString *boothCode;   // 展位编码

@property(nonatomic, assign)NSInteger Id;  // ID

@property(nonatomic, copy)NSString *day;  // 剩余天数

@property(nonatomic, copy)NSString *address;  // 地址

@property(nonatomic, copy)NSString *city;  //城市

@property(nonatomic, copy)NSString *district;  //区县

@property(nonatomic, copy)NSString *street;  //街道

@property(nonatomic, copy)NSString *leftDate;  // 剩余天数

@end

@interface XMBoothMangerModel : NSObject

@property(nonatomic, strong)NSArray<XMBoothMangerItemModel *> *records;

@end

NS_ASSUME_NONNULL_END
