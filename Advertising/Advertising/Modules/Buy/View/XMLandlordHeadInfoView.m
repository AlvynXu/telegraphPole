//
//  XMLandlordHeadInfoView.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/25.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMLandlordHeadInfoView.h"

@interface XMLandlordHeadInfoView()

@property(nonatomic, strong)UILabel *lanlordNumLbl;  // 总土地

@property(nonatomic, strong)UIView *headBaseV;

@property(nonatomic, strong)UILabel *privilegeLbl; //特权展位

@property(nonatomic, strong)UILabel *noDeblockLbl; // 未解锁

@end

@implementation XMLandlordHeadInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        [self setup];
    }
    return self;
}

// 初始化
- (void)setup
{
    CGFloat left = 15;
    CGFloat top = 7;
    CGFloat leftMargin = 10;
    [self.lanlordNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(left));
        make.top.equalTo(@(top));
        make.right.equalTo(self.mas_right).offset(-left);
        make.height.equalTo(@17);
    }];
    
    [self.headBaseV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(left));
        make.height.equalTo(@58);
        make.right.equalTo(self.lanlordNumLbl);
        make.top.equalTo(self.lanlordNumLbl.mas_bottom).offset(7);
    }];
    
    [self.goBlockBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.headBaseV.mas_right).offset(-leftMargin);
        make.height.equalTo(@35);
        make.width.equalTo(@80);
        make.centerY.equalTo(self.headBaseV.mas_centerY);
    }];
    
    [self.privilegeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(leftMargin));
        make.right.equalTo(self.goBlockBtn.mas_left).offset(-10);
        make.top.equalTo(@7);
        make.height.equalTo(@18);
    }];
    
    [self.noDeblockLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(leftMargin));
        make.right.equalTo(self.goBlockBtn.mas_left).offset(-10);
        make.top.equalTo(self.privilegeLbl.mas_bottom).offset(6);
        make.height.equalTo(self.privilegeLbl.mas_height);
    }];
}

- (void)setTotal:(NSInteger)total
{
    _total = total;
    self.lanlordNumLbl.text = kFormat(@"当前有 %zd 个土地", total);
    [self.lanlordNumLbl changeStr:kFormat(@"%zd", total) color:kMainColor font:kSysFont(15)];
}

- (void)setGetNumModel:(XMBoothRecordGetNumModel *)getNumModel
{
    _getNumModel = getNumModel;
    if (getNumModel) {
        self.privilegeLbl.text= kFormat(@"总特权展位：%@个", getNumModel.total);
        self.noDeblockLbl.text = kFormat(@"未解锁展位：%@个", getNumModel.canUsed);
        [self.noDeblockLbl changeStr:getNumModel.canUsed color:kMainColor font:kSysFont(15)];
        if (getNumModel.canUsed.integerValue == 0) {
            self.goBlockBtn.backgroundColor = kHexColor(0xD5D5D5);
            self.goBlockBtn.enabled = NO;
        }else{
            self.goBlockBtn.backgroundColor = kHexColor(0x03aa41);
            self.goBlockBtn.enabled = YES;
        }
    }
}

- (UILabel *)lanlordNumLbl
{
    if (!_lanlordNumLbl) {
        _lanlordNumLbl = [UILabel new];
        _lanlordNumLbl.textColor = kHexColor(0x101010);
        _lanlordNumLbl.font = kSysFont(15);
        [self addSubview:_lanlordNumLbl];
    }
    return _lanlordNumLbl;
}

- (UIView *)headBaseV
{
    if (!_headBaseV) {
        _headBaseV = [UIView new];
        _headBaseV.layer.borderWidth = 1;
        _headBaseV.layer.borderColor = kHexColor(0xB9B9B9).CGColor;
        _headBaseV.layer.cornerRadius = 5;
        [self addSubview:_headBaseV];
    }
    return _headBaseV;
}

- (UILabel *)privilegeLbl
{
    if (!_privilegeLbl) {
        _privilegeLbl = [UILabel new];
        _privilegeLbl.textColor = kHexColor(0x101010);
        _privilegeLbl.font = kSysFont(15);
        [self.headBaseV addSubview:_privilegeLbl];
    }
    return _privilegeLbl;
}

- (UILabel *)noDeblockLbl
{
    if (!_noDeblockLbl) {
        _noDeblockLbl = [UILabel new];
        _noDeblockLbl.textColor = kHexColor(0x101010);
        _noDeblockLbl.font = kSysFont(15);
        [self.headBaseV addSubview:_noDeblockLbl];
    }
    return _noDeblockLbl;
}

- (UIButton *)goBlockBtn
{
    if (!_goBlockBtn) {
        _goBlockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goBlockBtn setTitle:@"去解锁" forState:UIControlStateNormal];
        _goBlockBtn.titleLabel.font = kSysFont(16);
        _goBlockBtn.backgroundColor = kHexColor(0x03aa41);
        _goBlockBtn.layer.cornerRadius = 17.5;
        [self.headBaseV addSubview:_goBlockBtn];
    }
    return _goBlockBtn;
}



@end
