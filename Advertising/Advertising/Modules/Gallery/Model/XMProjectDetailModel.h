//
//  XMProjectDetailModel.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/18.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMProjectListItemModel : NSObject

@property(nonatomic, copy)NSString *filePath; //文件地址

@property(nonatomic, copy)NSString *desc; // 描述

@property(nonatomic, assign)NSInteger type;  //类型

@property(nonatomic, assign)CGFloat descHeight;  // 高度

@property(nonatomic, assign)CGFloat imgHeight;  // 图片高度

@property(nonatomic, strong)UIImage *thumbnail_img;  // 视频封面UIImage

@property(nonatomic, strong)NSMutableArray *movieUrls; // 视频url数组


- (void)initOtherParam;

@end

@interface XMProjectDetailModel : NSObject

@property(nonatomic, assign)BOOL collect;

@property(nonatomic, assign)BOOL hasReport;

@property(nonatomic, copy)NSString *addressDetail; //地址

@property(nonatomic, assign)CGFloat addressHeight;  // 高度

@property(nonatomic, copy)NSString *desc; // 描述

@property(nonatomic, copy)NSString *phone; //联系方式

@property(nonatomic, assign)NSInteger views;  // 浏览

@property(nonatomic, assign)NSInteger shareCount;  // 分享

@property(nonatomic, strong)NSArray <XMProjectListItemModel *>*detailList;

@property(nonatomic, assign)CGFloat descHeight;  // 高度

@property(nonatomic, assign)NSInteger status;

@property(nonatomic, assign)NSInteger Id;

@property(nonatomic, copy)NSString *bannerPath;  // 图片路径

@property(nonatomic, assign)NSInteger categoryId;  // 分类ID

@end


// 留言

@interface XMProjectMessageItemModel : NSObject

@property(nonatomic, assign)NSInteger Id;

@property(nonatomic, assign)NSInteger itemId;  // ID

@property(nonatomic, copy)NSString *message;   // 消息信息

@property(nonatomic, copy)NSString *phone;   // 手机号

@property(nonatomic, assign)NSInteger time;   // 时间

@property(nonatomic, assign)NSInteger userId;  // 用户ID

@property(nonatomic, assign)NSInteger userLevel;  // 用户等级

@property(nonatomic, assign)CGFloat messageHeight; // 消息内容高度

@end

@interface XMProjectGetMessageModel : NSObject

@property(nonatomic, strong)NSArray *records;

@property(nonatomic, assign)NSInteger total;

@property(nonatomic, copy)NSString *totalStr;

@end



NS_ASSUME_NONNULL_END
