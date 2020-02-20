//
//  XMHomeCell.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/16.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMHomeCell.h"

@interface XMHomeCell ()

@property(nonatomic, strong)UILabel *titleLbl;   // 标题内容

@property(nonatomic, strong)UIImageView *pictureImgV;  // 占位图

@property(nonatomic, strong)UILabel *pageViewLbl;  // 浏览量

@property(nonatomic, strong)UIImageView *emptyDataImgV;

@property(nonatomic, strong)UILabel *emptyDataTipsLbl; // 空数据提示

@end

@implementation XMHomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

// 初始化
- (void)setup
{
    
    
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@13);
        make.top.equalTo(@15);
        make.right.equalTo(self.pictureImgV.mas_left).offset(-7);
        make.height.mas_lessThanOrEqualTo(78);
    }];
    
    [self.pictureImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-13);
        make.width.equalTo(@135);
        make.height.equalTo(@80);
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    
    [self.pageViewLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLbl);
        make.height.equalTo(@15);
        make.right.equalTo(self.titleLbl.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(-13);
    }];
    
    UIView *lineV = [[UIView alloc] init];
    self.lineV = lineV;
    lineV.backgroundColor = kHexColor(0xD9D9D9);
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@1);
        make.bottom.equalTo(self.mas_bottom);
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


- (void)setItemModel:(XMHeadLineItemModel *)itemModel
{
    _itemModel = itemModel;
    self.titleLbl.text = itemModel.desc;
    [self.pictureImgV sd_setImageWithURL:[NSURL URLWithString:itemModel.bannerPath]placeholderImage:kGetImage(@"com_place_icon")];
    self.pageViewLbl.text = kFormat(@"%zd浏览", itemModel.views);
}


- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.numberOfLines = 0;
        _titleLbl.font = kSysFont(16);
        _titleLbl.textColor = kHexColor(0x101010);
        [self addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UILabel *)pageViewLbl
{
    if (!_pageViewLbl) {
        _pageViewLbl = [[UILabel alloc] init];
        _pageViewLbl.textColor = kHexColor(0xBBBBBB);
        _pageViewLbl.font = kSysFont(14);
        [self addSubview:_pageViewLbl];
    }
    return _pageViewLbl;
}

- (UIImageView *)pictureImgV
{
    if (!_pictureImgV) {
        _pictureImgV = [[UIImageView alloc] init];
        _pictureImgV.layer.cornerRadius = 3;
        _pictureImgV.layer.masksToBounds = YES;
        [self addSubview:_pictureImgV];
    }
    return _pictureImgV;
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
        _emptyDataTipsLbl.text = @"暂没有头条~";
        _emptyDataTipsLbl.font = kSysFont(14);
        _emptyDataTipsLbl.textColor = kDisEnableColor;
        [self addSubview:_emptyDataTipsLbl];
    }
    return _emptyDataTipsLbl;
}



@end
