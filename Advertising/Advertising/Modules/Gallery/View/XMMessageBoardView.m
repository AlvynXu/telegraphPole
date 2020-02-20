//
//  XMMessageBoardView.m
//  Advertising
//
//  Created by dingqiankun on 2020/1/15.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import "XMMessageBoardView.h"

@interface XMMessageBoardView()<UITextViewDelegate>

@property(nonatomic, strong)UIView *baseNormalV;   // 正常状态

@property(nonatomic, strong)UIView *baseEditingV;  // 正在编辑状态

@property(nonatomic, strong)UIImageView *editImgV;  // 编辑图

@property(nonatomic, strong)SZTextView *messageTxt;  // 留言

@property(nonatomic, strong)UIView *lineV;


@end

NSInteger message_max_num = 100;

@implementation XMMessageBoardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}

- (void)setup
{
    
    CGFloat left = 35;
    
    [self.baseNormalV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@50);
    }];
    
    [self.baseEditingV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView *lineV = [[UIView alloc] init];
    lineV.backgroundColor = kHexColor(0xf4f4f4);
    self.lineV = lineV;
    [self.baseNormalV addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.baseNormalV.mas_top).offset(0);
        make.height.equalTo(@1);
    }];
    
    [self.editImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@20);
        make.height.equalTo(@20);
        make.left.equalTo(@(left));
        make.centerY.equalTo(self.messageTxt);
    }];
    
    [self.messageTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.editImgV.mas_right).offset(20);
        make.right.equalTo(self.messageImgV.mas_left).offset(-20);
        make.top.equalTo(@10);
        make.bottom.equalTo(self.baseNormalV.mas_bottom).offset(-10);
    }];
    
    [self.edingMessageTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(left));
        make.right.equalTo(self.sendBtn.mas_left).offset(-20);
        make.top.equalTo(@10);
        make.height.greaterThanOrEqualTo(@30);
        make.bottom.equalTo(self.baseEditingV.mas_bottom).offset(-10);
    }];
    
    [self.messageImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-left);
        make.width.height.equalTo(@25);
        make.centerY.equalTo(self.messageTxt);
    }];
    
    [self.numLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.messageImgV.mas_right).offset(-2);
        make.centerY.equalTo(self.messageImgV.mas_top).offset(2);
        make.width.equalTo(@30);
        make.height.equalTo(@16);
    }];
    
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.baseEditingV.mas_right).offset(-left);
        make.width.height.equalTo(@30);
        make.bottom.equalTo(self.baseEditingV.mas_bottom).offset(-10);
    }];
    
    @weakify(self)
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [self.messageTxt addGestureRecognizer:tap];
    [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self)
        [self resetViewWith:YES];
    }];
    
    // 监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHideShow:) name:UIKeyboardDidHideNotification object:nil];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //如果是删除减少字数，都返回允许修改
    if ([text isEqualToString:@""]) {
        return YES;
    }
    if (range.location>= message_max_num)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)projectBaseDetailtextChangedExt:(NSNotification *)notification
{
    if ([notification.object isKindOfClass:SZTextView.class]) {
        SZTextView *textView = notification.object;
        //该判断用于联想输入
        if (textView.text.length > message_max_num)
        {
            textView.text = [textView.text substringToIndex: message_max_num];
        }
    }
}


#pragma mark  -------- 键盘事件
- (void)keyboardDidHideShow:(NSNotification *)na
{
    [self resetViewWith:NO];
}

- (void)resetViewWith:(BOOL)editState
{
    self.baseEditingV.hidden = !editState;
    self.baseNormalV.hidden = editState;
    
//    self.backgroundColor = UIColor.redColor;
//    if (!editState) {
//        [self.baseNormalV mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@50);
//        }];
//        [self.edingMessageTxt mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@30);
//        }];
//    }else{
//        [self.baseNormalV mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@0);
//        }];
//
//        NSLog(@"*******---  %lf", [self messageHeight]);
//        [self.edingMessageTxt mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.greaterThanOrEqualTo(@30);
//        }];
//    }
}

- (CGFloat)messageHeight
{
    if (self.edingMessageTxt.text.length <= 0) {
        return 30;
    }else{
        CGFloat height = [self.edingMessageTxt.text getStringHeightWithText:self.edingMessageTxt.text font:kSysFont(14) viewWidth:kScreenWidth - 85 - 30];
        if (height <= 30) {
            return 30;
        }else{
            return height;
        }
    }
}


- (UIView *)baseNormalV
{
    if (!_baseNormalV) {
        _baseNormalV = [UIView new];
        _baseNormalV.backgroundColor = UIColor.whiteColor;
        [self addSubview:_baseNormalV];
    }
    return _baseNormalV;
}

- (UIView *)baseEditingV
{
    if (!_baseEditingV) {
        _baseEditingV = [UIView new];
        _baseEditingV.backgroundColor = UIColor.whiteColor;
        _baseEditingV.hidden = YES;
        [self addSubview:_baseEditingV];
    }
    return _baseEditingV;
}

- (UIImageView *)editImgV
{
    if (!_editImgV) {
        _editImgV = [UIImageView new];
        _editImgV.image = kGetImage(@"project_message_edit");
        [self.baseNormalV addSubview:_editImgV];
    }
    return _editImgV;
}

- (SZTextView *)messageTxt
{
    if (!_messageTxt) {
        _messageTxt = [SZTextView new];
        _messageTxt.editable = NO;
        _messageTxt.font = kSysFont(14);
        _messageImgV.userInteractionEnabled = YES;
        _messageTxt.scrollEnabled = NO;
        _messageTxt.placeholder = @"写留言...";
        [self.baseNormalV addSubview:_messageTxt];
    }
    return _messageTxt;
}

- (SZTextView *)edingMessageTxt
{
    if (!_edingMessageTxt) {
        _edingMessageTxt = [SZTextView new];
        _edingMessageTxt.font = kSysFont(14);
        _edingMessageTxt.placeholder = @"请填写留言（100字以内）";
        _edingMessageTxt.backgroundColor = kMainBackGroundColor;;
        _edingMessageTxt.scrollEnabled = NO;
        _edingMessageTxt.delegate = self;
        _edingMessageTxt.layer.cornerRadius = 15;
        [self.baseEditingV addSubview:_edingMessageTxt];
    }
    return _edingMessageTxt;
}

- (UIImageView *)messageImgV
{
    if (!_messageImgV) {
        _messageImgV = [UIImageView new];
        _messageImgV.userInteractionEnabled = YES;
        _messageImgV.image = kGetImage(@"project_message");
        [self.baseNormalV addSubview:_messageImgV];
    }
    return _messageImgV;
}

- (UILabel *)numLbl
{
    if (!_numLbl) {
        _numLbl = [UILabel new];
        _numLbl.text = @"99+";
        _numLbl.backgroundColor = UIColor.redColor;
        _numLbl.font = kSysFont(11);
        _numLbl.textColor = UIColor.whiteColor;
        _numLbl.textAlignment = NSTextAlignmentCenter;
        _numLbl.layer.cornerRadius = 8;
        _numLbl.layer.masksToBounds = YES;
        [self.messageImgV addSubview:_numLbl];
    }
    return _numLbl;
}

- (UIButton *)sendBtn
{
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setTitle:@"留言" forState:UIControlStateNormal];
        _sendBtn.titleLabel.font = kSysFont(14);
        [_sendBtn setTitleColor:kHexColor(0x25aaff) forState:UIControlStateNormal];
        [self.baseEditingV addSubview:_sendBtn];
    }
    return _sendBtn;
}


@end
