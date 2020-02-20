//
//  XMAreaSelectModel.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/29.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMAreaItemModel : NSObject

@property(nonatomic, copy)NSString *code;

@property(nonatomic, copy)NSString *Id;

@property(nonatomic, assign)NSInteger level;

@property(nonatomic, copy)NSString *name;

@property(nonatomic, copy)NSString *parentCode;

@property(nonatomic, copy)NSString *price;

@property(nonatomic, assign)BOOL select;

@end

@interface XMAreaCommonModel : NSObject

@property(nonatomic, strong)NSMutableArray<XMAreaItemModel *> *data;

@end






@interface XMStreetItemModel : NSObject

@property(nonatomic, copy)NSString *areaCode;

@property(nonatomic, copy)NSString *code;

@property(nonatomic, copy)NSString *Id;

@property(nonatomic, copy)NSString *name;

@property(nonatomic, copy)NSString *status;

@property(nonatomic, copy)NSString *price;

@property(nonatomic, assign)BOOL select;

@end


@interface XMStreetModel : NSObject

@property(nonatomic, strong)NSMutableArray<XMStreetItemModel *> *data;

@end

NS_ASSUME_NONNULL_END
