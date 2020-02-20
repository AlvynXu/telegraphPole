//
//  XMHomeHeadLbl.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/26.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHomeHeadLbl : UIView

@property(nonatomic, copy)NSString *downStr;

@property(nonatomic, copy)NSString *upStr;

@property(nonatomic, strong)UILabel *noReadLbl;

@property(nonatomic, strong)UITapGestureRecognizer *tap;

@end

NS_ASSUME_NONNULL_END
