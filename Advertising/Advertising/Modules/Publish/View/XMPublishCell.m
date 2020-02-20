//
//  XMPublishCell.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/15.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMPublishCell.h"

@interface XMPublishCell()<UITextViewDelegate>

@property(nonatomic, strong)UIImageView *placeImgV;

@property(nonatomic, strong)UIImageView *baseImgV;

@end

@implementation XMPublishCell

NSInteger project_maxLength = 500;

 -(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(projectDetailtextChangedExt:) name:UITextViewTextDidChangeNotification object:self.contentTxt];
        
        self.backgroundColor = UIColor.whiteColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setup];
    }
    return self;
}

// 初始化
- (void)setup
{
    [self.baseImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(@7.5);
        make.bottom.equalTo(self.mas_bottom).offset(-7.5);
    }];

    [self.placeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(self.baseImgV.mas_centerY);
        make.width.equalTo(@100);
        make.height.equalTo(@80);
    }];
    
    [self.selectImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.placeImgV);
    }];
    
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.placeImgV);
        make.width.height.equalTo(@25);
    }];
    
    [self.contentTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(self.delBtn.mas_left).offset(-20);
        make.top.equalTo(self.baseImgV.mas_top).offset(10);
        make.bottom.equalTo(self.baseImgV.mas_bottom).offset(-10);
    }];
    
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.baseImgV.mas_right).offset(-15);
        make.top.equalTo(@15);
        make.width.height.equalTo(@20);
    }];

}

- (void)setItemModel:(XMPublishItemModel *)itemModel
{
    _itemModel = itemModel;
    if (itemModel.type == 1) {
        self.contentTxt.placeholder = @"请输入内容(200字以内)";
        self.contentTxt.text = itemModel.content;
    }else if (itemModel.type == 2){
        self.contentTxt.text = @"图片";
        self.placeImgV.image = itemModel.coverImage;
    }else{
        self.contentTxt.text = @"视频";
        self.placeImgV.image = itemModel.coverImage;
    }
    [self setupView:itemModel.type];
}

- (void)setupView:(NSInteger)type
{
    if (type == 1) {
        self.placeImgV.hidden = YES;
        self.contentTxt.hidden = NO;
        self.playBtn.hidden = YES;
        self.selectImgBtn.hidden =YES;
    }else if (type == 2){
        self.placeImgV.hidden = NO;
        self.contentTxt.hidden = YES;
        self.playBtn.hidden = YES;
        self.selectImgBtn.hidden =NO;
    }else{
        self.placeImgV.hidden = NO;
        self.contentTxt.hidden = YES;
        self.playBtn.hidden = NO;
        self.selectImgBtn.hidden =YES;
    }
}


#pragma mark  -------- 修改系统编辑按钮位置

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    NSString *type = @"UITableViewCellReorderControl";
    for (UIView * view in self.subviews) {
        if ([NSStringFromClass([view class]) isEqualToString:type] || [NSStringFromClass([view class]) rangeOfString: @"Reorder"].location != NSNotFound) {
            
            NSLog(@"1️⃣%@\n\n%@", NSStringFromSelector(_cmd), view);
        }
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    NSString *type = @"UITableViewCellReorderControl";
    for (UIView * view in self.subviews) {
        if ([NSStringFromClass([view class]) isEqualToString:type] || [NSStringFromClass([view class]) rangeOfString: @"Reorder"].location != NSNotFound) {
            
            NSLog(@"2️⃣%@\n\n%@", NSStringFromSelector(_cmd), view);
            view.frame = CGRectMake(view.frame.origin.x - 15, 70, view.frame.size.width, 30);
            
        }
    }
}
- (void)willTransitionToState:(UITableViewCellStateMask)state {
    [super willTransitionToState:state];
    NSString *type = @"UITableViewCellReorderControl";
    for (UIView * view in self.subviews) {
        if ([NSStringFromClass([view class]) isEqualToString:type] || [NSStringFromClass([view class]) rangeOfString: @"Reorder"].location != NSNotFound) {
            NSLog(@"3️⃣%@\n\n%@", NSStringFromSelector(_cmd), view);
        }
    }
}
- (void)didTransitionToState:(UITableViewCellStateMask)state {
    [super didTransitionToState:state];
    NSString *type = @"UITableViewCellReorderControl";
    for (UIView * view in self.subviews) {
        if ([NSStringFromClass([view class]) isEqualToString:type] || [NSStringFromClass([view class]) rangeOfString: @"Reorder"].location != NSNotFound) {
            NSLog(@"4️⃣%@\n\n%@", NSStringFromSelector(_cmd), view);
        }
    }
}
#pragma mark - text view delegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //如果是删除减少字数，都返回允许修改
    if ([text isEqualToString:@""]) {
        return YES;
    }
    if (range.location>= project_maxLength)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)projectDetailtextChangedExt:(NSNotification *)notification
{
    if ([notification.object isKindOfClass:SZTextView.class]) {
        SZTextView *textView = notification.object;
        //该判断用于联想输入
        if (textView.text.length > project_maxLength)
        {
            textView.text = [textView.text substringToIndex: project_maxLength];
        }
        self.itemModel.content = textView.text;
    }
}


- (UIImageView *)baseImgV
{
    if (!_baseImgV) {
        _baseImgV = [[UIImageView alloc] init];
        _baseImgV.layer.borderWidth = 1;
        _baseImgV.layer.borderColor = kHexColor(0xB9B9B9).CGColor;
        _baseImgV.layer.cornerRadius = 3.0;
        _baseImgV.userInteractionEnabled = YES;
        [self addSubview:_baseImgV];
    }
    return _baseImgV;
}

- (UIImageView *)placeImgV
{
    if (!_placeImgV) {
        _placeImgV = [[UIImageView alloc] init];
        _placeImgV.userInteractionEnabled = YES;
        [self.baseImgV addSubview:_placeImgV];
    }
    return _placeImgV;
}

- (SZTextView *)contentTxt
{
    if (!_contentTxt) {
        _contentTxt = [[SZTextView alloc] init];
        _contentTxt.delegate = self;
        _contentTxt.placeholder = kFormat(@"请输入内容(%zd字以内)", project_maxLength);
        _contentTxt.font = kSysFont(13);
        [self.baseImgV addSubview:_contentTxt];
    }
    return _contentTxt;
}

- (UIButton *)delBtn
{
    if (!_delBtn) {
        _delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_delBtn setImage:kGetImage(@"project_del_icon") forState:UIControlStateNormal];
        [self.baseImgV addSubview:_delBtn];
    }
    return _delBtn;
}

- (UIButton *)playBtn
{
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playBtn.layer.cornerRadius = 12.5;
        _playBtn.layer.masksToBounds = YES;
        [_playBtn setImage:kGetImage(@"new_allPlay_44x44_") forState:UIControlStateNormal];
        [self.placeImgV addSubview:_playBtn];
    }
    return _playBtn;
}

- (UIButton *)selectImgBtn
{
    if (!_selectImgBtn) {
        _selectImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectImgBtn.hidden = YES;
        [self.placeImgV addSubview:_selectImgBtn];
    }
    return _selectImgBtn;
}


@end
