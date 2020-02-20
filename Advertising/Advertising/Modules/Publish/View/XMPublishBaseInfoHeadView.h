//
//  XMPublishBaseInfoHeadView.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMPublishBaseInfoHeadView : UIView

@property(nonatomic, strong)UIImageView *showImgV;  //封面图

@property(nonatomic, strong)SZTextView *titleTxtV;  // 标题

@property(nonatomic, strong)SZTextView *addressTxtV; // 联系地址

@property(nonatomic, strong)UITextField *phoneTxt;  // 手机号

@property(nonatomic, strong)UIButton *selectCategoryBtn; //选择类别



@end

NS_ASSUME_NONNULL_END
