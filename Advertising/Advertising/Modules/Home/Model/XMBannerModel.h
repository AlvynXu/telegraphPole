//
//  XMBannerModel.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/17.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMBannerItemModel : NSObject

@property(nonatomic, copy)NSString *areaCode;

@property(nonatomic, copy)NSString *createTime;

@property(nonatomic, assign)NSInteger days;

@property(nonatomic, copy)NSString *endTime;

@property(nonatomic, assign)NSInteger Id;

@property(nonatomic, copy)NSString *imageUrl;

@property(nonatomic, copy)NSString *itemId;

@property(nonatomic, assign)NSInteger sort;

@property(nonatomic, assign)NSInteger type;   // 1地主 2展位 3项目 4h5

@property(nonatomic, assign)BOOL visible;

@end


@interface XMBannerModel : NSObject

@property(nonatomic, strong)NSArray<XMBannerItemModel *> *data;

@end

NS_ASSUME_NONNULL_END
