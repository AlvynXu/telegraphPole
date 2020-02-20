//
//  XMMoneyNumCell.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/27.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHomeMsgModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMMoneyNumCell : UITableViewCell

@property(nonatomic, strong)XMHomeBootModel *landlordModle;  //地主

@property(nonatomic, assign)BOOL isLandlord;


@end

NS_ASSUME_NONNULL_END
