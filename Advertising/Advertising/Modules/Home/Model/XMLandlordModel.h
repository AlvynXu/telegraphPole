//
//  XMLandlordModel.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/29.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMLandlordRecordsModel : NSObject

@property(nonatomic, copy)NSString *areaCode;

@property(nonatomic, copy)NSString *code;

@property(nonatomic, assign)NSInteger Id;

@property(nonatomic, copy)NSString *name;

@property(nonatomic, assign)CGFloat price;

@property(nonatomic, assign)NSInteger status;

@end

@interface XMLandlordDataModel : NSObject

@property(nonatomic, copy)NSString *notSoldCount;  //

@property(nonatomic, copy)NSString *soldCount;

@property(nonatomic, assign)NSInteger current; //

@property(nonatomic, strong)NSArray *orders;

@property(nonatomic, assign)NSInteger pages;

@property(nonatomic, strong)NSArray<XMLandlordRecordsModel *> *records;


@end

@interface XMCityCodeModel : NSObject

@property(nonatomic, copy)NSString *code; //

@property(nonatomic, copy)NSString *Id;

@property(nonatomic, assign)NSInteger level;

@property(nonatomic, copy)NSString *name;

@property(nonatomic, assign)NSInteger price;

@property(nonatomic, copy)NSString *parentCode;


@end



NS_ASSUME_NONNULL_END
