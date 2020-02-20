//
//  XMHomeView.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/26.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMHomeView.h"
#import "UIView+Loading.h"
#import "UIImage+GIF.h"

@interface XMHomeView ()

@property(nonatomic, strong)XMBuyCardView *landlordView;  // 地主

@property(nonatomic, strong)XMBuyCardView *boothView;  //展位

@end

@implementation XMHomeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setNoRead:(int)noRead
{
    _noRead = noRead;
    self.msgLbl.noReadLbl.hidden = !noRead;
}

- (void)setCommonModel:(XMHomeBootModel *)commonModel
{
    _commonModel = commonModel;
    if (_booth) {
        self.boothView.numLbl.text = kFormat(@"%@",commonModel.totalCount);
    }else{
        self.landlordView.numLbl.text = kFormat(@"%@", commonModel.totalCount);
    }
}


// 初始化
- (void)setup
{
    
    CGFloat itemLeft = 13;
    CGFloat itemRight = 13;
    CGFloat lineWidth = 1;
    CGFloat lineHeight = 31.5;
    CGFloat itemWidth = (kScreenWidth - itemLeft - itemRight - lineWidth) / 3;
    CGFloat top = 15;
    CGFloat itemHeigt = 45;
    // 受益
    [self.benefitLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(itemWidth));
        make.left.equalTo(self.mas_left).offset(itemLeft);
        make.top.equalTo(@(top));
        make.height.equalTo(@(kScaleH(itemHeigt)));
    }];
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = kHexColor(0xFFB2B2B2);
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.benefitLbl.mas_right);
        make.width.equalTo(@(lineWidth));
        make.height.equalTo(@(lineHeight));
        make.centerY.equalTo(self.benefitLbl.mas_centerY);
    }];
    // 团队
    [self.teamLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(itemWidth));
        make.left.equalTo(line1.mas_right);
        make.centerY.equalTo(self.benefitLbl.mas_centerY);
        make.height.equalTo(@(kScaleH(itemHeigt)));
    }];
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = kHexColor(0xFFB2B2B2);
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.teamLbl.mas_right);
        make.width.equalTo(@(lineWidth));
        make.height.equalTo(@(lineHeight));
        make.centerY.equalTo(self.benefitLbl.mas_centerY);
    }];
    // 消息
    [self.msgLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(itemWidth));
        make.left.equalTo(line2.mas_right);
        make.centerY.equalTo(self.benefitLbl.mas_centerY);
        make.height.equalTo(@(kScaleH(itemHeigt)));
    }];
    
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.msgLbl.mas_bottom).offset(21.5);
        make.width.equalTo(@(kScreenWidth - 20));
        make.height.equalTo(@(kScaleH(153)));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    // 展位
    [self.boothView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cycleScrollView.mas_bottom).offset(10);
        make.width.equalTo(@((kScreenWidth- 10 * 3) / 2));
        make.height.equalTo(@(100));
        make.left.equalTo(@10);
    }];
    
    // 地主
    [self.landlordView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_centerX).offset(0);
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.width.height.equalTo(self.boothView);
    }];
    
    
    // 占个财位
    [self.placeholderWealthV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.equalTo(@(60));
        make.top.equalTo(self.boothView.mas_bottom).offset(5);
    }];
    
    self.buyBoothImagv = self.boothView;
    self.buyLanlordImgV = self.landlordView;
    
    // 地主
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"home_lanlord" ofType:@"gif"];
    NSData *data1 = [NSData dataWithContentsOfFile:path1];
    
    UIImage *gifImg1 = [UIImage sd_imageWithGIFData:data1];;
    self.buyLanlordImgV.baseImgV.image = gifImg1;
    
    // 展位
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"home_booth" ofType:@"gif"];
    NSData *data2 = [NSData dataWithContentsOfFile:path2];
    
    UIImage *gifImg2 = [UIImage sd_imageWithGIFData:data2];;
    self.buyBoothImagv.baseImgV.image = gifImg2;
    
}

- (void)setBenefitStr:(NSString *)benefitStr
{
    self.benefitLbl.upStr = kFormat(@"%@", benefitStr);
}

- (void)setMsgStr:(NSString *)msgStr
{
    self.msgLbl.upStr = msgStr;
}

- (void)setTeamStr:(NSString *)teamStr
{
    self.teamLbl.upStr = teamStr;
}

- (XMHomeHeadLbl *)benefitLbl
{
    if (!_benefitLbl) {
        _benefitLbl = [[XMHomeHeadLbl alloc] init];
        _benefitLbl.upStr = @"0.00";
        _benefitLbl.downStr = @"钱包";
        [self addSubview:_benefitLbl];
    }
    return _benefitLbl;
}

- (XMHomeHeadLbl *)teamLbl
{
    if (!_teamLbl) {
        _teamLbl = [[XMHomeHeadLbl alloc] init];
        _teamLbl.downStr = @"团队";
        _teamLbl.upStr = @"0";
        [self addSubview:_teamLbl];
    }
    return _teamLbl;
}

- (XMHomeHeadLbl *)msgLbl
{
    if (!_msgLbl) {
        _msgLbl = [[XMHomeHeadLbl alloc] init];
        _msgLbl.downStr = @"消息";
        _msgLbl.upStr = @"0";
        [self addSubviewWithFadeAnimation:_msgLbl];
    }
    return _msgLbl;
}

- (XMBuyCardView *)landlordView
{
    if (!_landlordView) {
        _landlordView = [[XMBuyCardView alloc] init];
        _landlordView.titleLbl.text = @"地主";
        _landlordView.numLbl.text = @"总数：0";
        _landlordView.leftImgV.image = kGetImage(@"landlord");
        [self addSubview:_landlordView];
    }
    return _landlordView;
}

- (XMBuyCardView *)boothView
{
    if (!_boothView) {
        _boothView = [[XMBuyCardView alloc] init];
        _boothView.titleLbl.text = @"展位";
        _boothView.numLbl.text = @"总数：0";
        _boothView.leftImgV.image = kGetImage(@"stall_holder");
        [self addSubview:_boothView];
    }
    return _boothView;
}

- (XMPlaceholderWealthView *)placeholderWealthV
{
    if (!_placeholderWealthV) {
        _placeholderWealthV = [XMPlaceholderWealthView new];
        _placeholderWealthV.layer.cornerRadius = 7;
        _placeholderWealthV.layer.masksToBounds = YES;
        [self addSubview:_placeholderWealthV];
    }
    return _placeholderWealthV;
}

- (SDCycleScrollView *)cycleScrollView
{
    if (!_cycleScrollView) {
        _cycleScrollView = [[SDCycleScrollView alloc] init];
        _cycleScrollView.layer.cornerRadius = 7;
        _cycleScrollView.layer.masksToBounds = YES;
        _cycleScrollView.placeholderImage = kGetImage(@"com_place_icon");
        [self addSubview:_cycleScrollView];
    }
    return _cycleScrollView;
}


@end
