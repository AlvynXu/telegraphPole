//
//  XMMessageBoardCell.m
//  Advertising
//
//  Created by dingqiankun on 2020/1/15.
//  Copyright © 2020 rongshu. All rights reserved.
//

#import "XMMessageBoardCell.h"

@interface XMMessageBoardCell()

@property(nonatomic, strong)UIImageView *avarImgV;  // 头像

@property(nonatomic, strong)UILabel *nameLbl;  // 名称

@property(nonatomic, strong)UILabel *contentLbl;  // 内容

@property(nonatomic, strong)UIImageView *emptyDataImgV;

@property(nonatomic, strong)UILabel *emptyDataTipsLbl; // 空数据提示

@end

@implementation XMMessageBoardCell

CGFloat top = 15;
CGFloat margin = 10;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kHexColor(0xf4f4f4);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setup];
    }
    return self;
}

// 初始化
- (void)setup
{
    CGFloat left = 15;
    [self.avarImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(left));
        make.top.equalTo(@(top));
        make.width.height.equalTo(@30);
    }];
    
    [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avarImgV.mas_right).offset(15);
        make.top.equalTo(self.avarImgV);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.equalTo(@14);
    }];
    
    [self.contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLbl);
        make.right.equalTo(self.nameLbl.mas_right);
        make.top.equalTo(self.nameLbl.mas_bottom).offset(margin);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    
    [self.emptyDataImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(104));
        make.height.equalTo(@62);
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.mas_centerY).offset(0);
    }];
    
    [self.emptyDataTipsLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(@200);
        make.height.equalTo(@18);
        make.top.equalTo(self.emptyDataImgV.mas_bottom).offset(10);
    }];
}

- (void)setIsEmptyData:(BOOL)isEmptyData
{
    _isEmptyData = isEmptyData;
    self.emptyDataImgV.hidden = !_isEmptyData;
    self.emptyDataTipsLbl.hidden = !_isEmptyData;
    [self.emptyDataImgV mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.isEmptyData) {
            make.height.equalTo(@62);
        }else{
            make.height.equalTo(@0);
        }
    }];
    
    [self.emptyDataTipsLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.isEmptyData) {
            make.height.equalTo(@18);
        }else{
            make.height.equalTo(@0);
        }
    }];
}

- (void)setItemModel:(XMProjectMessageItemModel *)itemModel
{
    _itemModel = itemModel;
    self.nameLbl.text = itemModel.phone;
    self.contentLbl.text = itemModel.message;
    self.avarImgV.image = kGetImage([kLoginManager getCurrentLevelAvarImg:itemModel.userLevel]);
}


- (UIImageView *)avarImgV
{
    if (!_avarImgV) {
        _avarImgV = [UIImageView new];
        _avarImgV.layer.cornerRadius = 15;
        [self addSubview:_avarImgV];
    }
    return _avarImgV;
}

- (UILabel *)contentLbl
{
    if (!_contentLbl) {
        _contentLbl = [UILabel new];
        _contentLbl.font = kSysFont(14);
        _contentLbl.numberOfLines = 0;
        [self addSubview:_contentLbl];
    }
    return _contentLbl;
}

- (UILabel *)nameLbl
{
    if (!_nameLbl) {
        _nameLbl = [UILabel new];
        _nameLbl.textColor = kHexColor(0x25aaff);
        _nameLbl.font = kSysFont(13);
        [self addSubview:_nameLbl];
    }
    return _nameLbl;
}

- (UIImageView *)emptyDataImgV
{
    if (!_emptyDataImgV) {
        _emptyDataImgV = [UIImageView new];
        _emptyDataImgV.image = kGetImage(@"no-data");
        [self addSubview:_emptyDataImgV];
    }
    return _emptyDataImgV;
}

- (UILabel *)emptyDataTipsLbl
{
    if (!_emptyDataTipsLbl) {
        _emptyDataTipsLbl = [UILabel new];
        _emptyDataTipsLbl.textAlignment = NSTextAlignmentCenter;
        _emptyDataTipsLbl.text = @"还没有留言，快来抢沙发~";
        _emptyDataTipsLbl.font = kSysFont(14);
        _emptyDataTipsLbl.textColor = kDisEnableColor;
        [self addSubview:_emptyDataTipsLbl];
    }
    return _emptyDataTipsLbl;
}


@end
