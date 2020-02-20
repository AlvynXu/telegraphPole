//
//  XMBuyStateView.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/28.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMBuyStateView : UIView

@property(nonatomic, strong)UIButton *goBtn;

@property(nonatomic, strong)UILabel *oneLbl;
@property(nonatomic, strong)UILabel *twoLbl;
@property(nonatomic, strong)UILabel *threeLbl;
@property(nonatomic, strong)UILabel *titleLbl;
@property(nonatomic, strong)UIImageView *line3;

- (void)agentView;
- (void)hideSomeView;

@end

NS_ASSUME_NONNULL_END
