//
//  XMSuccessController.m
//  Advertising
//
//  Created by dingqiankun on 2020/1/4.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import "XMSuccessController.h"
#import "XMSuccessView.h"
#import "XMMyAdvertController.h"
#import "XMLanlordRecordController.h"
#import "XMBoothRecordController.h"
#import "XMBusinessController.h"

@interface XMSuccessController ()

@property(nonatomic, strong)XMSuccessView *successV;

@end

@implementation XMSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

// 初始化
- (void)setup
{
    self.navigationController.navigationBar.backgroundColor = UIColor.whiteColor;
    self.navigationController.navigationBar.tintColor = UIColor.whiteColor;
    self.view.backgroundColor = UIColor.whiteColor;
//    UIView *customV = [UIView new];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customV];
    [self.successV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.safeEqualToTop(self.view);
        make.bottom.safeEqualToBottom(self.view);
        make.left.right.equalTo(self.view);
    }];
    
    switch (self.type) {
        case XMSuccessTypePayLanlord:
        case XMSuccessTypePayBooth:
        case XMSuccessTypePayAgent:
            self.successV.tipsLbl.text = @"支付成功";
            break;
        case XMSuccessTypePublish:
            self.successV.tipsLbl.text = @"编辑成功，去发布~";
            break;
            case XMSuccessTypeRent:
            self.successV.tipsLbl.text = @"您成功发布了一条求租信息！";
            break;
        default:
            break;
    }
    
    
    @weakify(self)
    [[self.successV.goBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        switch (self.type) {
            case XMSuccessTypePayLanlord:
            {
                XMLanlordRecordController *landlordRecordVC = [XMLanlordRecordController new];
                [self.navigationController pushViewController:landlordRecordVC animated:YES];
            }
                break;
            case XMSuccessTypePayBooth:
            {
                XMBoothRecordController *bootVC = [XMBoothRecordController new];
                [self.navigationController pushViewController:bootVC animated:YES];
            }
                break;
            case XMSuccessTypePayAgent:
                [self.navigationController popViewControllerAnimated:YES];
                break;
            case XMSuccessTypePublish:
            {
                XMMyAdvertController *advertVC = [XMMyAdvertController new];
                [self.navigationController pushViewController:advertVC animated:YES];
            }
                break;
            case XMSuccessTypeRent:
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:kRentNotiFication_PaySuccessRefresh object:nil userInfo:nil];
                for (XMBaseController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:XMBusinessController.class]) {
                        [self.navigationController popToViewController:controller animated:YES];
                    }
                }
            }
                break;
                
            default:
                break;
        }
        
    }];
}


- (XMSuccessView *)successV
{
    if (!_successV) {
        _successV = [[XMSuccessView alloc] init];
        [self.view addSubview:_successV];
    }
    return _successV;
}


@end
