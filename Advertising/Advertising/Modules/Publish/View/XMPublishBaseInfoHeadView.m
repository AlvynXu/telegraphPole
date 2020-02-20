//
//  XMPublishBaseInfoHeadView.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMPublishBaseInfoHeadView.h"

@interface XMPublishBaseInfoHeadView()<UITextViewDelegate, UITextFieldDelegate>

@property(nonatomic, strong)UILabel *categoryLbl;  // 分类
@property(nonatomic, strong)UIView *categoryV;
@property(nonatomic, strong)UILabel *showImgLbl;   // 展位图
@property(nonatomic, strong)UILabel *titleLbl;   // 标题
@property(nonatomic, strong)UILabel *phoneLbl;   // 手机号
@property(nonatomic, strong)UILabel *addressLbl;  // 联系地址
@property(nonatomic, strong)UILabel *detailLbl;   // 详情
@property(nonatomic, strong)UIImageView *downArrowImgV;  // 下拉框

@end

@implementation XMPublishBaseInfoHeadView

NSInteger const publish_max_title = 40;
NSInteger const publish_max_num_phone = 20;
NSInteger const publish_max_num_address = 50;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(projectBaseInfotextChangedExt:) name:UITextViewTextDidChangeNotification object:nil];
        self.backgroundColor = UIColor.whiteColor;
        [self setup];
    }
    return self;
}

// 初始化
- (void)setup
{
    CGFloat marginTop = 7;
    CGFloat duanMarginTop = 20;
    [self.categoryLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.height.equalTo(@16);
        make.width.equalTo(@35);
        make.top.equalTo(@30);
    }];
    
    [self.categoryV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryLbl.mas_bottom).offset(marginTop);
        make.height.equalTo(@40);
        make.right.equalTo(self.mas_right).offset(-15);
        make.left.equalTo(self.categoryLbl);
    }];
    
    [self.downArrowImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@14);
        make.height.equalTo(@10);
        make.centerY.equalTo(self.categoryV);
        make.right.equalTo(self.categoryV.mas_right).offset(-15);
    }];
    
    [self.selectCategoryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.categoryV.mas_left).offset(15);
        make.centerY.equalTo(self.categoryV);
        make.right.equalTo(self.downArrowImgV.mas_left).offset(-30);
        make.height.equalTo(@25);
    }];
    
    [self.showImgLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryV.mas_bottom).offset(duanMarginTop);
        make.left.height.equalTo(self.categoryLbl);
        make.width.equalTo(@50);
    }];
    
    [self.showImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.categoryV);
        make.width.equalTo(@(175));
        make.height.equalTo(@85);
        make.top.equalTo(self.showImgLbl.mas_bottom).offset(marginTop);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.categoryLbl);
        make.top.equalTo(self.showImgV.mas_bottom).offset(duanMarginTop);
    }];
    
    [self.titleTxtV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.showImgV);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.equalTo(@50);
        make.top.equalTo(self.titleLbl.mas_bottom).offset(marginTop);
    }];
    
    [self.phoneLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(self.categoryLbl);
        make.width.equalTo(@65);
        make.top.equalTo(self.titleTxtV.mas_bottom).offset(duanMarginTop);
    }];
    
    [self.phoneTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@45);
        make.top.equalTo(self.phoneLbl.mas_bottom).offset(marginTop);
        make.right.equalTo(self.mas_right).offset(-15);
        make.left.equalTo(self.titleTxtV);
    }];
    
    [self.addressLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.phoneLbl);
        make.top.equalTo(self.phoneTxt.mas_bottom).offset(duanMarginTop);
    }];
    
    [self.addressTxtV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneTxt);
        make.top.equalTo(self.addressLbl.mas_bottom).offset(marginTop);
        make.height.equalTo(@50);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    
    [self.detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(self.categoryLbl);
        make.top.equalTo(self.addressTxtV.mas_bottom).offset(30);
    }];
    [self addtTextLimitNum];
}

- (void)addtTextLimitNum
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChangedBaseInfo:) name:@"UITextFieldTextDidChangeNotification" object:self.phoneTxt];
}

- (void)textFiledEditChangedBaseInfo:(NSNotification *)obj
{
    UITextField *textField = (UITextField *)obj.object;
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];       //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length >= publish_max_num_phone) {
                textField.text = [toBeString substringToIndex:publish_max_num_phone];
            }
        }       // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
        }
    }   // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length >= publish_max_num_phone) {
            textField.text = [toBeString substringToIndex:publish_max_num_phone];
        }
    }
}

#pragma mark   ----------  文本输入代理
//
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //如果是删除减少字数，都返回允许修改
    if ([text isEqualToString:@""]) {
        return YES;
    }
    if (range.location>= (textView==self.titleTxtV?publish_max_title:publish_max_num_address))
    {
        return NO;
    }
    else
    {
        return YES;
    }
}


- (void)projectBaseInfotextChangedExt:(NSNotification *)notification

{
    if ([notification.object isKindOfClass:SZTextView.class]) {
        SZTextView *textView = notification.object;
        //该判断用于联想输入
            if (textView == self.titleTxtV) {
                if (textView.text.length > publish_max_title)
                {
                    textView.text = [textView.text substringToIndex: publish_max_title];
                }
            }
            //该判断用于联想输入
            if (textView == self.addressTxtV) {
                if (textView.text.length > publish_max_num_address)
                {
                    textView.text = [textView.text substringToIndex: publish_max_num_address];
                }
            }
    }
}

- (UILabel *)categoryLbl
{
    if (!_categoryLbl) {
        _categoryLbl = [UILabel new];
        _categoryLbl.textColor = kHexColor(0x101010);
        _categoryLbl.text = @"分类";
        _categoryLbl.font = kSysFont(14);
        [self addSubview:_categoryLbl];
    }
    return _categoryLbl;
}

- (UILabel *)showImgLbl
{
    if (!_showImgLbl) {
        _showImgLbl = [UILabel new];
        _showImgLbl.textColor = kHexColor(0x101010);
        _showImgLbl.text = @"封面图";
        _showImgLbl.font = kSysFont(14);
        [self addSubview:_showImgLbl];
    }
    return _showImgLbl;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.textColor = kHexColor(0x101010);
        _titleLbl.text = @"标题";
        _titleLbl.font = kSysFont(14);
        [self addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UILabel *)phoneLbl
{
    if (!_phoneLbl) {
        _phoneLbl = [UILabel new];
        _phoneLbl.textColor = kHexColor(0x101010);
        _phoneLbl.text = @"电话/微信";
        _phoneLbl.font = kSysFont(14);
        [self addSubview:_phoneLbl];
    }
    return _phoneLbl;
}

- (UILabel *)addressLbl
{
    if (!_addressLbl) {
        _addressLbl = [UILabel new];
        _addressLbl.textColor = kHexColor(0x101010);
        _addressLbl.text = @"联系地址";
        _addressLbl.font = kSysFont(14);
        [self addSubview:_addressLbl];
    }
    return _addressLbl;
}

- (UILabel *)detailLbl
{
    if (!_detailLbl) {
        _detailLbl = [UILabel new];
        _detailLbl.textColor = kHexColor(0x101010);
        _detailLbl.text = @"详情";
        _detailLbl.font = kSysFont(14);
        [self addSubview:_detailLbl];
    }
    return _detailLbl;
}

- (UIView *)categoryV
{
    if (!_categoryV) {
        _categoryV = [UIView new];
        _categoryV.layer.borderColor = kHexColor(0xB9B9B9).CGColor;
        _categoryV.layer.borderWidth = 1;
        _categoryV.layer.cornerRadius = 3;
        [self addSubview:_categoryV];
    }
    return _categoryV;
}

- (UIImageView *)showImgV
{
    if (!_showImgV) {
        _showImgV = [UIImageView new];
        _showImgV.userInteractionEnabled = YES;
        _showImgV.image = kGetImage(@"select_img_icon");
        [self addSubview:_showImgV];
    }
    return _showImgV;
}

- (SZTextView *)titleTxtV
{
    if (!_titleTxtV) {
        _titleTxtV = [SZTextView new];
        _titleTxtV.layer.borderColor = kHexColor(0xB9B9B9).CGColor;
        _titleTxtV.layer.borderWidth = 1;
        _titleTxtV.layer.cornerRadius = 3;
        _titleTxtV.delegate = self;
        _titleTxtV.font = kSysFont(13);
        _titleTxtV.placeholder = kFormat(@"请输入标题(%zd字以内)", publish_max_title);
        [self addSubview:_titleTxtV];
    }
    return _titleTxtV;
}

- (UITextField *)phoneTxt
{
    if (!_phoneTxt) {
        _phoneTxt = [UITextField new];
        _phoneTxt.placeholder = @"请输入手机号或微信号(20字以内)";
        _phoneTxt.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 10)];
        _phoneTxt.leftViewMode = UITextFieldViewModeAlways;
        _phoneTxt.layer.borderColor = kHexColor(0xB9B9B9).CGColor;
        _phoneTxt.layer.borderWidth = 1;
        _phoneTxt.delegate = self;
        _phoneTxt.font = kSysFont(13);
        _phoneTxt.layer.cornerRadius = 3;
        [self addSubview:_phoneTxt];
    }
    return _phoneTxt;
}

- (SZTextView *)addressTxtV
{
    if (!_addressTxtV) {
        _addressTxtV = [SZTextView new];
        _addressTxtV.layer.borderColor = kHexColor(0xB9B9B9).CGColor;
        _addressTxtV.layer.borderWidth = 1;
        _addressTxtV.layer.cornerRadius = 3;
        _addressTxtV.delegate=self;
        _addressTxtV.font = kSysFont(13);
        
        _addressTxtV.placeholder = kFormat(@"请输入详细地址(%zd字以内)", publish_max_num_address);
        [self addSubview:_addressTxtV];
    }
    return _addressTxtV;
}

- (UIButton *)selectCategoryBtn
{
    if (!_selectCategoryBtn) {
        _selectCategoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectCategoryBtn setTitle:@"请选择类别" forState:UIControlStateNormal];
        [_selectCategoryBtn setTitleColor:kHexColor(0x101010) forState:UIControlStateNormal];
        _selectCategoryBtn.titleLabel.font = kSysFont(14);
        _selectCategoryBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.categoryV addSubview:_selectCategoryBtn];
    }
    return _selectCategoryBtn;
}

- (UIImageView *)downArrowImgV
{
    if (!_downArrowImgV) {
        _downArrowImgV = [[UIImageView alloc] init];
        _downArrowImgV.image = kGetImage(@"project_down_icon");
        [self.categoryV addSubview:_downArrowImgV];
    }
    return _downArrowImgV;
}


@end
