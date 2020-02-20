//
//  XMComWebController.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/24.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMComWebController.h"
#import <WebKit/WebKit.h>

@interface XMComWebController ()<WKUIDelegate,WKNavigationDelegate>

@property(nonatomic, strong)WKWebView *webView;
@property (nonatomic,strong) UIProgressView *progress;

@end

@implementation XMComWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self loadUrl];
    
}

- (void)loadUrl
{
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:req];
    //TODO:kvo监听，获得页面title和加载进度值
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
}

// 初始化
- (void)setup
{
    // 初始化
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.safeEqualToTop(self.view);
        make.bottom.safeEqualToBottom(self.view);
        make.left.right.equalTo(self.view);
    }];
}

#pragma mark 加载进度条
- (UIProgressView *)progress
{
    if (_progress == nil)
    {
        _progress = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 2)];
        _progress.tintColor = [UIColor blueColor];
        _progress.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:_progress];
    }
    return _progress;
}



#pragma mark KVO的监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    //加载进度值
    if ([keyPath isEqualToString:@"estimatedProgress"])
    {
        if (object == self.webView)
        {
            [self.progress setAlpha:1.0f];
            [self.progress setProgress:self.webView.estimatedProgress animated:YES];
            if(self.webView.estimatedProgress >= 1.0f)
            {
                [UIView animateWithDuration:0.5f
                                      delay:0.3f
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     [self.progress setAlpha:0.0f];
                                 }
                                 completion:^(BOOL finished) {
                                     [self.progress setProgress:0.0f animated:NO];
                                 }];
            }
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    //网页title
    else if ([keyPath isEqualToString:@"title"])
    {
        if (object == self.webView)
        {
            self.navigationItem.title = self.webView.title;
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark 移除观察者
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}




- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.allowsBackForwardNavigationGestures = YES;
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}




@end
