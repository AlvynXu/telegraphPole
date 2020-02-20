//
//  XMLandlordBuyCell.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/27.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLandlordModel.h"
#import "XMBoothModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMLandlordBuyCell : UITableViewCell

@property(nonatomic, strong)UIButton *buyBtn;

// 地主
@property(nonatomic, strong)XMLandlordRecordsModel *landlordModel;

//展位
@property(nonatomic, strong)XMBoothRecordsModel *boothModel;


@end

NS_ASSUME_NONNULL_END
