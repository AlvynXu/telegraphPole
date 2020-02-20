//
//  XMMineHeadView.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/2.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMMineHeadView.h"
#import "UIButton+ImageTitleSpacing.h"
#import "XMMineCardClickView.h"
#import "XMMineProjectItemView.h"
#import "XMCustomBtn.h"
#import "XMGetUserInfo.h"

@interface XMMineHeadView ()

@property(nonatomic, strong)UIImageView *headImgV;

@property(nonatomic, strong)UILabel *nameLbl;

@property(nonatomic, strong)UILabel *invitationLbl;

@property(nonatomic, strong)UILabel *vipLbl;

@property(nonatomic, strong)UIImageView *baseImgV;  // 展位 地主 项目

@property(nonatomic, strong)XMMineCardClickView *cardBoothView; // 我的展位

@property(nonatomic, strong)XMMineCardClickView *cardLanlordView;  //我的地主

@property(nonatomic, strong)XMMineProjectItemView *projectV;//我的广告

@property(nonatomic, strong)XMMineProjectItemView *agentV;//我的代理

//@property(nonatomic, strong)XMMineCardClickView 

@property(nonatomic, strong)UIImageView *gridImgV;  // 网格




@end

@implementation XMMineHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self createGridView];
    }
    return self;
}

- (void)setUserInfo:(XMCurrentUserInfo *)userInfo
{
    _userInfo = userInfo;
    self.nameLbl.text = kFormat(@"用户名：%@", userInfo.phone);
    self.invitationLbl.text = kFormat(@"邀请码：%@", userInfo.regCode);
    self.vipLbl.text = kFormat(@"用户等级：%@", userInfo.levelName);
    self.headImgV.image = kGetImage(userInfo.levelImgName);
}

- (void)createGridView
{
    NSArray *data = @[@{@"title":@"我的客服", @"image":@"mine_customer"}, @{@"title":@"我的收藏", @"image":@"mine_collect_icon"}, @{@"title":@"意见反馈", @"image":@"mine_suggestion"}, @{@"title":@"版本更新", @"image":@"mine_version"}];
    CGFloat left = 15;
    CGFloat width = (kScreenWidth - 14 - left * 2)/4;
    CGFloat height = 60;
    for (int i = 0; i<data.count; i++) {
        XMCustomBtn *btn = [XMCustomBtn new];
        btn.tag = 100 + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        @weakify(self)
        [tap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            @strongify(self)
            NSInteger index = btn.tag - 100;
            [self.subject sendNext:@(index)];
        }];
        [btn addGestureRecognizer:tap];
        NSDictionary *dict =  data[i];
        btn.titleLbl.text = dict[@"title"];
        btn.imgV.image = kGetImage(dict[@"image"]);
        [self.gridImgV addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(left+i*width));
            make.width.equalTo(@(width));
            make.height.equalTo(@(height));
            make.centerY.equalTo(self.gridImgV);
        }];
    }
}

- (void)setBaseNumInfo:(XMUserBaseNumInfo *)baseNumInfo
{
    _baseNumInfo = baseNumInfo;
    self.cardBoothView.numLbl.text = kFormat(@"%zd", baseNumInfo.boothCount);
    self.cardLanlordView.numLbl.text = kFormat(@"%zd", baseNumInfo.streetCount);
}


// 初始化
- (void)setup
{
    CGFloat left = 15;
    
    [self.headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(left));
        make.width.equalTo(@70);
        make.height.equalTo(@70);
        make.top.equalTo(self.mas_top).offset(30);
    }];
    
    [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImgV.mas_right).offset(10);
        make.width.equalTo(@150);
        make.height.equalTo(@20);
        make.top.equalTo(self.headImgV.mas_top).offset(0);
    }];
    
    [self.invitationLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headImgV);
        make.left.width.height.equalTo(self.nameLbl);
    }];
    
    [self.vipLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.nameLbl);
        make.bottom.equalTo(self.headImgV);
    }];
    
    [self.scopyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.invitationLbl.mas_right).offset(10);
        make.centerY.equalTo(self.invitationLbl.mas_centerY);
        make.width.equalTo(@60);
        make.height.equalTo(@30);
    }];
    
    [self.baseImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImgV.mas_bottom).offset(15);
        make.left.equalTo(@7);
        make.right.equalTo(self.mas_right).offset(-7);
        make.height.equalTo(@250);
    }];
    
    UITapGestureRecognizer *cardBoothTap = [[UITapGestureRecognizer alloc] init];
    @weakify(self)
    [cardBoothTap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self)
        [self.subject sendNext:@(4)];
    }];
    [self.cardBoothView addGestureRecognizer:cardBoothTap];
    [self.cardBoothView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@25);
        make.height.equalTo(@60);
        make.right.equalTo(self.baseImgV.mas_centerX).offset(-10);
        make.top.equalTo(@20);
    }];
    
    UIView *lineV = [UIView new];
    lineV.backgroundColor = kHexColor(0xE6E6E6);
    [self.baseImgV addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.baseImgV.mas_left).offset(20);
        make.right.equalTo(self.baseImgV.mas_right).offset(-10);
        make.height.equalTo(@1);
        make.top.equalTo(self.cardBoothView.mas_bottom).offset(20);
    }];
    
    UITapGestureRecognizer *lanlordTap = [[UITapGestureRecognizer alloc] init];
    [lanlordTap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self)
        [self.subject sendNext:@(5)];
    }];
    [self.cardLanlordView addGestureRecognizer:lanlordTap];

    [self.cardLanlordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.baseImgV.mas_right).offset(-15);
        make.height.top.equalTo(self.cardBoothView);
        make.left.equalTo(self.baseImgV.mas_centerX).offset(10);
    }];
    
    UITapGestureRecognizer *projectVTap = [[UITapGestureRecognizer alloc] init];
    [projectVTap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self)
        [self.subject sendNext:@(6)];
    }];
    [self.projectV addGestureRecognizer:projectVTap];
    
    [self.projectV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.baseImgV);
        make.height.equalTo(@44);
        make.top.equalTo(lineV.mas_bottom).offset(10);
    }];
    
    UIView *lineV1 = [UIView new];
    lineV1.backgroundColor = kHexColor(0xE6E6E6);
    [self.baseImgV addSubview:lineV1];
    [lineV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.baseImgV.mas_left).offset(20);
        make.right.equalTo(self.baseImgV.mas_right).offset(-10);
        make.height.equalTo(@1);
        make.top.equalTo(self.projectV.mas_bottom).offset(10);
    }];
    
    UITapGestureRecognizer *agentTap = [[UITapGestureRecognizer alloc] init];
    [agentTap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self)
        [self.subject sendNext:@(7)];
    }];
    [self.agentV addGestureRecognizer:agentTap];
    
    [self.agentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.baseImgV);
        make.height.equalTo(@44);
        make.top.equalTo(lineV1.mas_bottom).offset(10);
    }];
    
    
    [self.gridImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@7);
        make.right.equalTo(self.mas_right).offset(-7);
        make.height.equalTo(@138);
        make.top.equalTo(self.baseImgV.mas_bottom).offset(0);
    }];
    
    [self.invitationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self.headImgV);
        make.width.equalTo(@70);
        make.height.equalTo(@60);
    }];
    [self.invitationBtn setImage:kGetImage(@"mine_invitation") forState:UIControlStateNormal];
    [self.invitationBtn setTitle:@"邀请好友" forState:UIControlStateNormal];
    self.invitationBtn.titleLabel.font = kSysFont(13);
    [self.invitationBtn setTitleColor:kHexColor(0x333333) forState:UIControlStateNormal];
    [self.invitationBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
}


- (UIImageView *)headImgV
{
    if (!_headImgV) {
        _headImgV = [[UIImageView alloc] init];
        [self addSubview:_headImgV];
    }
    return _headImgV;
}

- (UILabel *)nameLbl
{
    if (!_nameLbl) {
        _nameLbl = [[UILabel alloc] init];
        _nameLbl.text = kFormat(@"用户名：%@", kLoginManager.phone);
        _nameLbl.textColor = kHexColor(0x333333);
        _nameLbl.font = kSysFont(14);
        [self addSubview:_nameLbl];
    }
    return _nameLbl;
}

- (UILabel *)invitationLbl
{
    if (!_invitationLbl) {
        _invitationLbl = [[UILabel alloc] init];
        _invitationLbl.text = kFormat(@"邀请码：%@", kLoginManager.invitation);
        _invitationLbl.textColor = kHexColor(0x999999);
        _invitationLbl.font = kSysFont(14);
        [self addSubview:_invitationLbl];
    }
    return _invitationLbl;
}

- (UIButton *)scopyBtn
{
    if (!_scopyBtn) {
        _scopyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_scopyBtn setTitle:@"复制" forState:UIControlStateNormal];
        _scopyBtn.layer.cornerRadius = 15;
        _scopyBtn.hidden = YES;
        [_scopyBtn setTitleColor:kHexColor(0x999999) forState:UIControlStateNormal];
        _scopyBtn.layer.borderColor = kHexColor(0x999999).CGColor;
        _scopyBtn.titleLabel.font = kSysFont(14);
        _scopyBtn.layer.borderWidth = 1;
        [self addSubview:_scopyBtn];
    }
    return _scopyBtn;
}

- (UILabel *)vipLbl
{
    if (!_vipLbl) {
        _vipLbl = [UILabel new];
        _vipLbl.textColor = kHexColor(0x999999);
        _vipLbl.font = kSysFont(14);
        _vipLbl.text = @"用户等级：0";
        [self addSubview:_vipLbl];
    }
    return _vipLbl;
}

- (UIButton *)invitationBtn
{
    if (!_invitationBtn) {
        _invitationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_invitationBtn];
    }
    return _invitationBtn;
}

- (UIImageView *)baseImgV
{
    if (!_baseImgV) {
        _baseImgV =[[UIImageView alloc] init];
        _baseImgV.userInteractionEnabled = YES;
        _baseImgV.image = kGetImage(@"team_item");
        [self addSubview:_baseImgV];
    }
    return _baseImgV;
}

- (XMMineCardClickView *)cardBoothView
{
    if (!_cardBoothView) {
        _cardBoothView = [[XMMineCardClickView alloc] init];
        _cardBoothView.descLbl.text = @"我的展位";
        _cardBoothView.numLbl.text = @"0";
        [self.baseImgV addSubview:_cardBoothView];
    }
    return _cardBoothView;
}

- (XMMineCardClickView *)cardLanlordView
{
    if (!_cardLanlordView) {
        _cardLanlordView = [[XMMineCardClickView alloc] init];
        _cardLanlordView.descLbl.text = @"我的地主";
        _cardLanlordView.numLbl.text = @"0";
        [self.baseImgV addSubview:_cardLanlordView];
    }
    return _cardLanlordView;
}

- (XMMineProjectItemView *)projectV
{
    if (!_projectV) {
        _projectV = [[XMMineProjectItemView alloc] init];
        _projectV.titleLbl.text = @"我的推广";
        [self.baseImgV addSubview:_projectV];
    }
    return _projectV;
}

- (XMMineProjectItemView *)agentV
{
    if (!_agentV) {
        _agentV = [[XMMineProjectItemView alloc] init];
        _agentV.titleLbl.text = @"升级会员";
        [self.baseImgV addSubview:_agentV];
    }
    return _agentV;
}

- (UIImageView *)gridImgV
{
    if (!_gridImgV) {
        _gridImgV = [[UIImageView alloc] init];
        _gridImgV.userInteractionEnabled = YES;
        _gridImgV.image = kGetImage(@"team_item");
        [self addSubview:_gridImgV];
    }
    return _gridImgV;
}

- (RACSubject *)subject
{
    if (!_subject) {
        _subject = [RACSubject subject];
    }
    return _subject;
}

@end
