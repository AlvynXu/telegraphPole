//
//  XMNLoginView.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/30.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMNLoginView.h"

@interface XMNLoginView()<UITextFieldDelegate>

@property(nonatomic, strong)UIImageView *colorLogoImgV;

//@property(nonatomic, strong)UIImageView *phoneLogoImgV;

@property(nonatomic, strong)UILabel *areaNumLbl;

@property(nonatomic, strong)UIView *seperLineV;

@property(nonatomic, strong)UILabel *readRuleLbl;


@end

@implementation XMNLoginView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
        [self setupFrame];
    }
    return self;
}

// 初始化
- (void)setupFrame
{
    CGFloat left = 40;
    CGFloat top = 90;
    
    [self.colorLogoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@0);
        make.width.equalTo(@133);
        make.height.equalTo(@89);
    }];

    [self.loginIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(left));
        make.width.equalTo(@14);
        make.height.equalTo(@20);
        make.top.equalTo(self.colorLogoImgV.mas_bottom).offset(top);
    }];
    
    [self.areaNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.loginIconBtn);
        make.width.equalTo(@30);
        make.height.equalTo(@16.5);
        make.left.equalTo(self.loginIconBtn.mas_right).offset(15);
    }];
    
    [self.seperLineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.areaNumLbl.mas_right).offset(13);
        make.centerY.equalTo(self.areaNumLbl);
        make.height.equalTo(@33);
        make.width.equalTo(@0.5);
    }];
    
    [self.phoneTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.seperLineV.mas_right).offset(13);
        make.centerY.equalTo(self.seperLineV);
        make.height.equalTo(self.seperLineV);
        make.right.equalTo(self.mas_right).offset(-left);
    }];
    
    UIView *lineV1 = [UIView new];
    lineV1.backgroundColor = kHexColor(0xFFDFDFDF);
    [self addSubview:lineV1];
    [lineV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loginIconBtn);
        make.right.equalTo(self.phoneTxt.mas_right);
        make.height.equalTo(@0.5);
        make.top.equalTo(self.loginIconBtn.mas_bottom).offset(17);
    }];
    
    [self.senderCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.phoneTxt);
        make.height.equalTo(@20);
        make.top.equalTo(lineV1.mas_bottom).offset(25);
    }];
    
    [self.valieCodeTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.senderCodeBtn);
        make.left.equalTo(self.loginIconBtn);
        make.height.equalTo(@25);
        make.right.equalTo(self.senderCodeBtn.mas_left).offset(-20);
    }];
    
    UIView *lineV2 = [UIView new];
    lineV2.backgroundColor = kHexColor(0xFFDFDFDF);
    [self addSubview:lineV2];
    [lineV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(lineV1);
        make.right.equalTo(self.senderCodeBtn.mas_left).offset(-7);
        make.top.equalTo(self.valieCodeTxt.mas_bottom).offset(10);
    }];
    
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineV2.mas_left).offset(-6.5);
        make.width.equalTo(@25);
        make.height.equalTo(@25);
        make.top.equalTo(lineV2.mas_bottom).offset(10);
    }];
    
    [self.selectBtn setImageEdgeInsets:UIEdgeInsetsMake(6.5, 6.5, 6.5, 6.5)];
    
    [self.readRuleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.selectBtn);
        make.height.equalTo(@16);
        make.width.equalTo(@90);
        make.left.equalTo(self.selectBtn.mas_right).offset(0);
    }];
    
    [self.readRuleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.readRuleLbl.mas_right).offset(0);
        make.width.equalTo(@110);
        make.height.equalTo(@18);
        make.centerY.equalTo(self.readRuleLbl);
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lineV1);
        make.top.equalTo(self.selectBtn.mas_bottom).offset(30);
        make.height.equalTo(@45);
    }];
}


#pragma mark  -------- UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL isAllowEdit = YES;
    if([string length]>range.length&&[textField.text length]+[string length]-range.length>11)
    {
        [textField resignFirstResponder];
        isAllowEdit = NO;
    }
    return isAllowEdit;
}


- (void)initView
{
    self.colorLogoImgV = [UIImageView new];
    [self addSubview:self.colorLogoImgV];
    self.colorLogoImgV.image=kGetImage(@"login_title_icon");
    
    // 登录icon
    self.loginIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.loginIconBtn];
    [self.loginIconBtn setImage:kGetImage(@"login_phone_normal") forState:UIControlStateNormal];
    [self.loginIconBtn setImage:kGetImage(@"login_phone_icon") forState:UIControlStateSelected];
//    self.phoneLogoImgV = [UIImageView new];
//    [self addSubview:self.phoneLogoImgV];
//    self.phoneLogoImgV.image=kGetImage(@"login_phone_icon");
    
    
    self.areaNumLbl = [UILabel new];
    self.areaNumLbl.text = @"+86";
    self.areaNumLbl.textColor = kHexColor(0xFF333333);
    self.areaNumLbl.font = kSysFont(14);
    [self addSubview:self.areaNumLbl];
    
    self.seperLineV = [UIView new];
    [self addSubview:self.seperLineV];
    self.seperLineV.backgroundColor = kHexColor(0xFFE3E3E3);
    
    self.phoneTxt = [UITextField new];
    self.phoneTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:self.phoneTxt];
    self.phoneTxt.keyboardType = UIKeyboardTypePhonePad;
    self.phoneTxt.textColor = kHexColor(0xFF333333);
    self.phoneTxt.font = kSysFont(14);
    self.phoneTxt.placeholder = @"请输入手机号码";
    self.phoneTxt.delegate = self;
    
    self.valieCodeTxt = [UITextField new];
    self.valieCodeTxt.textColor = kHexColor(0xFF333333);
    self.valieCodeTxt.placeholder = @"验证码";
    self.valieCodeTxt.font = kSysFont(14);
    self.valieCodeTxt.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:self.valieCodeTxt];
    
    self.senderCodeBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.senderCodeBtn setTitleColor:kHexColor(0xFF999999) forState:UIControlStateDisabled];
    [self.senderCodeBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    self.senderCodeBtn.titleLabel.font = kSysFont(14);
    [self.senderCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.senderCodeBtn setEnabled:YES];
    self.senderCodeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self addSubview:self.senderCodeBtn];
    
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectBtn setImage:kGetImage(@"rule_select") forState:UIControlStateSelected];
    [self.selectBtn setImage:kGetImage(@"rule_normal") forState:UIControlStateNormal];
    [self.selectBtn setSelected:YES];
    [self addSubview:self.selectBtn];
    
    self.readRuleLbl = [UILabel new];
    [self addSubview:self.readRuleLbl];
    self.readRuleLbl.textColor = kHexColor(0xFF363636);
    self.readRuleLbl.font = kSysFont(12);
    self.readRuleLbl.text = @"我已阅读并同意";
    
    self.readRuleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.readRuleBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    [self.readRuleBtn setTitle:@"《Pole用户协议》" forState:UIControlStateNormal];
    self.readRuleBtn.titleLabel.font = kSysFont(12);
    [self addSubview:self.readRuleBtn];
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.sureBtn];
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.sureBtn.titleLabel.font = kBoldFont(15);
    [self.sureBtn setTitleColor:kHexColor(0xffffff) forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 8;
    self.sureBtn.backgroundColor = kHexColor(0xFFDBDBDB);
    self.sureBtn.layer.masksToBounds = YES;

}





@end
