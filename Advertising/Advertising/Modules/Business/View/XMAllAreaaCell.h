//
//  XMAllAreaaCell.h
//  Advertising
//
//  Created by dingqiankun on 2020/1/7.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMAreaSelectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMAllAreaaCell : UICollectionViewCell

@property(nonatomic, strong)UILabel *titleLbl;

@property(nonatomic, strong)XMAreaItemModel *itemModel;

@end

NS_ASSUME_NONNULL_END
