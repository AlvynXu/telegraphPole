//
//  XMPersonController.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/25.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMPersonController.h"
#import "XMMineCell.h"
#import "XMMineHeadView.h"
#import "QKAlertView.h"
#import "XMSuggestionController.h"
#import "XMGetUserInfo.h"
#import "XMShareController.h"
#import "XMVersionUpdateUtil.h"
#import "XMCustomerController.h"
#import "XMMyAdvertController.h"
#import "XMLanlordRecordController.h"
#import "XMBoothRecordController.h"
#import "XMMyCollectController.h"
#import "XMAgentController.h"


@interface XMPersonController ()

@property(nonatomic, strong)XMMineHeadView *headV;

@property(nonatomic, strong)NSArray *data;

@property(nonatomic, copy)NSString *regCode;

@property(nonatomic, strong)XMGetUserInfoRequest *userInfoRequest;

@property(nonatomic, strong)XMGetUserBaseNumRequest *numRequest;


@end

@implementation XMPersonController

static NSString * const mineCell_id = @"mineCell_id";


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getUserInfo];
    [self getBoothLanlordNum];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}


- (void)getUserInfo
{
    @weakify(self)
    [self.userInfoRequest startWithCompletion:^(__kindof XMGetUserInfoRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            XMCurrentUserInfo *userInfo = request.businessModel;
            self.regCode = userInfo.regCode;
            self.headV.userInfo = self.userInfoRequest.businessModel;
        }
    }];
}

// 获取展位地主数量
- (void)getBoothLanlordNum
{
    @weakify(self)
    [self.numRequest startWithCompletion:^(__kindof XMGetUserBaseNumRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            XMUserBaseNumInfo *numInfo = request.businessModel;
            self.headV.baseNumInfo = numInfo;
        }
    }];
}

// 初始化
- (void)setup
{
    self.navigationItem.title = @"我的";
    
    XMMineHeadView *headV = [[XMMineHeadView alloc] init];
    self.headV = headV;
    [self.view addSubview:headV];
    [self.headV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.safeEqualToTop(self.view);
        make.bottom.safeEqualToBottom(self.view);
    }];
    @weakify(self)
    // 复制
    [[headV.scopyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self copyInvitation];
    }];
    // 邀请好友
    [[headV.invitationBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        XMShareController *shareVC = [XMShareController new];
        [self.navigationController pushViewController:shareVC animated:YES];
    }];
    
    [headV.subject subscribeNext:^(id  _Nullable x) {
        NSNumber *xNum = x;
        switch (xNum.integerValue) {
            case 0:  // 我的客服
            {
                XMCustomerController *cusTomerVC = [XMCustomerController new];
                [self.navigationController pushViewController:cusTomerVC animated:YES];
            }
                break;
            case 1:  // 我的收藏
            {
                XMMyCollectController *collectVC = [XMMyCollectController new];
                [self.navigationController pushViewController:collectVC animated:YES];
            }
                break;
            case 2:  // 意见反馈
            {
                XMSuggestionController *suggestionVC = [XMSuggestionController new];
                [self.navigationController pushViewController:suggestionVC animated:YES];
            }
                break;
            case 3:  // 版本更新
            {
                [XMVersionUpdateUtil checkUpdate:self.view];
            }
                break;
            case 4:  // 我的展位
            {
                XMBoothRecordController *bootVC = [XMBoothRecordController new];
                bootVC.isPush = YES;
                [self.navigationController pushViewController:bootVC animated:YES];
            }
                break;
            case 5:  // 我的地主
            {
                XMLanlordRecordController *lanlordRecordControler = [XMLanlordRecordController new];
                lanlordRecordControler.isPush = YES;
                [self.navigationController pushViewController:lanlordRecordControler animated:YES];
            }
                break;
            case 6:  // 我的广告
            {
                XMMyAdvertController *advertVC = [XMMyAdvertController new];
                [self.navigationController pushViewController:advertVC animated:YES];
            }
                break;
            case 7:   // 升级会员
            {
                XMAgentController *agentVC = [XMAgentController new];
                [self.navigationController pushViewController:agentVC animated:YES];
            }
                break;
                
            default:
                break;
        }
    }];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[kGetImage(@"mine_loginout") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(handLoginOut)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    self.view.backgroundColor = kMainBackGroundColor;
}


// 复制邀请码
- (void)copyInvitation
{
    if ([self.regCode isEmpty]) {
        return;
    }
    //系统级别
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.regCode;
    [XMHUD showText:@"邀请码已复制"];
}

// 退出登录
- (void)handLoginOut
{
    QKAlertView *alertV =[[QKAlertView alloc] initWithTitle:@"提示" message:@"确定退出当前用户" buttonTitles:@"取消",@"确定", nil];
    [alertV showWithCompletion:^(NSInteger index, NSString *msg) {
        if (index == 1) {
            // 退出登录
            [kLoginManager loginOut];
            [kLoginManager goLoginComplete:^{
            } animation:YES];
        }
    }];
}


- (XMGetUserInfoRequest *)userInfoRequest
{
    if (!_userInfoRequest) {
        _userInfoRequest = [XMGetUserInfoRequest request];
    }
    return _userInfoRequest;
}

- (XMGetUserBaseNumRequest *)numRequest
{
    if (!_numRequest) {
        _numRequest = [XMGetUserBaseNumRequest request];
    }
    return _numRequest;
}




@end
