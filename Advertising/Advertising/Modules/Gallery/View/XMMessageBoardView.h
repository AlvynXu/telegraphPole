//
//  XMMessageBoardView.h
//  Advertising
//
//  Created by dingqiankun on 2020/1/15.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMMessageBoardView : UIView

@property(nonatomic, strong)UIImageView *messageImgV;  // 消息图片

@property(nonatomic, strong)UILabel *numLbl;  // 总数

@property(nonatomic, strong)UIButton *sendBtn;  // 发送留言

@property(nonatomic, strong)SZTextView *edingMessageTxt;  // 留言

- (void)resetViewWith:(BOOL)editState;

@end

NS_ASSUME_NONNULL_END
