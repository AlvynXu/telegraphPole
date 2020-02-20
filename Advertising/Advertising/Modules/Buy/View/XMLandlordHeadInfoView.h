//
//  XMLandlordHeadInfoView.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/25.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMRecordsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMLandlordHeadInfoView : UIView

@property(nonatomic, strong)UIButton *goBlockBtn;  // 去解锁

@property(nonatomic, strong)XMBoothRecordGetNumModel *getNumModel;

@property(nonatomic, assign)NSInteger total;

@end

NS_ASSUME_NONNULL_END
