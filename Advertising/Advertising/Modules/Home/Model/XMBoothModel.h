//
//  XMBoothModel.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/29.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface XMBoothRecordsModel : NSObject


@property(nonatomic, copy)NSString *boothCode;

@property(nonatomic, copy)NSString *boothName;

@property(nonatomic, assign)NSInteger Id;

@property(nonatomic, assign)CGFloat price;

@property(nonatomic, assign)NSInteger status;

@property(nonatomic, copy)NSString *streetId;

@property(nonatomic, assign)BOOL saved;  //是否是地主展位

@end

@interface XMBoothDataModel : NSObject

@property(nonatomic, copy)NSString *notSoldCount;  //

@property(nonatomic, copy)NSString *soldCount;

@property(nonatomic, assign)NSInteger current;

@property(nonatomic, strong)NSArray *orders;

@property(nonatomic, assign)NSInteger pages;

@property(nonatomic, strong)NSArray<XMBoothRecordsModel *> *records;

@end




NS_ASSUME_NONNULL_END
