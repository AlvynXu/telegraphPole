//
//  XMPublishRequest.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/20.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMSaveBaseInfoRequest : XMBaseRequest

@property(nonatomic, assign)NSInteger pId;  // 添加商品为-1992

@property(nonatomic, assign)NSInteger categoryId; //商品类目ID

@property(nonatomic, copy)NSString *desc;
@property(nonatomic, copy)NSString *addressDetail;
@property(nonatomic, copy)NSString *phone;
@property(nonatomic, strong)NSData *multipartFile;

@end

@interface XMSaveDetailInfoRequest : XMBaseRequest

@property(nonatomic, assign)NSInteger itemId;
@property(nonatomic, copy)NSString *desc;
@property(nonatomic, assign)NSInteger seq;  //
@property(nonatomic, assign)NSInteger type;
@property(nonatomic, strong)NSData *multipartFile;

@end

NS_ASSUME_NONNULL_END
