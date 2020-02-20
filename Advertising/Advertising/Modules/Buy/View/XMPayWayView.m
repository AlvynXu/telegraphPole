//
//  XMPayWayView.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/27.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMPayWayView.h"
#import "XMPayItem.h"
#import "XMGetUserInfo.h"
#import "XMBuyStateRequest.h"

@interface XMPayWayView()

@property(nonatomic, strong)UIView *blackBaseV;

@property(nonatomic, strong)UIImageView *framePayV;

@property(nonatomic, strong)UILabel *titleLbl;   // 标题 显示地主或展位

@property(nonatomic, strong)XMPayItem *balancePay;

@property(nonatomic, strong)XMPayItem *wechatPay;

@property(nonatomic, strong)XMPayItem *aLiPay;

@property(nonatomic, strong)UIImageView *readedImgV;

@property(nonatomic, strong)UIButton *readBtn;

@property(nonatomic, strong)UIButton *sureBtn;

@property(nonatomic, strong)UIButton *closeBtn;

@property(nonatomic, strong)UIButton *selectBtn;

@property(nonatomic, assign)NSInteger selectTag;

@property(nonatomic, strong)XMGetUserInfoRequest *userInfoRequest;  // 获取用户余额

@property(nonatomic, strong)XMBuyStateRequest *buyInfoRequest;  // 购买信息

@end

@implementation XMPayWayView

CGFloat framePayHeight = 330;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self selectWay];
    }
    return self;
}

- (void)selectWay
{
    @weakify(self)

    [[self.balancePay.selectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self)
        [self clickEventIndex:1 andButton:x];
    }];
    
    [[self.wechatPay.selectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self)
        [self clickEventIndex:2 andButton:x];
    }];
    
    [[self.aLiPay.selectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self)
        [self clickEventIndex:3 andButton:x];
    }];
    
    // 确定按钮
    [[self.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self)
        [self.selectBlockSub sendNext:@(self.selectTag)];
        [self hinde];
    }];
}

- (void)clickEventIndex:(NSInteger)tag andButton:(UIButton *)btn
{
    if (self.selectBtn != btn) {
        [self.selectBtn setSelected:NO];
    }
    [btn setSelected:YES];
    self.selectBtn = btn;
    self.selectTag = tag;
    if (tag == 1 || tag == 3) {
        [XMHUD showText:@"暂不支持该支付方式"];
    }
}

// 初始化
- (void)setup
{
    [self.blackBaseV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.framePayV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(framePayHeight));
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(framePayHeight);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.blackBaseV);
        make.bottom.equalTo(self.framePayV.mas_top);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.framePayV.mas_centerX);
        make.height.equalTo(@16);
        make.width.equalTo(@100);
        make.top.equalTo(@20);
    }];
    
    [self.fullNameAddressLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(self.framePayV.mas_right).offset(-15);
        make.top.equalTo(self.titleLbl.mas_bottom).offset(25);
        make.height.equalTo(@15);
    }];
    
    [self.buyAddressLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.fullNameAddressLbl);
        make.top.equalTo(self.fullNameAddressLbl.mas_bottom).offset(8.5);
        make.height.equalTo(@19);
    }];
    
    [self.numLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.framePayV.mas_centerX);
        make.height.equalTo(@18);
        make.width.equalTo(@(kScreenWidth - 30));
        make.top.equalTo(self.buyAddressLbl.mas_bottom).offset(16);
    }];
    
    UIImageView *lineV = [[UIImageView alloc] init];
    lineV.image = kGetImage(@"border_line");
    [self.framePayV addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.balancePay);
        make.height.equalTo(@1);
        make.top.equalTo(self.numLbl.mas_bottom).offset(30);
    }];
    
    [self.balancePay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@24.5);
        make.right.equalTo(self.framePayV.mas_right).offset(-24.5);
//        make.height.equalTo(@45);
        make.height.equalTo(@0);
        make.top.equalTo(self.numLbl.mas_bottom).offset(36);
    }];
    
    UIImageView *lineV1 = [[UIImageView alloc] init];
    lineV1.image = kGetImage(@"border_line");
    lineV1.hidden = YES;
    [self.framePayV addSubview:lineV1];
    [lineV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.balancePay);
        make.height.equalTo(@1);
        make.top.equalTo(self.balancePay.mas_bottom);
    }];
    
    [self.wechatPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.balancePay);
        make.height.equalTo(@45);
        make.top.equalTo(lineV1.mas_bottom);
    }];
    
    UIImageView *lineV2 = [[UIImageView alloc] init];
    lineV2.image = kGetImage(@"border_line");
    [self.framePayV addSubview:lineV2];
    [lineV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.wechatPay);
        make.height.equalTo(@1);
        make.top.equalTo(self.wechatPay.mas_bottom);
    }];
    
    [self.aLiPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.balancePay);
        make.top.equalTo(lineV2.mas_bottom);
    }];
    
    UIImageView *lineV3 = [[UIImageView alloc] init];
    lineV3.hidden = YES;
    lineV3.image = kGetImage(@"border_line");
    [self.framePayV addSubview:lineV3];
    [lineV3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.wechatPay);
        make.height.equalTo(@1);
        make.top.equalTo(self.aLiPay.mas_bottom);
    }];
    
    [self.readedImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineV3.mas_left);
        make.width.equalTo(@14);
        make.height.equalTo(@14);
        make.top.equalTo(lineV3.mas_bottom).offset(11.5);
    }];
    
    [self.readBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.readedImgV.mas_right).offset(9);
        make.width.equalTo(@200);
        make.height.equalTo(@18);
        make.centerY.equalTo(self.readedImgV.mas_centerY);
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@49);
        make.width.equalTo(@180);
        make.bottom.equalTo(self.framePayV.mas_bottom).offset(-18);
    }];
    
    // 抢地主
    @weakify(self)
    [[self.closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self hinde];
    }];
}

- (void)show
{
    [self getUserBlance]; // 获取用户余额
    [self getOrderInfo];
    if (!self.superview) {
        [kWindow addSubview:self];
    }
    self.blackBaseV.hidden = NO;
    [self.framePayV.superview layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self.framePayV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom);
        }];
        [self.framePayV.superview layoutIfNeeded];//强制绘制
    }];
}

- (void)hinde
{
    [self.framePayV.superview layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self.framePayV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(framePayHeight);
        }];
        [self.framePayV.superview layoutIfNeeded];//强制绘制
    } completion:^(BOOL finished) {
        self.blackBaseV.hidden = YES;
        if (self.superview) {
            [self removeFromSuperview];
        }
    }];
}

// 获取订单信息
- (void)getOrderInfo
{
    if (_payType == PayTypeAgent) {
        self.titleLbl.text = @"您正在购买会员";
        
        self.buyAddressLbl.text = kFormat(@"%@会员", kApp_Name);
        return;
    }
    [self.framePayV showLoading];
    self.titleLbl.text = self.payType == PayTypeLanlord?@"您正在购买地主":@"您正在购买展位";
    self.buyInfoRequest.type = self.payType == PayTypeLanlord?2:1;
    self.buyInfoRequest.Id = self.Id;
    @weakify(self)
    [self.buyInfoRequest startWithCompletion:^(__kindof XMBuyStateRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        [self.framePayV hideLoading];
        if (request.businessSuccess) {
            XMBuyStateModel *stateModel = request.businessModel;
            NSString *fullName;
            if (self.payType == PayTypeLanlord) {
                fullName = kFormat(@"%@ %@ %@", stateModel.province, stateModel.city, stateModel.district);
            }else{
                fullName = kFormat(@"%@ %@ %@ %@", stateModel.province, stateModel.city, stateModel.district, stateModel.street);
            }
            self.fullNameAddressLbl.text = [fullName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            self.buyAddressLbl.text = self.payType == PayTypeLanlord?kFormat(@"%@", stateModel.street):kFormat(@"展位编号：%@", stateModel.code);
        }
    }];
}

// 获取用户余额
- (void)getUserBlance
{
    @weakify(self)
    [self.userInfoRequest startWithCompletion:^(__kindof XMBaseRequest * _Nonnull request, NSError * _Nonnull error) {
        @strongify(self)
        if (request.businessSuccess) {
            XMCurrentUserInfo *info = request.businessModel;  //info
            self.balancePay.titleLbl.text = kFormat(@"余额: ￥%.2lf", info.balance);
        }
    }];
}
- (UIView *)blackBaseV
{
    if (!_blackBaseV) {
        _blackBaseV = [[UIView alloc] init];
        _blackBaseV.hidden = YES;
        _blackBaseV.backgroundColor = kHexColorA(0x000000, 0.87);
        [self addSubview:_blackBaseV];
    }
    return _blackBaseV;
}

- (UIImageView *)framePayV
{
    if (!_framePayV) {
        _framePayV = [[UIImageView alloc] init];
        _framePayV.userInteractionEnabled = YES;
        _framePayV.backgroundColor = UIColor.whiteColor;
        [self.blackBaseV addSubview:_framePayV];
    }
    return _framePayV;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.text = @"您正在购买";
        _titleLbl.textColor = kHexColor(0xFF999999);
        _titleLbl.font = kSysFont(14);
        [self.framePayV addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UILabel *)fullNameAddressLbl
{
    if (!_fullNameAddressLbl) {
        _fullNameAddressLbl = [[UILabel alloc] init];
        _fullNameAddressLbl.textColor = kHexColor(0xFF333333);
        _fullNameAddressLbl.font = kBoldFont(14);
        _fullNameAddressLbl.textAlignment = NSTextAlignmentCenter;
        [self.framePayV addSubview:_fullNameAddressLbl];
    }
    return _fullNameAddressLbl;
}

- (UILabel *)buyAddressLbl
{
    if (!_buyAddressLbl) {
        _buyAddressLbl = [[UILabel alloc] init];
        _buyAddressLbl.textColor = kHexColor(0xFF333333);
        _buyAddressLbl.font = kBoldFont(18);
        _buyAddressLbl.textAlignment = NSTextAlignmentCenter;
        [self.framePayV addSubview:_buyAddressLbl];
    }
    return _buyAddressLbl;
}


- (UILabel *)numLbl
{
    if (!_numLbl) {
        _numLbl = [[UILabel alloc] init];
        _numLbl.text = @"￥10.0";
        _numLbl.textAlignment = NSTextAlignmentCenter;
        _numLbl.textColor = kMainColor;
        _numLbl.font = kBoldFont(24);
        [self.framePayV addSubview:_numLbl];
    }
    return _numLbl;
}

- (XMPayItem *)balancePay
{
    if (!_balancePay) {
        _balancePay = [[XMPayItem alloc] init];
        _balancePay.titleLbl.text = @"余额: ￥0.0";
        _balancePay.iconV.image = kGetImage(@"pay_balance");
        _balancePay.hidden = YES;
        [self.framePayV addSubview:_balancePay];
    }
    return _balancePay;
}

- (XMPayItem *)wechatPay
{
    if (!_wechatPay) {
        _wechatPay = [[XMPayItem alloc] init];
        // 默认微信支付
        [_wechatPay.selectBtn setSelected:YES];
        self.selectBtn = _wechatPay.selectBtn;
        self.selectTag = 2;
        _wechatPay.titleLbl.text = @"微信支付";
        _wechatPay.iconV.image = kGetImage(@"pay_wechat");
        [self.framePayV addSubview:_wechatPay];
    }
    return _wechatPay;
}

- (XMPayItem *)aLiPay
{
    if (!_aLiPay) {
        _aLiPay = [[XMPayItem alloc] init];
        _aLiPay.titleLbl.text = @"支付宝支付";
        _aLiPay.iconV.image = kGetImage(@"pay_ali");
        _aLiPay.hidden = YES;
        [self.framePayV addSubview:_aLiPay];
    }
    return _aLiPay;
}

- (UIImageView *)readedImgV
{
    if (!_readedImgV) {
        _readedImgV = [[UIImageView alloc] init];
        _readedImgV.image = kGetImage(@"readed");
        _readedImgV.hidden = YES;
        [self.framePayV addSubview:_readedImgV];
    }
    return _readedImgV;
}

- (UIButton *)readBtn
{
    if (!_readBtn) {
        _readBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_readBtn setTitle:@"我已阅读并同意《展位购买须知》" forState:UIControlStateNormal];
        _readBtn.titleLabel.font = kSysFont(13);
        _readBtn.hidden = YES;
        [_readBtn setTitleColor:kHexColor(0xFF999999) forState:UIControlStateNormal];
        [self.framePayV addSubview:_readBtn];
    }
    return _readBtn;
}

- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.backgroundColor = kHexColor(0xFF8BC34A);
        _sureBtn.layer.masksToBounds = YES;
        _sureBtn.layer.cornerRadius = 24.5;
        [_sureBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = kSysFont(18);
        [_sureBtn setTitle:@"确认支付" forState:UIControlStateNormal];
        [self.framePayV addSubview:_sureBtn];
    }
    return _sureBtn;
}

- (UIButton *)closeBtn
{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.blackBaseV addSubview:_closeBtn];
    }
    return _closeBtn;
}

- (RACSubject *)selectBlockSub
{
    if (!_selectBlockSub) {
        _selectBlockSub = [RACSubject subject];
    }
    return _selectBlockSub;
}

- (XMGetUserInfoRequest *)userInfoRequest
{
    if (!_userInfoRequest) {
        _userInfoRequest = [XMGetUserInfoRequest request];
    }
    return _userInfoRequest;
}

- (XMBuyStateRequest *)buyInfoRequest
{
    if (!_buyInfoRequest) {
        _buyInfoRequest = [XMBuyStateRequest request];
    }
    return _buyInfoRequest;
}


@end
