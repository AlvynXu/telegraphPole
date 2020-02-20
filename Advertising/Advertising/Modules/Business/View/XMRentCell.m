//
//  XMRentView.m
//  Advertising
//
//  Created by dingqiankun on 2020/1/2.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import "XMRentCell.h"

@interface XMRentCell()

@property(nonatomic, strong)UIImageView *baseImgV;

@property(nonatomic, strong)UILabel *unitPriceLbl;  //单价

@property(nonatomic, strong)UILabel *priceTipsLbl;  // 单价提示

@property(nonatomic, strong)UILabel *dayLbl;  // 天数

@property(nonatomic,strong)UILabel *dayTipsLbl;  //天数提示

@property(nonatomic, strong)UILabel *typeLbl;  // 我的求租

@property(nonatomic, strong)UILabel *scaleLbl;  // 比例值

@property(nonatomic, strong)UIProgressView *progressV;

@end

@implementation XMRentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setup];
    }
    return self;
}

// 初始化
- (void)setup
{
    CGFloat left = 17;
    [self.baseImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(left));
        make.right.equalTo(self.mas_right).offset(-left);
        make.top.bottom.equalTo(self);
    }];
    
    self.baseImgV.layer.shadowColor = kHexColorA(0x1A000000, 0.7).CGColor;
    //剪切边界 如果视图上的子视图layer超出视图layer部分就截取掉 如果添加阴影这个属性必须是NO 不然会把阴影切掉
    self.baseImgV.layer.masksToBounds = NO;
    //阴影半径，默认3
    self.baseImgV.layer.shadowRadius = 2;
    //shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.baseImgV.layer.shadowOffset = CGSizeMake(0.0f,0.0f);
    // 阴影透明度，默认0
    self.baseImgV.layer.shadowOpacity = 0.2f;
//    self.baseImgV.layer.masksToBounds = YES;
    
    
    
    [self.unitPriceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.left.equalTo(@30);
        make.width.equalTo(@100);
        make.height.equalTo(@17);
    }];
    
    [self.priceTipsLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.unitPriceLbl);
        make.top.equalTo(self.unitPriceLbl.mas_bottom).offset(5);
        make.width.equalTo(@50);
        make.height.equalTo(@13);
    }];

    [self.dayLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.unitPriceLbl.mas_right).offset(20);
        make.centerY.equalTo(self.unitPriceLbl);
        make.height.with.equalTo(self.unitPriceLbl);
    }];

    [self.dayTipsLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.priceTipsLbl);
        make.width.height.equalTo(self.priceTipsLbl);
        make.left.equalTo(self.dayLbl);
    }];

    [self.scaleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceTipsLbl);
        make.bottom.equalTo(self.baseImgV.mas_bottom).offset(-15);
        make.width.equalTo(@200);
        make.height.equalTo(@13);
    }];

    [self.typeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.baseImgV);
        make.height.equalTo(@18);
        make.width.equalTo(@90);
        make.right.equalTo(self.baseImgV.mas_right).offset(-29);
    }];
    
    [self.sallBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.baseImgV);
        make.height.equalTo(@34);
        make.width.equalTo(@81);
        make.right.equalTo(self.baseImgV.mas_right).offset(-19);
    }];
    
    [self.progressV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@3);
        make.right.equalTo(self.baseImgV.mas_right).offset(-3);
        make.height.equalTo(@2);
        make.bottom.equalTo(self.baseImgV).offset(0);
    }];
}

- (void)setMyRentModel:(XMMyRentItemModel *)myRentModel
{
    _myRentModel = myRentModel;
    self.unitPriceLbl.text = kFormat(@"￥%.2lf", myRentModel.price);
    self.dayLbl.text = kFormat(@"%@", kFormat(@"%zd", myRentModel.days));
    self.scaleLbl.text = kFormat(@"%zd/%zd", myRentModel.soldCount, myRentModel.totalCount);
    self.progressV.progress = myRentModel.soldCount/(CGFloat)myRentModel.totalCount;
    
    self.typeLbl.hidden = NO;
    self.sallBtn.hidden=YES;
}

- (void)setItemModel:(XMRentItemModel *)itemModel
{
    _itemModel = itemModel;
    self.unitPriceLbl.text = kFormat(@"￥%.2lf", itemModel.price);
    self.dayLbl.text = kFormat(@"%@", kFormat(@"%zd", itemModel.days));
    self.scaleLbl.text = kFormat(@"%zd/%zd", itemModel.soldCount, itemModel.totalCount);
    self.progressV.progress = itemModel.soldCount/(CGFloat)itemModel.totalCount;
    
    self.sallBtn.hidden=NO;
    self.typeLbl.hidden = YES;
}


- (UILabel *)unitPriceLbl
{
    if (!_unitPriceLbl) {
        _unitPriceLbl = [UILabel new];
        _unitPriceLbl.font = kSysFont(18);
        _unitPriceLbl.textColor = kHexColor(0xFF333333);
        [self.baseImgV addSubview:_unitPriceLbl];
    }
    return _unitPriceLbl;
}

- (UILabel *)priceTipsLbl
{
    if (!_priceTipsLbl) {
        _priceTipsLbl = [UILabel new];
        _priceTipsLbl.text = @"单价";
        _priceTipsLbl.textColor = kHexColor(0xFF999999);
        _priceTipsLbl.font = kSysFont(12);
        [self.baseImgV addSubview:_priceTipsLbl];
    }
    return _priceTipsLbl;
}

- (UILabel *)dayLbl
{
    if (!_dayLbl) {
        _dayLbl  =[UILabel new];
        _dayLbl.textColor = kHexColor(0xFF333333);
        _dayLbl.font = kSysFont(18);
        [self.baseImgV addSubview:_dayLbl];
    }
    return _dayLbl;
}

- (UILabel *)typeLbl
{
    if (!_typeLbl) {
        _typeLbl = [UILabel new];
        _typeLbl.textColor = kHexColor(0xFF333333);
        _typeLbl.font = kSysFont(16);
        _typeLbl.text = @"#我的求租";
        [self.baseImgV addSubview:_typeLbl];
    }
    return _typeLbl;
}

- (UIButton *)sallBtn
{
    if (!_sallBtn) {
        _sallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sallBtn.titleLabel.font = kSysFont(15);
        [_sallBtn setTitle:@"租给ta" forState:UIControlStateNormal];
        _sallBtn.layer.cornerRadius = 17;
        _sallBtn.layer.masksToBounds = YES;
        _sallBtn.backgroundColor = kMainColor;
        [self.baseImgV addSubview:_sallBtn];
    }
    return _sallBtn;
}

- (UILabel *)scaleLbl
{
    if (!_scaleLbl) {
        _scaleLbl = [UILabel new];
        _scaleLbl.textColor = kHexColor(0xFFF85F53);
        _scaleLbl.font = kSysFont(10);
        [self.baseImgV addSubview:_scaleLbl];
    }
    return _scaleLbl;
}

- (UILabel *)dayTipsLbl
{
    if (!_dayTipsLbl) {
        _dayTipsLbl = [UILabel new];
        _dayTipsLbl.textColor = kHexColor(0xFF999999);
        _dayTipsLbl.font = kSysFont(12);
        _dayTipsLbl.text = @"天数";
        [self addSubview:_dayTipsLbl];
    }
    return _dayTipsLbl;
}

- (UIImageView *)baseImgV
{
    if (!_baseImgV) {
        _baseImgV = [UIImageView new];
        _baseImgV.backgroundColor = UIColor.whiteColor;
        _baseImgV.layer.cornerRadius = 7;
        _baseImgV.userInteractionEnabled = YES;
        _baseImgV.layer.masksToBounds = YES;
        [self addSubview:_baseImgV];
    }
    return _baseImgV;
}

- (UIProgressView *)progressV
{
    if (!_progressV) {
        _progressV = [[UIProgressView alloc] init];
        _progressV.backgroundColor = kHexColor(0xffffff);
        _progressV.trackTintColor = kHexColorA(0x000000, 0.1);
        _progressV.progress = 0.35;
        _progressV.progressTintColor = kHexColor(0xFFF85F53);
        _progressV.layer.cornerRadius = 1;
        [self.baseImgV addSubview:_progressV];
    }
    return _progressV;
}


@end
