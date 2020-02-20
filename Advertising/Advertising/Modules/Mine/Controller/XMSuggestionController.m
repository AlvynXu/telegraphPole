//
//  XMSuggestionController.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/2.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMSuggestionController.h"
#import "XMSuggestRequest.h"

@interface XMSuggestionController ()<UITextViewDelegate>

@property(nonatomic, strong)UITextView *textV;   // 文本

@property(nonatomic, strong)UIButton *submitBtn;  //提交

@property(nonatomic, strong)XMSuggestRequest *suggestRequest;

@property(nonatomic, copy)NSString *placehold_suggest;

@end

@implementation XMSuggestionController

NSInteger BOOKMARK_WORD_LIMIT = 200;
NSInteger MIN_WORD_LIMIT = 10;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    self.navigationController.navigationBar.tintColor = UIColor.whiteColor;
     self.navigationController.navigationBar.backgroundColor = UIColor.whiteColor;

}

- (void)loadData
{
    self.submitBtn.enabled = NO;
    [self.view showLoading];
    @weakify(self)
    [self.suggestRequest startWithCompletion:^(__kindof XMSuggestRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        [self.view hideLoading];
         self.submitBtn.enabled = YES;
        if (request.businessSuccess) {
            [self.navigationController popViewControllerAnimated:YES];
            [XMHUD showText:@"提交成功"];
        }else{
            [XMHUD showText:request.businessMessage];
        }
        
    }];
}

// 初始化
- (void)setup
{
    self.navigationItem.title = @"意见反馈";
    self.placehold_suggest = kFormat(@"填写您对%@的意见或建议...(10~200字)", kApp_Name);
    [self.textV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.safeEqualToTop(self.view).offset(30);
        make.left.equalTo(@15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(@200);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.textV.mas_right);
        make.height.equalTo(@44);
        make.width.equalTo(@110);
        make.top.equalTo(self.textV.mas_bottom).offset(15);
    }];
    
    
    //提交意见
    @weakify(self)
    [[self.submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if ([self.textV.text isEmpty] || self.textV.text.length<MIN_WORD_LIMIT) {
            [XMHUD showText:@"请输入10~200位之间的内容"];
        }else{
            self.suggestRequest.content = self.textV.text;
            [self loadData];
        }
    }];
    
    if (self.textV.text.length < 1) {
        self.textV.text = self.placehold_suggest;
        self.textV.textColor=[UIColor grayColor];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textV endEditing:YES];
}


#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:self.placehold_suggest]) {
        textView.text = @"";
        textView.textColor=[UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length < 1) {
        textView.text = self.placehold_suggest;
        textView.textColor = [UIColor grayColor];
    }
}


- (void)textViewDidChange:(UITextView *)textView
{
    //该判断用于联想输入
    if (textView.text.length > BOOKMARK_WORD_LIMIT)
    {
        textView.text = [textView.text substringToIndex: BOOKMARK_WORD_LIMIT];
        [XMHUD showText:@"最多200个字哦"];
    }
}





- (UITextView *)textV
{
    if (!_textV) {
        _textV = [[UITextView alloc] init];
        _textV.font = kSysFont(15);
        _textV.delegate = self;
        [self.view addSubview:_textV];
    }
    return _textV;
}

- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"提交反馈" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.backgroundColor = kHexColor(0x8BC34A);
        _submitBtn.layer.cornerRadius = 22;
        _submitBtn.titleLabel.font = kSysFont(16);
        [self.view addSubview:_submitBtn];
    }
    return _submitBtn;
}

- (XMSuggestRequest *)suggestRequest
{
    if (!_suggestRequest) {
        _suggestRequest = [XMSuggestRequest request];
    }
    return _suggestRequest;
}

@end
