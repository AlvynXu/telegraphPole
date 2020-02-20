//
//  XMPublishItemModel.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMPublishItemModel : NSObject

@property(nonatomic, strong)UIImage *coverImage; // 封面图片

@property(nonatomic, assign)NSInteger type;  // 1 文字  2 图片  3 视频

@property(nonatomic, strong)NSURL *movieUrl;

@property(nonatomic, copy)NSString *content;

@end

NS_ASSUME_NONNULL_END
