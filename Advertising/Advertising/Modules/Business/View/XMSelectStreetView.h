//
//  XMSelectStreetView.h
//  Advertising
//
//  Created by dingqiankun on 2020/1/7.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMAreaSelectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMSelectStreetView : UIView

@property(nonatomic, strong)NSArray *dataSource;

@property(nonatomic, strong)UICollectionView *collectionV;

@property(nonatomic, strong)XMAreaItemModel *itemModel;

@property(nonatomic, assign)BOOL cancelSelect;

@property(nonatomic, strong)RACSubject *subject;

// 全选
- (void)allReloadSelct;

// 取消全选
- (void)cancelAllSelect;

@end

NS_ASSUME_NONNULL_END
