//
//  XMAreaSelectVm.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/29.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMAreaSelectRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMAreaSelectVm : NSObject

@property(nonatomic, strong)NSMutableArray *parentArray;  //省

@property(nonatomic, strong)NSMutableArray *cityArray;  //城市

@property(nonatomic, strong)NSMutableArray *countyArray;  //县

@property(nonatomic, strong)NSMutableArray *streetArray;  //街道

@property(nonatomic, strong)RACSubject *subject;

@property(nonatomic, assign)BOOL isdefaultFirst;   // 默认


// 获取市区
- (void)getCityWith:(NSString *)code;

// 获取县级
- (void)getCountWith:(NSString *)code;

// 获取街道
- (void)getStreetWith:(NSString *)code;


@end

NS_ASSUME_NONNULL_END
