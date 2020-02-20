//
//  XMTeamHeadView.h
//  Advertising
//
//  Created by dingqiankun on 2019/11/27.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMTeamItemView : UIView

@property(nonatomic, strong)UIImageView *circleImgV;

@property(nonatomic, strong)UILabel *titleLbl;

@property(nonatomic, strong)UILabel *numLbl;

@property(nonatomic, strong)UILabel *detailLbl;

@property(nonatomic, strong)UIImageView *qrCodeImgV;

- (void)hideView:(BOOL)hide;

@end

NS_ASSUME_NONNULL_END
