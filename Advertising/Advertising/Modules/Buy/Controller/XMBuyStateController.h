//
//  XMBuyStateController.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/28.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBaseController.h"

typedef NS_ENUM(NSUInteger, Page) {
    PageAgent  = 0,   // 代理
    PageLanlord,   //地主
    PageBoot   // 展位
};

NS_ASSUME_NONNULL_BEGIN

@interface XMBuyStateController : XMBaseController

@property(nonatomic, assign)Page page;

@property(nonatomic, assign)NSInteger Id;

@property(nonatomic, copy)NSString *oneStr;

@property(nonatomic, copy)NSString *twoStr;


@end

NS_ASSUME_NONNULL_END
