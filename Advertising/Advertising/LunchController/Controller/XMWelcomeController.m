//
//  XMWelcomeController.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/20.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMWelcomeController.h"
#import "XMWelcomeView.h"
#import "QKAlertView.h"
#import "XMLoginController.h"
#import "XMBaseTabBarController.h"

@interface XMWelcomeController ()<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *guidScrollV;

@property(nonatomic, strong)NSArray *icons;

@end

@implementation XMWelcomeController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        
        self.guidScrollV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.icons = @[@"guide_one", @"guide_two", @"guide_three", @"guide_four"];
    [self createView];
    self.view.backgroundColor = UIColor.whiteColor;
}


- (void)createView
{
    [self.guidScrollV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.safeEqualToTop(self.view);
        make.top.bottom.equalTo(self.view);
//        make.bottom.safeEqualToBottom(self.view);
        make.left.right.equalTo(self.view);
    }];
    
    [self.guidScrollV setContentSize:CGSizeMake(kScreenWidth * _icons.count, kScreenHeight)];
    [self.view addSubview:self.guidScrollV];
    for (int i = 0; i < _icons.count; i++) {

        XMWelcomeView *_welcomeV = [[XMWelcomeView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, kScreenHeight)];
        _welcomeV.baseImgV.image = kGetImage(_icons[i]);
        _welcomeV.enterBtn.hidden = i!=3?YES:NO;
        // 按钮事件
        @weakify(self)
        [[_welcomeV.enterBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            // 进入主页后保存当前版本号
            if (kLoginManager.login) {
                kWindow.rootViewController = [XMBaseTabBarController new];
            }else{
                [self.navigationController pushViewController:[XMLoginController new] animated:YES];
            }
        }];
        [self.guidScrollV addSubview:_welcomeV];
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIScrollView *)guidScrollV
{
    if (!_guidScrollV) {
        _guidScrollV = [[UIScrollView alloc] init];
        _guidScrollV.bounces = NO;
        _guidScrollV.delegate = self;
        _guidScrollV.pagingEnabled = YES;
        _guidScrollV.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_guidScrollV];
    }
    return _guidScrollV;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}



@end
