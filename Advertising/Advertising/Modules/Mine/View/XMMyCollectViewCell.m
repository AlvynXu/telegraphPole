//
//  XMMyCollectViewCell.m
//  Advertising
//
//  Created by dingqiankun on 2019/12/30.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "XMMyCollectViewCell.h"

@interface XMMyCollectViewCell()

@property(nonatomic, strong)UILabel *titleLbl;  // 标题

@property(nonatomic,strong)UILabel *statusLbl;   // 状态

@property(nonatomic,strong)UIImageView *arrowIMgV;  //


@end

@implementation XMMyCollectViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setup];
    }
    return self;
}

// 初始化
- (void)setup
{
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@15);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.right.equalTo(self.mas_right).offset(-110);
    }];
    
    [self.arrowIMgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.width.height.equalTo(@25);
        make.centerY.equalTo(self);
    }];
    
    [self.statusLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowIMgV.mas_left).offset(0);
        make.centerY.equalTo(self);
        make.width.equalTo(@50);
        make.height.equalTo(@18);
    }];
}

- (void)setItemModel:(XMCollectItemModel *)itemModel
{
    _itemModel = itemModel;
    self.titleLbl.text = itemModel.desc;
}


- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor= kHexColor(0x101010);
        _titleLbl.font = kBoldFont(16);
        _titleLbl.numberOfLines = 0;
        [self addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UILabel *)statusLbl
{
    if (!_statusLbl) {
        _statusLbl = [UILabel new];
        _statusLbl.textColor=kHexColor(0x808080);
        _statusLbl.font=kSysFont(13);
        _statusLbl.textAlignment = NSTextAlignmentRight;
        [self addSubview:_statusLbl];
    }
    return _statusLbl;
}

- (UIImageView *)arrowIMgV
{
    if (!_arrowIMgV) {
        _arrowIMgV = [UIImageView new];
        _arrowIMgV.image = kGetImage(@"right-arrow-icon");
        [self addSubview:_arrowIMgV];
    }
    return _arrowIMgV;
}

@end
