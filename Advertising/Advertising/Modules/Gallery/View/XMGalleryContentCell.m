//
//  XMGalleryContentCell.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/18.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMGalleryContentCell.h"

@interface XMGalleryContentCell()

@property(nonatomic, strong)UILabel *titleLbl;   // 标题内容

@property(nonatomic, strong)UIImageView *pictureImgV;  // 占位图

@property(nonatomic, strong)UILabel *pageViewLbl;  // 浏览量

@end


@implementation XMGalleryContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setItemModel:(XMCategoryListItemModel *)itemModel
{
    _itemModel = itemModel;
    self.titleLbl.text = itemModel.desc;
    [self.pictureImgV sd_setImageWithURL:[NSURL URLWithString:itemModel.bannerPath]];
    self.pageViewLbl.text = kFormat(@"%zd浏览", itemModel.views);
}


// 初始化
- (void)setup
{
   
    [self.pictureImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-13);
        make.width.equalTo(@135);
        make.height.equalTo(@80);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@13);
        make.top.equalTo(@15);
        make.right.equalTo(self.pictureImgV.mas_left).offset(-7);
        make.height.mas_lessThanOrEqualTo(68);
    }];
    
    [self.pageViewLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLbl);
        make.height.equalTo(@15);
        make.right.equalTo(self.titleLbl.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    
    UIView *lineV = [[UIView alloc] init];
    lineV.backgroundColor = kHexColor(0xD9D9D9);
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@1);
        make.bottom.equalTo(self.mas_bottom);
    }];
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
        _pictureImgV.layer.cornerRadius = 3.f;
        _pictureImgV.layer.masksToBounds = YES;
        [self addSubview:_pictureImgV];
    }
    return _pictureImgV;
}




@end
