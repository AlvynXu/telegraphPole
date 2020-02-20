//
//  XMProjectBootomView.m
//  Advertising
//
//  Created by dingqiankun on 2020/1/14.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import "XMProjectBootomView.h"

@interface XMProjectBootomView()


@end

@implementation XMProjectBootomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    CGFloat left = 20;
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(left));
        make.width.equalTo(@90);
        make.height.equalTo(@45);
        make.centerY.equalTo(self);
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addBtn);
        make.width.height.equalTo(@(45));
        make.centerY.equalTo(self.addBtn);
    }];
    
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.deleteBtn.mas_right).offset(15);
        make.height.width.centerY.equalTo(self.deleteBtn);
    }];
    
    [self.statusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.equalTo(@45);
        make.width.equalTo(@120);
        make.centerY.equalTo(self);
    }];
}

- (void)setStatus:(NSInteger)status
{
    _status = status;
    
    self.statusBtn.enabled = status==2||status==3?YES:NO;
    UIColor *btnColor = self.statusBtn.enabled?kHexColor(0x88CC69):kHexColor(0xB9B9B9);
    [self.statusBtn setBackgroundColor:btnColor];
    [self.statusBtn setTitle:[self statusStr] forState:UIControlStateNormal];
    
    self.deleteBtn.hidden = status == -1||status==2?NO:YES;  // 未审核 未发布状态可用，其它不可用
    
    self.addBtn.hidden = status == 3?NO:YES;   // 发布中 追加按钮可用 其他不可用
    
    self.editBtn.hidden = status == 3 || status == 0?YES:NO;  // 审核中 发布中 编辑按钮不可用
}

- (NSString *)statusStr
{
    NSString *status= @"";
    switch (self.status) {
        case -1:
            status=@"未审核";
            break;
        case 0:
            status=@"审核中";
            break;
        case 3:
            status=@"下架";
            break;
        case 2:
            status=@"发布";
            break;
        default:
            break;
    }
    return status;
}

- (UIButton *)deleteBtn
{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:kGetImage(@"project_delete_icon") forState:UIControlStateNormal];
        [self addSubview:_deleteBtn];
    }
    return _deleteBtn;
}

- (UIButton *)addBtn
{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setTitle:@"追加展位" forState:UIControlStateNormal];
        _addBtn.backgroundColor = kHexColor(0xff9700);
        _addBtn.titleLabel.font = kSysFont(15);
        _addBtn.layer.cornerRadius = 22.5;
        [_addBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [self addSubview:_addBtn];
    }
    return _addBtn;
}

- (UIButton *)editBtn
{
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setImage:kGetImage(@"project_edit") forState:UIControlStateNormal];
        [self addSubview:_editBtn];
    }
    return _editBtn;
}

- (UIButton *)statusBtn
{
    if (!_statusBtn) {
        _statusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _statusBtn.titleLabel.font = kSysFont(15);
        _statusBtn.layer.cornerRadius = 22.5;
        [_statusBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [self addSubview:_statusBtn];
    }
    return _statusBtn;
}


@end
