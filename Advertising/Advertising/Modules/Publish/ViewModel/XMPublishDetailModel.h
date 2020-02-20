//
//  XMPublishDetailModel.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/16.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMPublishDetailModel : NSObject

@property(nonatomic, copy)NSString *categoryName;  // 类别

@property(nonatomic, copy)NSString *catename;

@property(nonatomic, assign)NSInteger categoryId;  // 类别ID

@property(nonatomic, strong)UIImage *coverImg;  // 封面图

@property(nonatomic, copy)NSString *title; //标题

@property(nonatomic, copy)NSString *phone; //电话微信

@property(nonatomic, copy)NSString *address; // 联系地址



@end

NS_ASSUME_NONNULL_END
