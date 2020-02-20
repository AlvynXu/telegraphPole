
//
//  XMBoothRecordCell.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/5.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMBoothRecordCell.h"

@interface XMBoothRecordCell()

@property(nonatomic, strong)UIImageView *baseImgV;

@property(nonatomic, strong)UILabel *numLbl;

@property(nonatomic, strong)UILabel *addressLbl;

@property(nonatomic, strong)UILabel *validityLbl;

@property(nonatomic, strong)UILabel *tagLbl;  // 标签

@property(nonatomic, strong)UIView *bottomeV;

@property(nonatomic, strong)UILabel *surplusLbl;  // 出租剩余时间

@property(nonatomic, strong)UILabel *titleLbl;  // 标题

@property(nonatomic, strong)UIImageView *arrowImgV;

@end

@implementation XMBoothRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kMainBackGroundColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setup];
    }
    return self;
}

- (void)setItemModel:(XMBoothRecordsItemModel *)itemModel
{
    _itemModel = itemModel;
    [self resetLayout:itemModel];
    NSString *districtDot = kFormat(@"· %@", itemModel.district);
    NSString *streetDot = kFormat(@"· %@", itemModel.street);
    self.addressLbl.text = kFormat(@"%@ %@ %@", itemModel.city, districtDot, streetDot);
    self.numLbl.text = itemModel.code;
    self.validityLbl.text = kFormat(@"剩余：%zd天", itemModel.days);
    self.tagLbl.backgroundColor = itemModel.statusColor;
    self.tagLbl.text = itemModel.statusStr;
    self.titleLbl.text = [NSString isEmpty:itemModel.desc]?@"未发布广告":itemModel.desc;
    self.surplusLbl.text = kFormat(@"出租剩余%ld天%ld时", itemModel.rentHours/24, itemModel.rentHours%24);
}


// 重新布局
- (void)resetLayout:(XMBoothRecordsItemModel *)itemModel
{
    if (itemModel.useStatus == 4 || itemModel.useStatus == 5) {  // 已租
        [self.surplusLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@13);
        }];
        [self.titleLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.surplusLbl.mas_bottom).offset(11.5);
        }];
        self.surplusLbl.hidden = NO;
        self.bottomeV.hidden = NO;
        if ([NSString isEmpty:itemModel.desc]) {
            self.titleLbl.textColor = kHexColor(0xFF999999);
            self.arrowImgV.hidden = YES;
            self.bottomeV.userInteractionEnabled = NO;
        }else{  // 租用
            self.titleLbl.textColor = kHexColor(0xFF333333);
            self.arrowImgV.hidden = NO;
            self.bottomeV.userInteractionEnabled = YES;
        }
    }else if (itemModel.useStatus == 6) {   // 广告
        [self.surplusLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        [self.titleLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.surplusLbl.mas_bottom).offset(0);
        }];
        self.surplusLbl.hidden = YES;
        if ([NSString isEmpty:itemModel.desc]) {
            self.titleLbl.textColor = kHexColor(0xFF999999);
            self.arrowImgV.hidden = YES;
            self.bottomeV.userInteractionEnabled = NO;
        }else{
            self.titleLbl.textColor = kHexColor(0xFF333333);
            self.arrowImgV.hidden = NO;
            self.bottomeV.userInteractionEnabled = YES;
        }
    }else{  // 闲置
        
        [self.surplusLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@13);
        }];
        [self.titleLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.surplusLbl.mas_bottom).offset(11.5);
        }];
        self.surplusLbl.hidden = YES;
        self.bottomeV.hidden = YES;
        self.bottomeV.userInteractionEnabled = NO;
        self.titleLbl.textColor = kHexColor(0xFF333333);
    }
}

// 初始化
- (void)setup
{
    [self.baseImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.height.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.addressLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@17);
        make.height.equalTo(@16);
        make.width.equalTo(@(kScreenWidth - 30));
        make.left.equalTo(self.baseImgV).offset(20);
    }];
    
    [self.numLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressLbl.mas_bottom).offset(6);
        make.height.equalTo(@13);
        make.width.equalTo(@(kScreenWidth - 30));
        make.left.equalTo(self.baseImgV).offset(20);
    }];
    
    [self.tagLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.baseImgV).offset(10);
        make.height.equalTo(@22);
        make.width.equalTo(@50);
        make.centerY.equalTo(self.addressLbl);
    }];

    
    [self.validityLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numLbl.mas_bottom).offset(6);
        make.height.equalTo(@13);
        make.width.equalTo(@(kScreenWidth - 30));
        make.left.equalTo(self.baseImgV).offset(20);
    }];
    
    [self.bottomeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.validityLbl.mas_bottom).offset(20);
        make.left.right.equalTo(self.addressLbl);
        make.right.equalTo(self.addressLbl);
        make.bottom.equalTo(self.baseImgV.mas_bottom);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTapAction)];
    [self.bottomeV addGestureRecognizer:tap];
    
    UIView *lineV = [UIView new];
    lineV.backgroundColor = kHexColor(0xFFE3E3E3);
    [self.bottomeV addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.bottomeV);
        make.height.equalTo(@0.5);
    }];
    
    [self.surplusLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineV.mas_bottom).offset(15);
        make.height.equalTo(@13);
        make.left.right.equalTo(lineV);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.surplusLbl.mas_bottom).offset(11.5);
        make.height.equalTo(@15);
        make.left.equalTo(lineV);
        make.right.equalTo(self.arrowImgV.mas_left).offset(-10);
    }];
    
    [self.arrowImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomeV);
        make.right.equalTo(self.baseImgV.mas_right).offset(-10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
}

// 单击事件
- (void)handTapAction
{
    if (self.tapBlock) {
        self.tapBlock(self.index);
    }
}

- (UIImageView *)baseImgV
{
    if (!_baseImgV) {
        _baseImgV = [[UIImageView alloc] init];
        _baseImgV.layer.borderColor = kHexColor(0xFFE3E3E3).CGColor;
        _baseImgV.layer.borderWidth = 0.5;
        _baseImgV.layer.cornerRadius = 7;
        _baseImgV.layer.masksToBounds = YES;
        _baseImgV.userInteractionEnabled = YES;
        _baseImgV.backgroundColor = UIColor.whiteColor;
        [self addSubview:_baseImgV];
    }
    return _baseImgV;
}

- (UILabel *)numLbl
{
    if (!_numLbl) {
        _numLbl = [UILabel new];
        _numLbl.textColor = kHexColor(0xFF999999);
        _numLbl.font = kBoldFont(12);
        [self.baseImgV addSubview:_numLbl];
    }
    return _numLbl;
}

- (UILabel *)addressLbl
{
    if (!_addressLbl) {
        _addressLbl = [UILabel new];
        _addressLbl.textColor = kHexColor(0xFF333333);
        _addressLbl.font = kSysFont(15);
        [self.baseImgV addSubview:_addressLbl];
    }
    return _addressLbl;
}

- (UILabel *)validityLbl
{
    if (!_validityLbl) {
        _validityLbl = [UILabel new];
        _validityLbl.textColor = kHexColor(0xFF999999);
        _validityLbl.font = kSysFont(12);
        [self.baseImgV addSubview:_validityLbl];
    }
    return _validityLbl;
}

- (UILabel *)tagLbl
{
    if (!_tagLbl) {
        _tagLbl = [UILabel new];
        _tagLbl.textColor = kHexColor(0xffffff);
        _tagLbl.font = kSysFont(12);
        _tagLbl.layer.cornerRadius = 11;
        _tagLbl.layer.masksToBounds = YES;
        _tagLbl.textAlignment = NSTextAlignmentCenter;
        [self.baseImgV addSubview:_tagLbl];
    }
    return _tagLbl;
}

- (UIView *)bottomeV
{
    if (!_bottomeV) {
        _bottomeV = [UIView new];
        [self.baseImgV addSubview:_bottomeV];
    }
    return _bottomeV;
}

- (UILabel *)surplusLbl
{
    if (!_surplusLbl) {
        _surplusLbl = [UILabel new];
        _surplusLbl.textColor = kHexColor(0xFFF85F53);
        _surplusLbl.font = kSysFont(12);
        [self.bottomeV addSubview:_surplusLbl];
    }
    return _surplusLbl;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.textColor = kHexColor(0xFF333333);
        _titleLbl.font = kSysFont(14);
        _titleLbl.text = @"未发布广告";
        [self.bottomeV addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UIImageView *)arrowImgV
{
    if (!_arrowImgV) {
        _arrowImgV = [[UIImageView alloc] init];
        _arrowImgV.image = kGetImage(@"right-arrow-icon");
        [self.bottomeV addSubview:_arrowImgV];
    }
    return _arrowImgV;
}


@end
